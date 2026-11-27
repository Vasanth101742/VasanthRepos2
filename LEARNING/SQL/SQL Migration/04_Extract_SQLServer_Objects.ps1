
# ==========================================================
# Prerequisites:
Install-Module SqlServer -Scope CurrentUser -Force
# ==========================================================



# ==========================================================
# SQL SERVER INSTANCE OBJECT EXTRACTION
# SQL Agent Jobs + Linked Servers
# ==========================================================

Import-Module SqlServer -ErrorAction Stop

# SQL Server connection
$ServerInstance = "10.50.0.4"

# Output folder
$OutputPath = "C:\SQLDBScripts\SQLServer_Instance"

$JobsPath = Join-Path $OutputPath "AgentJobs"
$LinkedServersPath = Join-Path $OutputPath "LinkedServers"

# Create folders
New-Item -ItemType Directory -Path $JobsPath -Force | Out-Null
New-Item -ItemType Directory -Path $LinkedServersPath -Force | Out-Null

# Connect to SQL Server using Windows Authentication
$Server = New-Object Microsoft.SqlServer.Management.Smo.Server($ServerInstance)

# Function to create safe file names
function Get-SafeFileName {
    param([string]$Name)

    $InvalidChars = [System.IO.Path]::GetInvalidFileNameChars()
    foreach ($Char in $InvalidChars) {
        $Name = $Name.Replace($Char, '_')
    }

    return $Name
}

# ==========================================================
# 1. EXPORT SQL SERVER AGENT JOBS
# ==========================================================

Write-Host "Extracting SQL Agent Jobs..." -ForegroundColor Cyan

foreach ($Job in $Server.JobServer.Jobs) {

    try {
        $FileName = (Get-SafeFileName $Job.Name) + ".sql"
        $FilePath = Join-Path $JobsPath $FileName

        $Script = $Job.Script()

        $Script | Out-File -FilePath $FilePath `
            -Encoding UTF8

        Write-Host "Exported Job: $($Job.Name)" -ForegroundColor Green
    }
    catch {
        Write-Warning "Failed Job: $($Job.Name) - $($_.Exception.Message)"
    }
}

# ==========================================================
# 2. EXPORT LINKED SERVERS
# ==========================================================

Write-Host "Extracting Linked Servers..." -ForegroundColor Cyan

foreach ($LinkedServer in $Server.LinkedServers) {

    try {
        $FileName = (Get-SafeFileName $LinkedServer.Name) + ".sql"
        $FilePath = Join-Path $LinkedServersPath $FileName

        $Script = $LinkedServer.Script()

        $Script | Out-File -FilePath $FilePath `
            -Encoding UTF8

        Write-Host "Exported Linked Server: $($LinkedServer.Name)" `
            -ForegroundColor Green
    }
    catch {
        Write-Warning "Failed Linked Server: $($LinkedServer.Name) - $($_.Exception.Message)"
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "SQL SERVER EXTRACTION COMPLETED"
Write-Host "Output: $OutputPath"
Write-Host "========================================"

