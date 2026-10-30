

# # ============================================================
# # Power BI Inventory: Workspaces, Semantic Models, Data Sources
# # ============================================================

# # Step 1: Install the Power BI module if not already installed
# if (-not (Get-Module -ListAvailable -Name MicrosoftPowerBIMgmt)) {
#     Install-Module MicrosoftPowerBIMgmt -Scope CurrentUser -Force
# }

# Import-Module MicrosoftPowerBIMgmt

# # Step 2: Sign in to Power BI
# Connect-PowerBIServiceAccount

# # Step 3: Get all workspaces accessible to your account
# $workspaces = Get-PowerBIWorkspace -All

# # Step 4: Retrieve semantic models
# $models = foreach ($ws in $workspaces) {
#     try {
#         $datasets = Get-PowerBIDataset -WorkspaceId $ws.Id

#         foreach ($ds in $datasets) {
#             [PSCustomObject]@{
#                 WorkspaceName = $ws.Name
#                 WorkspaceId   = $ws.Id
#                 SemanticModel  = $ds.Name
#                 DatasetId      = $ds.Id
#                 ConfiguredBy   = $ds.ConfiguredBy
#                 IsRefreshable  = $ds.IsRefreshable
#             }
#         }
#     }
#     catch {
#         Write-Warning "Could not retrieve models from workspace $($ws.Name): $_"
#     }
# }

# # Step 5: Retrieve data sources for each semantic model
# $datasources = foreach ($ws in $workspaces) {
#     try {
#         $datasets = Get-PowerBIDataset -WorkspaceId $ws.Id

#         foreach ($ds in $datasets) {
#             try {
#                 $path = "groups/$($ws.Id)/datasets/$($ds.Id)/datasources"

#                 $response = Invoke-PowerBIRestMethod `
#                     -Url $path `
#                     -Method Get | ConvertFrom-Json

#                 foreach ($source in $response.value) {
#                     [PSCustomObject]@{
#                         WorkspaceName = $ws.Name
#                         WorkspaceId   = $ws.Id
#                         SemanticModel  = $ds.Name
#                         DatasetId      = $ds.Id
#                         SourceType     = $source.datasourceType
#                         Server         = $source.connectionDetails.server
#                         Database       = $source.connectionDetails.database
#                         URL            = $source.connectionDetails.url
#                         GatewayId      = $source.gatewayId
#                         DatasourceId   = $source.datasourceId
#                     }
#                 }
#             }
#             catch {
#                 Write-Warning "Could not retrieve data sources for '$($ds.Name)' in '$($ws.Name)': $_"
#             }
#         }
#     }
#     catch {
#         Write-Warning "Could not process workspace '$($ws.Name)': $_"
#     }
# }

# # Step 6: Export results to CSV on your desktop
# $desktop = [Environment]::GetFolderPath('Desktop')

# $modelsFile = Join-Path $desktop 'PowerBI_SemanticModels.csv'
# $sourcesFile = Join-Path $desktop 'PowerBI_DataSources.csv'
# $workspacesFile = Join-Path $desktop 'PowerBI_Workspaces.csv'

# $workspaces |
#     Select-Object Name, Id, Type, State, IsReadOnly |
#     Export-Csv -Path $workspacesFile -NoTypeInformation -Encoding UTF8

# $models |
#     Export-Csv -Path $modelsFile -NoTypeInformation -Encoding UTF8

# $datasources |
#     Export-Csv -Path $sourcesFile -NoTypeInformation -Encoding UTF8

# # Step 7: Display summary
# Write-Host "`nPower BI inventory completed." -ForegroundColor Green
# Write-Host "Workspaces:     $($workspaces.Count)"
# Write-Host "Semantic models: $(@($models).Count)"
# Write-Host "Data sources:    $(@($datasources).Count)"

# Write-Host "`nExported files:"
# Write-Host $workspacesFile
# Write-Host $modelsFile
# Write-Host $sourcesFile
# ```


#-----------------------------------------------------------

