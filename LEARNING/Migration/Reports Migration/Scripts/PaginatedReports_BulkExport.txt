$PBIRS = " https://elgi-bis.elgi.com/reports"

$OutputFolder = "C:\PBIRS-RDL-Export"

New-Item `
    -ItemType Directory `
    -Path $OutputFolder `
    -Force | Out-Null


Write-Host "Connecting to Power BI Report Server..."

# Get reports
$uri = "$PBIRS/api/v2.0/Reports"

$response = Invoke-RestMethod `
    -Uri $uri `
    -UseDefaultCredentials `
    -Method Get


$reports = $response.value

Write-Host "Reports found: $($reports.Count)"


foreach ($report in $reports) {

    $reportName = $report.Name
    $reportId   = $report.Id
    $reportPath = $report.Path

    Write-Host ""
    Write-Host "Processing: $reportPath"


    # Remove report name from path
    $folderPath = Split-Path `
        $reportPath `
        -Parent


    # Remove leading /
    $folderPath = $folderPath.TrimStart('/')


    # Create local folder
    if ([string]::IsNullOrWhiteSpace($folderPath)) {

        $localFolder = $OutputFolder

    }
    else {

        $localFolder = Join-Path `
            $OutputFolder `
            $folderPath
    }


    New-Item `
        -ItemType Directory `
        -Path $localFolder `
        -Force | Out-Null


    # Clean filename
    $safeName = $reportName `
        -replace '[\\/:*?"<>|]', '_'


    $outputFile = Join-Path `
        $localFolder `
        "$safeName.rdl"


    # Download RDL
    $contentUri =
        "$PBIRS/api/v2.0/CatalogItems($reportId)/Content/`$value"


    try {

        Invoke-WebRequest `
            -Uri $contentUri `
            -UseDefaultCredentials `
            -OutFile $outputFile


        Write-Host `
            "SUCCESS: $outputFile" `
            -ForegroundColor Green

    }
    catch {

        Write-Host `
            "FAILED: $reportPath" `
            -ForegroundColor Red

        Write-Host $_.Exception.Message
    }
}


Write-Host ""
Write-Host "================================"
Write-Host "RDL Export Completed"
Write-Host "Output: $OutputFolder"
Write-Host "================================"




$Inventory = @()

foreach ($report in $reports) {

    $Inventory += [PSCustomObject]@{
        ReportName = $report.Name
        ReportId   = $report.Id
        Path       = $report.Path
        Format     = $report.Format
    }
}

$Inventory |
    Export-Csv `
        "$OutputFolder\RDL-Inventory.csv" `
        -NoTypeInformation `
        -Encoding UTF8
