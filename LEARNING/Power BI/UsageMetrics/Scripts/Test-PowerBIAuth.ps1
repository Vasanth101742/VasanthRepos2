$configFile = "C:\Users\vasanthk\OneDrive - ELGi Equipments Ltd\Desktop\Desktop Files\Vasanth_GitDesktop\Flatris-LAB\Flatris-LAB\VasanthRepos2\LEARNING\Migration\UsageMetrics\Scripts\config.ps1"

if (-not (Test-Path $configFile)) {
    throw "Configuration file not found: $configFile"
}

. $configFile

$TenantId     = $Config.TenantId
$ClientId     = $Config.ClientId
$ClientSecret = $Config.ClientSecret




# $TokenUrl = "https://login.microsoftonline.com/$TenantId/oauth2/v2.0/token"

# $Body = @{
#     client_id     = $ClientId
#     client_secret = $ClientSecret
#     scope         = "https://analysis.windows.net/powerbi/api/.default"
#     grant_type    = "client_credentials"
# }

# Write-Host "Requesting Power BI access token..." -ForegroundColor Cyan

# try {

#     $TokenResponse = Invoke-RestMethod `
#         -Uri $TokenUrl `
#         -Method Post `
#         -Body $Body `
#         -ContentType "application/x-www-form-urlencoded"

#     Write-Host ""
#     Write-Host "SUCCESS: Access token obtained!" -ForegroundColor Green

#     $AccessToken = $TokenResponse.access_token

#     Write-Host ""
#     Write-Host "Token length: $($AccessToken.Length)"

# }
# catch {

#     Write-Host ""
#     Write-Host "FAILED: Authentication error" -ForegroundColor Red
#     Write-Host $_.Exception.Message -ForegroundColor Red
# }




#Method 2:

# ----------------------------------------
# Get access token
# ----------------------------------------

$TokenUrl = "https://login.microsoftonline.com/$TenantId/oauth2/v2.0/token"

$Body = @{
    client_id     = $ClientId
    client_secret = $ClientSecret
    scope         = "https://analysis.windows.net/powerbi/api/.default"
    grant_type    = "client_credentials"
}

Write-Host "Getting access token..." -ForegroundColor Cyan

try {

    $TokenResponse = Invoke-RestMethod `
        -Uri $TokenUrl `
        -Method Post `
        -Body $Body `
        -ContentType "application/x-www-form-urlencoded"

    $AccessToken = $TokenResponse.access_token

    Write-Host "Authentication successful." `
        -ForegroundColor Green

}
catch {

    Write-Host "Authentication failed." `
        -ForegroundColor Red

    Write-Host $_.Exception.Message

    exit
}


# ----------------------------------------
# Call Power BI Admin API
# ----------------------------------------

$Headers = @{
    Authorization = "Bearer $AccessToken"
}

$ReportsUrl = "https://api.powerbi.com/v1.0/myorg/admin/reports"

Write-Host ""
Write-Host "Calling Power BI Admin Reports API..." `
    -ForegroundColor Cyan

try {
    # $Response = Invoke-WebRequest `
    # -Uri "https://api.powerbi.com" `
    # -Method Get

    $Response = Invoke-RestMethod `
        -Uri $ReportsUrl `
        -Headers $Headers `
        -Method Get
        -Verbose
    
    Write-Host "I have reached here too"

    Write-Host ""
    Write-Host "SUCCESS!" -ForegroundColor Green

    Write-Host ""
    Write-Host "Number of reports returned: $($Response.value.Count)" `
        -ForegroundColor Green

    Write-Host ""
    Write-Host "First reports:"
    
    $Response.value |
        Select-Object -First 10 `
            id,
            name,
            workspaceId,
            datasetId |
        Format-Table -AutoSize

}
catch {

    Write-Host ""
    Write-Host "Power BI API call failed." `
        -ForegroundColor Red

    Write-Host ""
    Write-Host $_.Exception.Message `
        -ForegroundColor Red

    if ($_.Exception.Response) {

        Write-Host ""
        Write-Host "HTTP response:" `
            -ForegroundColor Yellow

        Write-Host $_.Exception.Response.StatusCode
    }
}