# Import-Module MicrosoftPowerBIMgmt.Profile -Force
# Import-Module MicrosoftPowerBIMgmt.Workspaces -Force
# Import-Module MicrosoftPowerBIMgmt.Data -Force

# Connect-PowerBIServiceAccount


# Get-PowerBIWorkspace -All |
#     Select-Object Name, Id, Type |
#     Format-Table -AutoSize


#-----------------------------------------------------------------------

# Method :2

# # ==========================================================
# # Power BI: List Semantic Models and Data Sources
# # ==========================================================

# # 1. Import required modules
# Import-Module MicrosoftPowerBIMgmt.Profile
# Import-Module MicrosoftPowerBIMgmt.Workspaces
# Import-Module MicrosoftPowerBIMgmt.Data

# # 2. Sign in to Power BI
# Connect-PowerBIServiceAccount

# # 3. Get all accessible workspaces
# $workspaces = @(Get-PowerBIWorkspace -All)

# # Initialize result collections
# $models = @()
# $dataSources = @()

# # 4. Get semantic models and data sources
# foreach ($ws in $workspaces) {

#     Write-Host "Processing workspace: $($ws.Name)" -ForegroundColor Cyan

#     try {
#         $datasets = @(Get-PowerBIDataset -WorkspaceId $ws.Id)

#         foreach ($ds in $datasets) {

#             # Semantic model inventory
#             $models += [PSCustomObject]@{
#                 WorkspaceName = $ws.Name
#                 WorkspaceId   = $ws.Id
#                 SemanticModel = $ds.Name
#                 DatasetId     = $ds.Id
#                 ConfiguredBy  = $ds.ConfiguredBy
#                 IsRefreshable = $ds.IsRefreshable
#             }

#             # Data source inventory
#             try {
#                 $url = "groups/$($ws.Id)/datasets/$($ds.Id)/datasources"

#                 $response = Invoke-PowerBIRestMethod `
#                     -Url $url `
#                     -Method Get | ConvertFrom-Json

#                 foreach ($source in $response.value) {
#                     $dataSources += [PSCustomObject]@{
#                         WorkspaceName = $ws.Name
#                         SemanticModel = $ds.Name
#                         DatasetId     = $ds.Id
#                         SourceType    = $source.datasourceType
#                         Server        = $source.connectionDetails.server
#                         Database      = $source.connectionDetails.database
#                         URL           = $source.connectionDetails.url
#                         GatewayId     = $source.gatewayId
#                         DatasourceId  = $source.datasourceId
#                     }
#                 }
#             }
#             catch {
#                 Write-Warning "Could not retrieve sources for '$($ds.Name)': $($_.Exception.Message)"
#             }
#         }
#     }
#     catch {
#         Write-Warning "Could not process '$($ws.Name)': $($_.Exception.Message)"
#     }
# }

# # 5. Display semantic models
# Write-Host "`n===== SEMANTIC MODELS =====" -ForegroundColor Green
# $models | Format-Table WorkspaceName, SemanticModel, DatasetId -AutoSize

# # 6. Display data sources
# Write-Host "`n===== DATA SOURCES =====" -ForegroundColor Green
# $dataSources | Format-Table WorkspaceName, SemanticModel, SourceType, Server, Database -AutoSize

# # 7. Export to Desktop
# $desktop = [Environment]::GetFolderPath('Desktop')

# $models |
#     Export-Csv "$desktop\PowerBI_SemanticModels.csv" -NoTypeInformation -Encoding UTF8

# $dataSources |
#     Export-Csv "$desktop\PowerBI_DataSources.csv" -NoTypeInformation -Encoding UTF8

# Write-Host "`nInventory completed." -ForegroundColor Green
# Write-Host "Semantic models found: $($models.Count)"
# Write-Host "Data sources found: $($dataSources.Count)"
# Write-Host "Files saved to: $desktop"


#--------------------------------------------------------------------------------

#Method :3



# # ==========================================================
# # Power BI Inventory - Workspaces, Semantic Models, Owners,
# # and Data Sources in ONE CSV file
# # ==========================================================

