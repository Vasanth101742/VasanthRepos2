#------------------------------------------------------------
# Power BI Tenant Report Usage Extraction

#Method 1: 
# param(
#     [Parameter(Mandatory=$true)]
#     [string]$TenantId,

#     [Parameter(Mandatory=$true)]
#     [string]$ClientId,

#     [Parameter(Mandatory=$true)]
#     [string]$ClientSecret,

#     [Parameter(Mandatory=$true)]
#     [datetime]$StartDate,

#     [Parameter(Mandatory=$true)]
#     [datetime]$EndDate,

#     [string]$OutputFolder = "C:\PowerBI\Usage"
# )



#Method 2: Use a configuration file (config.ps1) with the following content:

$configFile = "C:\Users\vasanthk\OneDrive - ELGi Equipments Ltd\Desktop\Desktop Files\Vasanth_GitDesktop\Flatris-LAB\Flatris-LAB\VasanthRepos2\LEARNING\Migration\UsageMetrics\config.ps1"

if (-not (Test-Path $configFile)) {
    throw "Configuration file not found: $configFile"
}

. $configFile

$TenantId     = $Config.TenantId
$ClientId     = $Config.ClientId
$ClientSecret = $Config.ClientSecret
$StartDate    = [datetime]$Config.StartDate
$EndDate      = [datetime]$Config.EndDate
$OutputFolder = $Config.OutputFolder





# ------------------------------------------------------------
# Configuration
# ------------------------------------------------------------

$ErrorActionPreference = "Stop"

$OutputFile = Join-Path `
    $OutputFolder `
    ("PowerBI_Report_Usage_{0}.xlsx" -f (Get-Date -Format "yyyyMMdd_HHmmss"))

New-Item `
    -ItemType Directory `
    -Path $OutputFolder `
    -Force | Out-Null


# ------------------------------------------------------------
# Authentication
# ------------------------------------------------------------

$TokenUrl = "https://login.microsoftonline.com/$TenantId/oauth2/v2.0/token"

$TokenBody = @{
    client_id     = $ClientId
    client_secret = $ClientSecret
    scope         = "https://analysis.windows.net/powerbi/api/.default"
    grant_type    = "client_credentials"
}

Write-Host "Authenticating..." -ForegroundColor Cyan

$TokenResponse = Invoke-RestMethod `
    -Uri $TokenUrl `
    -Method Post `
    -Body $TokenBody `
    -ContentType "application/x-www-form-urlencoded"

$AccessToken = $TokenResponse.access_token

$Headers = @{
    Authorization = "Bearer $AccessToken"
}


# ------------------------------------------------------------
# Helper function
# ------------------------------------------------------------

function Invoke-PowerBIRequest {

    param(
        [Parameter(Mandatory=$true)]
        [string]$Uri
    )

    $maxRetries = 5
    $retry = 0

    while ($true) {

        try {

            return Invoke-RestMethod `
                -Uri $Uri `
                -Headers $Headers `
                -Method Get

        }
        catch {

            $retry++

            if ($retry -ge $maxRetries) {
                throw
            }

            Write-Warning "API request failed. Retrying in 30 seconds..."

            Start-Sleep -Seconds 30
        }
    }
}


# ------------------------------------------------------------
# Get all reports
# ------------------------------------------------------------

Write-Host ""
Write-Host "Retrieving all Power BI reports..." -ForegroundColor Cyan

$Reports = @()

$skip = 0
$pageSize = 5000

do {

    $ReportsUrl =
        "https://api.powerbi.com/v1.0/myorg/admin/reports" +
        #"https://api.powerbi.com/v1.0/ELGi%20Equipments%20Ltd/admin/reports" +
        # "https://api.powerbi.com/v1.0/ELGi-BI/admin/reports" +
        "?`$top=$pageSize&`$skip=$skip"

    Write-Host "Retrieving reports. Skip = $skip"

    $Response = Invoke-PowerBIRequest -Uri $ReportsUrl

    if ($Response.value) {

        $Reports += $Response.value
    }

    $count = @($Response.value).Count

    $skip += $count

}
while ($count -gt 0)


