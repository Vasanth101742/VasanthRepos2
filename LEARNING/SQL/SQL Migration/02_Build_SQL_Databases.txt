# ============================================================
# 02 - Build SQL Database Projects
# ============================================================

$RootFolder = "C:\SQLDevOps"

$BuildLogFile = "$RootFolder\BuildLog.csv"


Write-Host ""
Write-Host "============================================"
Write-Host "SQL DATABASE PROJECT BUILD"
Write-Host "============================================"
Write-Host "Root Folder : $RootFolder"
Write-Host "============================================"
Write-Host ""


# ------------------------------------------------------------
# Find all SQL projects
# ------------------------------------------------------------

$Projects = Get-ChildItem `
    -Path $RootFolder `
    -Filter "*.sqlproj" `
    -Recurse


if ($Projects.Count -eq 0) {

    Write-Host ""
    Write-Host "No SQL projects found." `
        -ForegroundColor Red

    exit 1
}


Write-Host "Projects found: $($Projects.Count)"
Write-Host ""


# ------------------------------------------------------------
# Results
# ------------------------------------------------------------

$Results = @()


# ------------------------------------------------------------
# Build each project
# ------------------------------------------------------------

foreach ($Project in $Projects) {

    $Database = $Project.BaseName

    $ProjectPath = $Project.FullName

    Write-Host ""
    Write-Host "============================================"
    Write-Host "Building: $Database"
    Write-Host "============================================"


    $StartTime = Get-Date


    try {

        Write-Host "Project:"
        Write-Host $ProjectPath

        Write-Host ""
        Write-Host "Running dotnet build..." `
            -ForegroundColor Cyan


        dotnet build `
            $ProjectPath `
            --configuration Release


        if ($LASTEXITCODE -ne 0) {

            throw `
                "Build failed. Exit code: $LASTEXITCODE"
        }


        $EndTime = Get-Date

        $Duration = $EndTime - $StartTime


        Write-Host ""
        Write-Host "BUILD SUCCESS: $Database" `
            -ForegroundColor Green


        $Results += [PSCustomObject]@{

            Database = $Database
            Status   = "SUCCESS"
            Duration = $Duration.ToString()
            Project  = $ProjectPath
            Error    = ""

        }

    }
    catch {

        Write-Host ""
        Write-Host "BUILD FAILED: $Database" `
            -ForegroundColor Red

        Write-Host $_.Exception.Message `
            -ForegroundColor Red


        $Results += [PSCustomObject]@{

            Database = $Database
            Status   = "FAILED"
            Duration = ""
            Project  = $ProjectPath
            Error    = $_.Exception.Message

        }
    }
}


# ------------------------------------------------------------
# Export build results
# ------------------------------------------------------------

$Results |
    Export-Csv `
        -Path $BuildLogFile `
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
Write-Host "BUILD COMPLETED"
Write-Host "============================================"

Write-Host "Total    : $($Projects.Count)"
Write-Host "Success  : $Successful" -ForegroundColor Green
Write-Host "Failed   : $Failed" -ForegroundColor Red

Write-Host ""
Write-Host "Build log:"
Write-Host $BuildLogFile

Write-Host "============================================"