# # 1. Import modules
# Import-Module MicrosoftPowerBIMgmt.Profile
# Import-Module MicrosoftPowerBIMgmt.Workspaces
# Import-Module MicrosoftPowerBIMgmt.Data

# # 2. Sign in
# Connect-PowerBIServiceAccount

# # 3. Get accessible workspaces
# $workspaces = @(Get-PowerBIWorkspace -All)

# # 4. Initialize inventory
# $inventory = [System.Collections.Generic.List[object]]::new()

# foreach ($ws in $workspaces) {

#     Write-Host "Processing workspace: $($ws.Name)" -ForegroundColor Cyan

#     try {
#         $datasets = @(Get-PowerBIDataset -WorkspaceId $ws.Id)

#         foreach ($ds in $datasets) {

#             # Get semantic model owner/configured by
#             $owner = $ds.ConfiguredBy

#             # Initialize a default row for models without returned sources
#             $sources = @()

#             try {
#                 $url = "groups/$($ws.Id)/datasets/$($ds.Id)/datasources"

#                 $response = Invoke-PowerBIRestMethod `
#                     -Url $url `
#                     -Method Get `
#                     -ErrorAction Stop | ConvertFrom-Json

#                 $sources = @($response.value)
#             }
#             catch {
#                 Write-Warning "Sources unavailable for '$($ds.Name)': $($_.Exception.Message)"
#             }

#             # Create one row per data source
#             if ($sources.Count -gt 0) {

#                 foreach ($source in $sources) {

#                     $inventory.Add([PSCustomObject]@{
#                         WorkspaceName       = $ws.Name
#                         WorkspaceId         = $ws.Id
#                         WorkspaceType       = $ws.Type
#                         WorkspaceState      = $ws.State

#                         SemanticModelName   = $ds.Name
#                         SemanticModelId     = $ds.Id
#                         SemanticModelOwner  = $owner
#                         ConfiguredBy        = $ds.ConfiguredBy
#                         IsRefreshable       = $ds.IsRefreshable

#                         DataSourceType      = $source.datasourceType
#                         DataSourceId        = $source.datasourceId
#                         GatewayId           = $source.gatewayId
#                         Server              = $source.connectionDetails.server
#                         Database            = $source.connectionDetails.database
#                         URL                 = $source.connectionDetails.url
#                         ConnectionDetails   = (
#                             $source.connectionDetails |
#                             ConvertTo-Json -Compress -Depth 10
#                         )
#                     })
#                 }
#             }
#             else {

#                 # Keep the semantic model even when no sources are returned
#                 $inventory.Add([PSCustomObject]@{
#                     WorkspaceName       = $ws.Name
#                     WorkspaceId         = $ws.Id
#                     WorkspaceType       = $ws.Type
#                     WorkspaceState      = $ws.State

#                     SemanticModelName   = $ds.Name
#                     SemanticModelId     = $ds.Id
#                     SemanticModelOwner  = $owner
#                     ConfiguredBy        = $ds.ConfiguredBy
#                     IsRefreshable       = $ds.IsRefreshable

#                     DataSourceType      = $null
#                     DataSourceId        = $null
#                     GatewayId           = $null
#                     Server              = $null
#                     Database            = $null
#                     URL                 = $null
#                     ConnectionDetails   = $null
#                 })
#             }
#         }
#     }
#     catch {
#         Write-Warning "Could not process workspace '$($ws.Name)': $($_.Exception.Message)"
#     }
# }

# # 5. Export all fields to one CSV file
# $desktop = [Environment]::GetFolderPath('Desktop')
# $outputFile = Join-Path $desktop 'PowerBI_Complete_Inventory.csv'

# $inventory |
#     Export-Csv -Path $outputFile -NoTypeInformation -Encoding UTF8

# # 6. Summary
# Write-Host "`n========== INVENTORY SUMMARY ==========" -ForegroundColor Green
# Write-Host "Workspaces scanned: $($workspaces.Count)"
# Write-Host "Inventory rows:     $($inventory.Count)"
# Write-Host "Output file:        $outputFile"
# Write-Host "=======================================" -ForegroundColor Green


