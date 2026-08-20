# ============================================================
# 01 - SQL Server Database Extraction + SQL Project Creation
# SQL Server -> SQL Database Project
# ============================================================

$Server = "10.50.0.4"

$RootFolder = "C:\SQLDevOps"

$DatabaseListFile = "$RootFolder\Databases.txt"

$LogFile = "$RootFolder\ExtractionLog.csv"


# ------------------------------------------------------------
# Create root folder
# ------------------------------------------------------------

New-Item `
    -ItemType Directory `
    -Path $RootFolder `
    -Force | Out-Null


# ------------------------------------------------------------
# Check database list
# ------------------------------------------------------------

if (-not (Test-Path $DatabaseListFile)) {

    Write-Host "Database list not found:" -ForegroundColor Red
    Write-Host $DatabaseListFile

    exit 1
}


# ------------------------------------------------------------
# Read database names
# ------------------------------------------------------------

$Databases = Get-Content $DatabaseListFile |
    Where-Object {
        $_.Trim() -ne "" -and
        -not $_.Trim().StartsWith("#")
    }


Write-Host ""
Write-Host "============================================"
Write-Host "SQL DATABASE EXTRACTION"
Write-Host "============================================"
Write-Host "Server      : $Server"
Write-Host "Databases   : $($Databases.Count)"
Write-Host "Output      : $RootFolder"
Write-Host "============================================"
Write-Host ""


# ------------------------------------------------------------
# Credential
# ------------------------------------------------------------

$Credential = Get-Credential

$SqlUser = $Credential.UserName

$SqlPassword =
    $Credential.GetNetworkCredential().Password


# ------------------------------------------------------------
# Result collection
# ------------------------------------------------------------

$Results = @()


# ------------------------------------------------------------
# Process each database
# ------------------------------------------------------------

foreach ($Database in $Databases) {

    $Database = $Database.Trim()

    Write-Host ""
    Write-Host "============================================"
    Write-Host "Processing: $Database"
    Write-Host "============================================"


    $DatabaseFolder = Join-Path `
        $RootFolder `
        $Database


    # --------------------------------------------------------
    # Create database folder
    # --------------------------------------------------------

    New-Item `
        -ItemType Directory `
        -Path $DatabaseFolder `
        -Force | Out-Null


    $TargetFile = Join-Path `
        $DatabaseFolder `
        "$Database.dacpac"


    $ProjectFile = Join-Path `
        $DatabaseFolder `
        "$Database.sqlproj"


    $StartTime = Get-Date


    try {

        # ----------------------------------------------------
        # Connection string
        # ----------------------------------------------------

        $ConnectionString =
            "Server=$Server;" +
            "Database=$Database;" +
            "User ID=$SqlUser;" +
            "Password=$SqlPassword;" +
            "Encrypt=True;" +
            "TrustServerCertificate=True"


        # ----------------------------------------------------
        # STEP 1 - Extract database
        # ----------------------------------------------------

        Write-Host ""
        Write-Host "Step 1: Extracting database schema..." `
            -ForegroundColor Cyan


        & sqlpackage `
            /Action:Extract `
            /SourceConnectionString:$ConnectionString `
            /TargetFile:$TargetFile `
            /p:ExtractTarget=SchemaObjectType


        if ($LASTEXITCODE -ne 0) {

            throw `
                "SqlPackage extraction failed. Exit code: $LASTEXITCODE"
        }


        Write-Host ""
        Write-Host "Database extraction completed." `
            -ForegroundColor Green


        # ----------------------------------------------------
        # STEP 2 - Create SQL Database Project
        # ----------------------------------------------------

        Write-Host ""
        Write-Host "Step 2: Creating SQL Database Project..." `
            -ForegroundColor Cyan


        if (-not (Test-Path $ProjectFile)) {

            dotnet new sqlproj `
                -n $Database `
                -o $DatabaseFolder


            if ($LASTEXITCODE -ne 0) {

                throw `
                    "SQL project creation failed. Exit code: $LASTEXITCODE"
            }

            Write-Host ""
            Write-Host "SQL project created successfully." `
                -ForegroundColor Green
        }
        else {

            Write-Host ""
            Write-Host "SQL project already exists. Skipping creation." `
                -ForegroundColor Yellow
        }


        # ----------------------------------------------------
        # Success
        # ----------------------------------------------------

        $EndTime = Get-Date

        $Duration = $EndTime - $StartTime


        Write-Host ""
        Write-Host "SUCCESS: $Database" `
            -ForegroundColor Green


        $Results += [PSCustomObject]@{

            Database = $Database
            Status   = "SUCCESS"
            Duration = $Duration.ToString()
            Folder   = $DatabaseFolder
            Project  = $ProjectFile
            DACPAC   = $TargetFile
            Error    = ""

        }

    }
    catch {

        Write-Host ""
        Write-Host "FAILED: $Database" `
            -ForegroundColor Red

        Write-Host $_.Exception.Message `
            -ForegroundColor Red


        $Results += [PSCustomObject]@{

            Database = $Database
            Status   = "FAILED"
            Duration = ""
            Folder   = $DatabaseFolder
            Project  = $ProjectFile
            DACPAC   = $TargetFile
            Error    = $_.Exception.Message

        }
    }
}


# ------------------------------------------------------------
# Export extraction results
# ------------------------------------------------------------

$Results |
    Export-Csv `
        -Path $LogFile `
        -NoTypeInformation `
        -Encoding UTF8


# ------------------------------------------------------------
# Summary
# ------------------------------------------------------------

$Successful = @(
    $Results |
    Where-Object { $_.Status -eq "SUCCESS" }
).Count


$Failed = @(
    $Results |
    Where-Object { $_.Status -eq "FAILED" }
).Count


Write-Host ""
Write-Host "============================================"
Write-Host "EXTRACTION + PROJECT CREATION COMPLETED"
Write-Host "============================================"

Write-Host "Total    : $($Databases.Count)"
Write-Host "Success  : $Successful" -ForegroundColor Green
Write-Host "Failed   : $Failed" -ForegroundColor Red

Write-Host ""
Write-Host "Log file:"
Write-Host $LogFile

Write-Host "============================================"