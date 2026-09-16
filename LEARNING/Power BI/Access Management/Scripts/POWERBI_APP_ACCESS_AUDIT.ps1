Install-Module MicrosoftPowerBIMgmt -Scope CurrentUser
Install-Module Microsoft.Graph.Authentication -Scope CurrentUser
Install-Module Microsoft.Graph.Groups -Scope CurrentUser
Install-Module Microsoft.Graph.Users -Scope CurrentUser


# ============================================================
# POWER BI APP ACCESS AUDIT
#
# Output:
#   PowerBI-App-Access.csv
#
# The script:
#   1. Gets principals with access to a Power BI App
#   2. Identifies Users and Groups
#   3. Expands Entra ID groups
#   4. Recursively expands nested groups
#   5. Produces an individual-user access list
#
# REQUIREMENTS:
#   - Fabric/Power BI Administrator for the Power BI Admin API
#   - Permission to read Entra ID group membership
# ============================================================


# ------------------------------------------------------------
# CONFIGURATION
# ------------------------------------------------------------

# SAMPLE APP ID
# Replace this with your real Power BI App ID.
$AppId = "d1d87da3-e253-489b-b760-949a5b360909"

# Output file
$OutputFile = ".\PowerBI-App-Access.csv"


# ------------------------------------------------------------
# CONNECT TO POWER BI
# ------------------------------------------------------------

Write-Host ""
Write-Host "Connecting to Power BI..." -ForegroundColor Cyan

Connect-PowerBIServiceAccount


# ------------------------------------------------------------
# GET POWER BI APP USERS / GROUPS
# ------------------------------------------------------------

Write-Host "Getting Power BI App access..." -ForegroundColor Cyan

$Url = "https://api.powerbi.com/v1.0/myorg/admin/apps/$AppId/users"

$response = Invoke-PowerBIRestMethod `
    -Url $Url `
    -Method Get

$appPrincipals = ($response | ConvertFrom-Json).value

if (-not $appPrincipals) {
    Write-Host ""
    Write-Host "No principals were returned for this Power BI App." `
        -ForegroundColor Yellow

    exit
}

Write-Host ""
Write-Host "Principals found: $($appPrincipals.Count)" `
    -ForegroundColor Green


# ------------------------------------------------------------
# CONNECT TO MICROSOFT GRAPH
# ------------------------------------------------------------

Write-Host ""
Write-Host "Connecting to Microsoft Graph..." -ForegroundColor Cyan

Connect-MgGraph `
    -Scopes "Group.Read.All","GroupMember.Read.All","User.Read.All"


# ------------------------------------------------------------
# CACHE TO AVOID READING THE SAME GROUP MULTIPLE TIMES
# ------------------------------------------------------------

$GroupCache = @{}

$Results = New-Object System.Collections.Generic.List[Object]


# ------------------------------------------------------------
# FUNCTION:
# RECURSIVELY EXPAND A GROUP
# ------------------------------------------------------------

function Expand-GroupMembers {

    param(
        [Parameter(Mandatory=$true)]
        [string]$GroupId,

        [Parameter(Mandatory=$true)]
        [string]$GroupName,

        [string]$ParentGroupName = $GroupName,

        [string]$RootGroupName = $GroupName,

        [int]$Depth = 0
    )


    # Prevent infinite loops caused by circular/nested groups
    if ($Depth -gt 20) {

        Write-Host `
            "Maximum group nesting depth reached for $GroupName" `
            -ForegroundColor Yellow

        return
    }


    # --------------------------------------------------------
    # Check cache
    # --------------------------------------------------------

    if ($GroupCache.ContainsKey($GroupId)) {

        $members = $GroupCache[$GroupId]

    }
    else {

        Write-Host `
            "Reading members of group: $GroupName" `
            -ForegroundColor DarkGray

        try {

            $members = Get-MgGroupMember `
                -GroupId $GroupId `
                -All `
                -ErrorAction Stop

            $GroupCache[$GroupId] = $members

        }
        catch {

            Write-Host ""
            Write-Host `
                "ERROR reading group: $GroupName" `
                -ForegroundColor Red

            Write-Host $_.Exception.Message `
                -ForegroundColor Red

            return
        }
    }


    # --------------------------------------------------------
    # Process each member
    # --------------------------------------------------------

    foreach ($member in $members) {

        $memberId = $member.Id


        # ----------------------------------------------------
        # Try to determine whether the member is a User
        # ----------------------------------------------------

        try {

            $user = Get-MgUser `
                -UserId $memberId `
                -Property "id,displayName,userPrincipalName,mail,accountEnabled" `
                -ErrorAction Stop


            if ($user) {

                $Results.Add(
                    [PSCustomObject]@{

                        AppId            = $AppId
                        PrincipalType    = "User"
                        UserDisplayName  = $user.DisplayName
                        UserPrincipalName = $user.UserPrincipalName
                        Email            = $user.Mail
                        AccountEnabled   = $user.AccountEnabled
                        AccessSource     = "Group"
                        RootGroup        = $RootGroupName
                        GroupPath        = "$ParentGroupName"
                        GroupDepth       = $Depth
                    }
                )

                continue
            }

        }
        catch {
            # Not a user; continue and test whether it is a group
        }


        # ----------------------------------------------------
        # Try to determine whether the member is a Group
        # ----------------------------------------------------

        try {

            $nestedGroup = Get-MgGroup `
                -GroupId $memberId `
                -Property "id,displayName" `
                -ErrorAction Stop


            if ($nestedGroup) {

                $newPath = "$ParentGroupName -> $($nestedGroup.DisplayName)"


                Expand-GroupMembers `
                    -GroupId $nestedGroup.Id `
                    -GroupName $nestedGroup.DisplayName `
                    -ParentGroupName $newPath `
                    -RootGroupName $RootGroupName `
                    -Depth ($Depth + 1)

            }

        }
        catch {
            # Ignore objects that aren't users or groups
        }
    }
}


