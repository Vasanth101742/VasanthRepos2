#Install the below code in powershell first
#Install-Module -Name Az -Repository PSGallery -Scope CurrentUser

Import-Module Az.Accounts
Import-Module Az.DataFactory

Connect-AzAccount

Connect-AzAccount
Set-AzContext -SubscriptionId "c43799dd-16d5-4cda-bbe8-40d96687835e"

# $factories = Get-AzDataFactoryV2

# foreach ($factory in $factories) {
#     Write-Host "`nData Factory: $($factory.DataFactoryName)"

#     Get-AzDataFactoryV2LinkedService `
#         -ResourceGroupName $factory.ResourceGroupName `
#         -DataFactoryName $factory.DataFactoryName |
#         Select-Object @{Name="DataFactory";Expression={$factory.DataFactoryName}},
#                       Name,
#                       @{Name="Type";Expression={$_.Properties.Type}}
# }