#-------------------------------------------------------------------------------------


# # Method :4


# # ==========================================================
# # Power BI Inventory - Workspaces, Semantic Models, Owners,
# # Data Sources, Gateway Name and Gateway Type in ONE CSV
# # ==========================================================

# # 1. Import modules
# Import-Module MicrosoftPowerBIMgmt.Profile
# Import-Module MicrosoftPowerBIMgmt.Workspaces
# Import-Module MicrosoftPowerBIMgmt.Data

# # 2. Sign in
# Connect-PowerBIServiceAccount

# # 3. Get gateways accessible to the signed-in account
# $gatewayLookup = @{}

# try {
#     $gatewayResponse = Invoke-PowerBIRestMethod `
#         -Url "gateways" `
#         -Method Get `
#         -ErrorAction Stop | ConvertFrom-Json

#     foreach ($gateway in @($gatewayResponse.value)) {
#         if ($gateway.gatewayId) {
#             $gatewayLookup[[string]$gateway.gatewayId] = $gateway
#         }
#     }

#     Write-Host "Gateways retrieved: $($gatewayLookup.Count)" -ForegroundColor Green
# }
# catch {
#     Write-Warning "Could not retrieve gateways: $($_.Exception.Message)"
# }

# # 4. Get accessible workspaces
# $workspaces = @(Get-PowerBIWorkspace -All)

# # 5. Initialize inventory
# $inventory = [System.Collections.Generic.List[object]]::new()

# foreach ($ws in $workspaces) {

#     Write-Host "Processing workspace: $($ws.Name)" -ForegroundColor Cyan

#     try {
#         $datasets = @(Get-PowerBIDataset -WorkspaceId $ws.Id)

#         foreach ($ds in $datasets) {

#             # Get semantic model owner/configured by
#             $owner = $ds.ConfiguredBy

#             # Initialize a default collection of data sources
#             $sources = @()

#             try {
#                 $url = "groups/$($ws.Id)/datasets/$($ds.Id)/datasources"

#                 $response = Invoke-PowerBIRestMethod `
#                     -Url $url `
#                     -Method Get `
#                     -ErrorAction Stop | ConvertFrom-Json

#                 $sources = @($response.value)
#             }
#             catch {
#                 Write-Warning "Sources unavailable for '$($ds.Name)': $($_.Exception.Message)"
#             }

#             # Create one row per data source
#             if ($sources.Count -gt 0) {

#                 foreach ($source in $sources) {

#                     # Match source GatewayId to the accessible gateway inventory
#                     $gatewayId = $source.gatewayId
#                     $gatewayName = $null
#                     $gatewayType = $null

#                     if ($gatewayId) {
#                         $gatewayKey = [string]$gatewayId

#                         if ($gatewayLookup.ContainsKey($gatewayKey)) {
#                             $gatewayInfo = $gatewayLookup[$gatewayKey]
#                             $gatewayName = $gatewayInfo.name
#                             $gatewayType = $gatewayInfo.type
#                         }
#                     }

#                     $inventory.Add([PSCustomObject]@{
#                         WorkspaceName       = $ws.Name
#                         WorkspaceId         = $ws.Id
#                         WorkspaceType       = $ws.Type
#                         WorkspaceState      = $ws.State

#                         SemanticModelName   = $ds.Name
#                         SemanticModelId     = $ds.Id
#                         SemanticModelOwner  = $owner
#                         ConfiguredBy        = $ds.ConfiguredBy
#                         IsRefreshable       = $ds.IsRefreshable

#                         DataSourceType      = $source.datasourceType
#                         DataSourceId        = $source.datasourceId
#                         GatewayId           = $gatewayId
#                         GatewayName         = $gatewayName
#                         GatewayType         = $gatewayType
#                         Server              = $source.connectionDetails.server
#                         Database            = $source.connectionDetails.database
#                         URL                 = $source.connectionDetails.url
#                         ConnectionDetails   = (
#                             $source.connectionDetails |
#                             ConvertTo-Json -Compress -Depth 10
#                         )
#                     })
#                 }
#             }
#             else {

