$PBIRS = " https://elgi-bis.elgi.com/reports"
$OutputFolder = "C:\PBIRS-RDL-Export"

New-Item -ItemType Directory `
    -Path $OutputFolder `
    -Force | Out-Null


# Get all reports
$uri = "$PBIRS/api/v2.0/Reports"

$response = Invoke-RestMethod `
    -Uri $uri `
    -UseDefaultCredentials `
    -Method Get


foreach ($report in $response.value) {

    $reportName = $report.Name
    $reportId   = $report.Id

    $safeName = $reportName -replace '[\\/:*?"<>|]', '_'

    $outputFile = Join-Path `
        $OutputFolder `
        "$safeName.rdl"

    Write-Host "Downloading: $reportName"

    $contentUri =
        "$PBIRS/api/v2.0/CatalogItems($reportId)/Content/`$value"

    Invoke-WebRequest `
        -Uri $contentUri `
        -UseDefaultCredentials `
        -OutFile $outputFile
}