Write-Host "Reports retrieved: $($Reports.Count)" `
    -ForegroundColor Green


# ------------------------------------------------------------
# Prepare report inventory
# ------------------------------------------------------------

$ReportInventory = foreach ($Report in $Reports) {

    [PSCustomObject]@{
        WorkspaceId = $Report.workspaceId
        ReportId    = $Report.id
        ReportName  = $Report.name
        DatasetId   = $Report.datasetId
        ReportUrl   = $Report.webUrl
    }
}


# ------------------------------------------------------------
# Retrieve Activity Events
# ------------------------------------------------------------

$UsageEvents = @()
$Errors = @()

$currentDate = $StartDate.Date
$lastDate = $EndDate.Date

while ($currentDate -le $lastDate) {

    Write-Host ""
    Write-Host "Processing activity date: $($currentDate.ToString("yyyy-MM-dd"))" `
        -ForegroundColor Yellow

    # Activity Events must be queried one UTC day at a time.
    $dayStart = $currentDate.ToUniversalTime()

    $dayEnd = $currentDate.AddDays(1).AddMilliseconds(-1).ToUniversalTime()

    $startString = $dayStart.ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
    $endString   = $dayEnd.ToString("yyyy-MM-ddTHH:mm:ss.fffZ")

    $ActivityUrl =
        "https://api.powerbi.com/v1.0/myorg/admin/activityevents" +
        "?startDateTime='$startString'" +
        "&endDateTime='$endString'"

    try {

        do {

            Write-Host "Downloading activity events..."

            $ActivityResponse =
                Invoke-PowerBIRequest -Uri $ActivityUrl

            if ($ActivityResponse.activityEventEntities) {

                foreach ($Event in $ActivityResponse.activityEventEntities) {

                    if ($Event.Activity -eq "ViewReport") {

                        $UsageEvents += $Event
                    }
                }
            }

            # Continuation handling
            if ($ActivityResponse.continuationUri) {

                $ActivityUrl = $ActivityResponse.continuationUri

            }
            elseif ($ActivityResponse.continuationToken) {

                $token =
                    [System.Uri]::EscapeDataString(
                        $ActivityResponse.continuationToken
                    )

                $ActivityUrl =
                    "https://api.powerbi.com/v1.0/myorg/admin/activityevents" +
                    "?continuationToken=$token"

            }
            else {

                $ActivityUrl = $null
            }

        }
        while ($ActivityUrl)

    }
    catch {

        $Errors += [PSCustomObject]@{
            Date  = $currentDate
            Error = $_.Exception.Message
        }

        Write-Warning `
            "Failed to retrieve activity for $currentDate"
    }

    $currentDate = $currentDate.AddDays(1)
}


Write-Host ""
Write-Host "ViewReport events retrieved: $($UsageEvents.Count)" `
    -ForegroundColor Green


# ------------------------------------------------------------
# Build lookup table for reports
# ------------------------------------------------------------

$ReportLookup = @{}

foreach ($Report in $ReportInventory) {

    $key = "$($Report.WorkspaceId)|$($Report.ReportId)"

    $ReportLookup[$key] = $Report
}


# ------------------------------------------------------------
# Build detailed usage table
# ------------------------------------------------------------

$UsageDetail = foreach ($Event in $UsageEvents) {

    $workspaceId = $Event.WorkspaceId
    $reportId = $Event.ReportId

    $lookupKey = "$workspaceId|$reportId"

    $ReportInfo = $ReportLookup[$lookupKey]

    [PSCustomObject]@{

        CreationTime = $Event.CreationTime

        WorkspaceId  = $workspaceId

        WorkspaceName = $Event.WorkspaceName

        ReportId     = $reportId

        ReportName   = if ($ReportInfo) {
            $ReportInfo.ReportName
        }
        else {
            $Event.ReportName
        }

        UserId = $Event.UserId

        Activity = $Event.Activity

        CapacityName = $Event.CapacityName

        DatasetId = if ($ReportInfo) {
            $ReportInfo.DatasetId
        }
        else {
            $null
        }
    }
}


# ------------------------------------------------------------
# Usage Summary
# ------------------------------------------------------------

$UsageSummary = @()

$groups = $UsageDetail |
    Group-Object WorkspaceId, ReportId

foreach ($Group in $groups) {

    $first = $Group.Group | Select-Object -First 1

    $views = $Group.Count

    $uniqueViewers =
        @(
            $Group.Group.UserId |
            Where-Object {
                -not [string]::IsNullOrWhiteSpace($_)
            } |
            Sort-Object -Unique
        ).Count

    $lastViewed =
        $Group.Group |
        Sort-Object CreationTime -Descending |
        Select-Object -First 1

    $UsageSummary += [PSCustomObject]@{

        WorkspaceId   = $first.WorkspaceId

        WorkspaceName = $first.WorkspaceName

        ReportId      = $first.ReportId

        ReportName    = $first.ReportName

        Views         = $views

        UniqueViewers = $uniqueViewers

        LastViewed    = $lastViewed.CreationTime
    }
}


# ------------------------------------------------------------
# Find reports with zero usage
# ------------------------------------------------------------

$UsageKeys = @{}

foreach ($Usage in $UsageSummary) {

    $key =
        "$($Usage.WorkspaceId)|$($Usage.ReportId)"

    $UsageKeys[$key] = $true
}


foreach ($Report in $ReportInventory) {

    $key =
        "$($Report.WorkspaceId)|$($Report.ReportId)"

    if (-not $UsageKeys.ContainsKey($key)) {

        $UsageSummary += [PSCustomObject]@{

            WorkspaceId   = $Report.WorkspaceId

            WorkspaceName = $null

            ReportId      = $Report.ReportId

            ReportName    = $Report.ReportName

            Views         = 0

            UniqueViewers = 0

            LastViewed    = $null
        }
    }
}


# ------------------------------------------------------------
# Export to Excel
# ------------------------------------------------------------

Write-Host ""
Write-Host "Creating Excel workbook..." -ForegroundColor Cyan

if (-not (Get-Module -ListAvailable -Name ImportExcel)) {

    throw "ImportExcel module is not installed. Run: Install-Module ImportExcel"
}

Import-Module ImportExcel

$ReportInventory |
    Export-Excel `
        -Path $OutputFile `
        -WorksheetName "Report Inventory" `
        -AutoSize `
        -FreezeTopRow `
        -BoldTopRow

$UsageSummary |
    Export-Excel `
        -Path $OutputFile `
        -WorksheetName "Usage Summary" `
        -AutoSize `
        -FreezeTopRow `
        -BoldTopRow `
        -Append

$UsageDetail |
    Export-Excel `
        -Path $OutputFile `
        -WorksheetName "Usage Detail" `
        -AutoSize `
        -FreezeTopRow `
        -BoldTopRow `
        -Append

$Errors |
    Export-Excel `
        -Path $OutputFile `
        -WorksheetName "Errors" `
        -AutoSize `
        -FreezeTopRow `
        -BoldTopRow `
        -Append


# ------------------------------------------------------------
# Finished
# ------------------------------------------------------------

Write-Host ""
Write-Host "============================================="
Write-Host "Power BI Usage Extraction Complete"
Write-Host "============================================="
Write-Host "Reports      : $($ReportInventory.Count)"
Write-Host "Usage Events : $($UsageEvents.Count)"
Write-Host "Output       : $OutputFile"
Write-Host "============================================="