#                 # Keep the semantic model even when no sources are returned
#                 $inventory.Add([PSCustomObject]@{
#                     WorkspaceName       = $ws.Name
#                     WorkspaceId         = $ws.Id
#                     WorkspaceType       = $ws.Type
#                     WorkspaceState      = $ws.State

#                     SemanticModelName   = $ds.Name
#                     SemanticModelId     = $ds.Id
#                     SemanticModelOwner  = $owner
#                     ConfiguredBy        = $ds.ConfiguredBy
#                     IsRefreshable       = $ds.IsRefreshable

#                     DataSourceType      = $null
#                     DataSourceId        = $null
#                     GatewayId           = $null
#                     GatewayName         = $null
#                     GatewayType         = $null
#                     Server              = $null
#                     Database            = $null
#                     URL                 = $null
#                     ConnectionDetails   = $null
#                 })
#             }
#         }
#     }
#     catch {
#         Write-Warning "Could not process workspace '$($ws.Name)': $($_.Exception.Message)"
#     }
# }

# # 6. Export all fields to one CSV file
# $desktop = [Environment]::GetFolderPath('Desktop')
# $outputFile = Join-Path $desktop 'PowerBI_Complete_Inventory.csv'

# $inventory |
#     Export-Csv -Path $outputFile -NoTypeInformation -Encoding UTF8

# # 7. Summary
# Write-Host "`n========== INVENTORY SUMMARY ==========" -ForegroundColor Green
# Write-Host "Workspaces scanned: $($workspaces.Count)"
# Write-Host "Gateways retrieved: $($gatewayLookup.Count)"
# Write-Host "Inventory rows:     $($inventory.Count)"
# Write-Host "Output file:        $outputFile"
# Write-Host "=======================================" -ForegroundColor Green



#-------------------------------------------------------------

# #Gateway Retrieval

# # Sign in if not already connected
# Connect-PowerBIServiceAccount

# # Enter your Gateway ID
# $gatewayId = "6b8fbe25-2321-45a3-be27-43a4581c7ba4"

# # Retrieve gateway details
# $gateway = Invoke-PowerBIRestMethod `
#     -Url "gateways/$gatewayId" `
#     -Method Get `
#     -ErrorAction Stop | ConvertFrom-Json

# # Display gateway name and type
# $gateway | Select-Object `
#     id,
#     name,
#     type |
#     Format-Table -AutoSize

#-------------------------------------------------------------------------

# ==========================================================
# Power BI Inventory - Workspaces, Semantic Models, Owners,
# Reports, Dashboards, Data Sources and Gateway Details
# Output: PowerBI_Complete_Inventory.csv
# ==========================================================

# 1. Import modules
Import-Module MicrosoftPowerBIMgmt.Profile
Import-Module MicrosoftPowerBIMgmt.Workspaces
Import-Module MicrosoftPowerBIMgmt.Data

# 2. Sign in
Connect-PowerBIServiceAccount

# 3. Get gateways accessible to the signed-in account
$gatewayLookup = @{}