# ------------------------------------------------------------
# PROCESS POWER BI APP PRINCIPALS
# ------------------------------------------------------------

foreach ($principal in $appPrincipals) {


    # ========================================================
    # DIRECT USER
    # ========================================================

    if ($principal.principalType -eq "User") {

        $Results.Add(
            [PSCustomObject]@{

                AppId             = $AppId
                PrincipalType     = "User"
                UserDisplayName   = $principal.displayName
                UserPrincipalName = $principal.emailAddress
                Email             = $principal.emailAddress
                AccountEnabled    = ""
                AccessSource      = "Direct"
                RootGroup         = ""
                GroupPath         = ""
                GroupDepth        = 0
            }
        )

        continue
    }


    # ========================================================
    # SECURITY / M365 GROUP
    # ========================================================

    if ($principal.principalType -eq "Group") {

        Write-Host ""
        Write-Host `
            "Expanding Power BI group: $($principal.displayName)" `
            -ForegroundColor Cyan


        $groupId = $principal.graphId


        if (-not $groupId) {

            Write-Host `
                "No Graph ID returned for group $($principal.displayName)" `
                -ForegroundColor Yellow

            continue
        }


        Expand-GroupMembers `
            -GroupId $groupId `
            -GroupName $principal.displayName `
            -RootGroupName $principal.displayName `
            -ParentGroupName $principal.displayName
    }


    # ========================================================
    # ORGANIZATION-WIDE ACCESS
    # ========================================================

    if ($principal.principalType -eq "None") {

        $Results.Add(
            [PSCustomObject]@{

                AppId             = $AppId
                PrincipalType     = "Organization"
                UserDisplayName   = "ALL USERS IN ORGANIZATION"
                UserPrincipalName = ""
                Email             = ""
                AccountEnabled    = ""
                AccessSource      = "Organization-wide"
                RootGroup         = ""
                GroupPath         = ""
                GroupDepth        = 0
            }
        )
    }
}


# ------------------------------------------------------------
# REMOVE DUPLICATES
# ------------------------------------------------------------

$FinalResults = $Results |
    Sort-Object UserPrincipalName, RootGroup, GroupPath |
    Select-Object -Unique `
        AppId,
        PrincipalType,
        UserDisplayName,
        UserPrincipalName,
        Email,
        AccountEnabled,
        AccessSource,
        RootGroup,
        GroupPath,
        GroupDepth


# ------------------------------------------------------------
# EXPORT
# ------------------------------------------------------------

$FinalResults |
    Export-Csv `
        -Path $OutputFile `
        -NoTypeInformation `
        -Encoding UTF8


# ------------------------------------------------------------
# SUMMARY
# ------------------------------------------------------------

Write-Host ""
Write-Host "============================================" `
    -ForegroundColor Green

Write-Host "Power BI App Access Audit Complete" `
    -ForegroundColor Green

Write-Host "============================================" `
    -ForegroundColor Green

Write-Host ""
Write-Host "App ID: $AppId"
Write-Host "Unique users/principals: $($FinalResults.Count)"
Write-Host "Output file: $OutputFile"

Write-Host ""
Write-Host "User count:" `
    -ForegroundColor Cyan

$FinalResults |
    Where-Object {
        $_.PrincipalType -eq "User"
    } |
    Select-Object -ExpandProperty UserPrincipalName -Unique |
    Measure-Object |
    Select-Object -ExpandProperty Count

Write-Host ""
Write-Host "Report saved successfully." `
    -ForegroundColor Green
