$PBIRS = "https://elgi-bis.elgi.com/reports"
$OutputFolder = "C:\PBIRS-RDL-Export2"
$ExcelFile = Join-Path $OutputFolder "ExtractedReportNames.xlsx"

# Create output folder
New-Item -ItemType Directory `
    -Path $OutputFolder `
    -Force | Out-Null

# Check whether ImportExcel module is installed
if (-not (Get-Module -ListAvailable -Name ImportExcel)) {
    Install-Module ImportExcel -Scope CurrentUser -Force
}

Import-Module ImportExcel

# Get all reports
$uri = "$PBIRS/api/v2.0/Reports"

$response = Invoke-RestMethod `
    -Uri $uri `
    -UseDefaultCredentials `
    -Method Get

# Store report details for Excel export
$reportList = @()

foreach ($report in $response.value) {

    $reportName = $report.Name
    $reportId   = $report.Id
    $reportPath = $report.Path

    $safeName = $reportName -replace '[\\/:*?"<>|]', '_'

    $outputFile = Join-Path $OutputFolder "$safeName.rdl"

    Write-Host "Downloading: $reportName"

    $contentUri = "$PBIRS/api/v2.0/CatalogItems($reportId)/Content/`$value"

    try {
        Invoke-WebRequest `
            -Uri $contentUri `
            -UseDefaultCredentials `
            -OutFile $outputFile `
            -ErrorAction Stop

        $downloadStatus = "Success"
        Write-Host "Downloaded: $reportName" -ForegroundColor Green
    }
    catch {
        $downloadStatus = "Failed: $($_.Exception.Message)"
        Write-Host "Failed: $reportName" -ForegroundColor Red
    }

    # Add report details to Excel list
    $reportList += [PSCustomObject]@{
        ReportName     = $reportName
        ReportID       = $reportId
        ReportPath     = $reportPath
        DownloadedFile = $outputFile
        Status         = $downloadStatus
    }
}

# Export report list to Excel
$reportList |
    Export-Excel `
        -Path $ExcelFile `
        -WorksheetName "Report List" `
        -TableName "ReportList" `
        -AutoSize `
        -FreezeTopRow `
        -BoldTopRow

Write-Host ""
Write-Host "RDL export completed." -ForegroundColor Green
Write-Host "Report folder: $OutputFolder"
Write-Host "Excel report list: $ExcelFile"