try {
    $gatewayResponse = Invoke-PowerBIRestMethod `
        -Url "gateways" `
        -Method Get `
        -ErrorAction Stop | ConvertFrom-Json

    foreach ($gateway in @($gatewayResponse.value)) {
        # Gateway API commonly returns the identifier in "id"
        $gatewayIdValue = if ($gateway.id) {
            $gateway.id
        } else {
            $gateway.gatewayId
        }

        if ($gatewayIdValue) {
            $gatewayLookup[[string]$gatewayIdValue] = $gateway
        }
    }

    Write-Host "Gateways retrieved: $($gatewayLookup.Count)" -ForegroundColor Green
}
catch {
    Write-Warning "Could not retrieve gateways: $($_.Exception.Message)"
}

# 4. Get accessible workspaces
$workspaces = @(Get-PowerBIWorkspace -All)

# 5. Initialize inventory
$inventory = [System.Collections.Generic.List[object]]::new()

foreach ($ws in $workspaces) {

    Write-Host "Processing workspace: $($ws.Name)" -ForegroundColor Cyan

    # Workspace-level content
    $reports = @()
    $dashboards = @()
    $reportDatasetLookup = @{}
    $reportsByDataset = @{}
    $dashboardsByDataset = @{}

    # 5A. Get reports in this workspace
    try {
        $reportResponse = Invoke-PowerBIRestMethod `
            -Url "groups/$($ws.Id)/reports" `
            -Method Get `
            -ErrorAction Stop | ConvertFrom-Json

        $reports = @($reportResponse.value)

        # Map report IDs to their semantic model IDs
        foreach ($report in $reports) {
            if ($report.id -and $report.datasetId) {
                $reportDatasetLookup[[string]$report.id] = [string]$report.datasetId

                $dsKey = [string]$report.datasetId

                if (-not $reportsByDataset.ContainsKey($dsKey)) {
                    $reportsByDataset[$dsKey] = [System.Collections.Generic.List[object]]::new()
                }

                $reportsByDataset[$dsKey].Add($report)
            }
        }
    }
    catch {
        Write-Warning "Could not retrieve reports for '$($ws.Name)': $($_.Exception.Message)"
    }

    # 5B. Get dashboards in this workspace
    try {
        $dashboardResponse = Invoke-PowerBIRestMethod `
            -Url "groups/$($ws.Id)/dashboards" `
            -Method Get `
            -ErrorAction Stop | ConvertFrom-Json

        $dashboards = @($dashboardResponse.value)
    }
    catch {
        Write-Warning "Could not retrieve dashboards for '$($ws.Name)': $($_.Exception.Message)"
    }

    # 5C. Map dashboards to semantic models using their tiles
    foreach ($dashboard in $dashboards) {
        try {
            $tileResponse = Invoke-PowerBIRestMethod `
                -Url "groups/$($ws.Id)/dashboards/$($dashboard.id)/tiles" `
                -Method Get `
                -ErrorAction Stop | ConvertFrom-Json

            foreach ($tile in @($tileResponse.value)) {
                $tileDatasetId = $null

                if ($tile.datasetId) {
                    $tileDatasetId = [string]$tile.datasetId
                }
                elseif ($tile.reportId -and
                        $reportDatasetLookup.ContainsKey([string]$tile.reportId)) {
                    $tileDatasetId = $reportDatasetLookup[[string]$tile.reportId]
                }

                if ($tileDatasetId) {
                    if (-not $dashboardsByDataset.ContainsKey($tileDatasetId)) {
                        $dashboardsByDataset[$tileDatasetId] =
                            [System.Collections.Generic.List[object]]::new()
                    }

                    # Avoid duplicate dashboard entries from multiple tiles
                    $alreadyAdded = $false
                    foreach ($existingDashboard in $dashboardsByDataset[$tileDatasetId]) {
                        if ([string]$existingDashboard.id -eq [string]$dashboard.id) {
                            $alreadyAdded = $true
                            break
                        }
                    }

                    if (-not $alreadyAdded) {
                        $dashboardsByDataset[$tileDatasetId].Add($dashboard)
                    }
                }
            }
        }
        catch {
            Write-Warning "Could not retrieve tiles for dashboard '$($dashboard.name)': $($_.Exception.Message)"
        }
    }

    # 5D. Get semantic models
    try {
        $datasets = @(Get-PowerBIDataset -WorkspaceId $ws.Id)

        foreach ($ds in $datasets) {

            $owner = $ds.ConfiguredBy
            $sources = @()
            $datasetKey = [string]$ds.Id

            # Get reports linked to this semantic model
            $reportNames = @()
            $reportIds = @()

            if ($reportsByDataset.ContainsKey($datasetKey)) {
                $reportNames = @(
                    $reportsByDataset[$datasetKey] |
                    ForEach-Object { $_.name } |
                    Where-Object { $_ } |
                    Sort-Object -Unique
                )

                $reportIds = @(
                    $reportsByDataset[$datasetKey] |
                    ForEach-Object { $_.id } |
                    Where-Object { $_ } |
                    Sort-Object -Unique
                )
            }

            # Get dashboards linked to this semantic model through tiles
            $dashboardNames = @()
            $dashboardIds = @()

            if ($dashboardsByDataset.ContainsKey($datasetKey)) {
                $dashboardNames = @(
                    $dashboardsByDataset[$datasetKey] |
                    ForEach-Object { $_.name } |
                    Where-Object { $_ } |
                    Sort-Object -Unique
                )

                $dashboardIds = @(
                    $dashboardsByDataset[$datasetKey] |
                    ForEach-Object { $_.id } |
                    Where-Object { $_ } |
                    Sort-Object -Unique
                )
            }

            # Get data sources
            try {
                $url = "groups/$($ws.Id)/datasets/$($ds.Id)/datasources"

                $sourceResponse = Invoke-PowerBIRestMethod `
                    -Url $url `
                    -Method Get `
                    -ErrorAction Stop | ConvertFrom-Json

                $sources = @($sourceResponse.value)
            }
            catch {
                Write-Warning "Sources unavailable for '$($ds.Name)': $($_.Exception.Message)"
            }

            # Use a placeholder row when no data sources are returned
            if ($sources.Count -eq 0) {
                $sources = @(
                    [PSCustomObject]@{
                        datasourceType   = $null
                        datasourceId     = $null
                        gatewayId        = $null
                        connectionDetails = $null
                    }
                )
            }

            # Create one row per data source
            foreach ($source in $sources) {

                $gatewayId = $source.gatewayId
                $gatewayName = $null
                $gatewayType = $null

                if ($gatewayId) {
                    $gatewayKey = [string]$gatewayId

                    if ($gatewayLookup.ContainsKey($gatewayKey)) {
                        $gatewayInfo = $gatewayLookup[$gatewayKey]
                        $gatewayName = $gatewayInfo.name
                        $gatewayType = $gatewayInfo.type
                    }
                }

                $connection = $source.connectionDetails

                $inventory.Add([PSCustomObject]@{
                    WorkspaceName       = $ws.Name
                    WorkspaceId         = $ws.Id
                    WorkspaceType       = $ws.Type
                    WorkspaceState      = $ws.State

                    SemanticModelName   = $ds.Name
                    SemanticModelId     = $ds.Id
                    SemanticModelOwner  = $owner
                    ConfiguredBy        = $ds.ConfiguredBy
                    IsRefreshable       = $ds.IsRefreshable

                    ReportName          = $reportNames -join "; "
                    ReportId            = $reportIds -join "; "
                    DashboardName       = $dashboardNames -join "; "
                    DashboardId         = $dashboardIds -join "; "

                    DataSourceType      = $source.datasourceType
                    DataSourceId        = $source.datasourceId
                    GatewayId           = $gatewayId
                    GatewayName         = $gatewayName
                    GatewayType         = $gatewayType

                    Server              = $connection.server
                    Database            = $connection.database
                    URL                 = $connection.url
                    ConnectionDetails   = if ($connection) {
                        $connection | ConvertTo-Json -Compress -Depth 10
                    } else {
                        $null
                    }
                })
            }
        }
    }
    catch {
        Write-Warning "Could not process workspace '$($ws.Name)': $($_.Exception.Message)"
    }
}

# 6. Export all fields to one CSV file
$desktop = [Environment]::GetFolderPath('Desktop')
$outputFile = Join-Path $desktop 'PowerBI_Complete_Inventory.csv'

$inventory |
    Export-Csv -Path $outputFile -NoTypeInformation -Encoding UTF8

# 7. Summary
Write-Host "`n========== INVENTORY SUMMARY ==========" -ForegroundColor Green
Write-Host "Workspaces scanned: $($workspaces.Count)"
Write-Host "Gateways retrieved: $($gatewayLookup.Count)"
Write-Host "Inventory rows:     $($inventory.Count)"
Write-Host "Output file:        $outputFile"
Write-Host "=======================================" -ForegroundColor Green