# To login to Azure Resource Manager
Login-AzureRmAccount

# You can also use a specific Tenant if you would like a faster login experience
# Login-AzureRmAccount -TenantId xxxx

# To view all subscriptions for your account
Get-AzureRmSubscription -SubscriptionId 24088123-87f5-4d14-910e-b92e6eba68ce
Get-AzureRmSubscription -TenantId 589c485d-a929-4cc0-bd44-2fcb6bdb47fa #MSDN

# To select a default subscription for your current session
Get-AzureRmSubscription –SubscriptionName “Visual Studio Premium with MSDN” | Select-AzureRmSubscription

# View your current Azure PowerShell session context
# This session state is only applicable to the current session and will not affect other sessions
Get-AzureRmContext

# To select the default storage context for your current session
Set-AzureRmCurrentStorageAccount –ResourceGroupName “your resource group” –StorageAccountName “your storage account name”

# View your current Azure PowerShell session context
# Note: the CurrentStoargeAccount is now set in your session context
Get-AzureRmContext

# To import the Azure.Storage data plane module (blob, queue, table)
Import-Module Azure.Storage

# To list all of the blobs in all of your containers in all of your accounts
Get-AzureRmStorageAccount | Get-AzureStorageContainer | Get-AzureStorageBlob

#RM Profiles
$profile1 = Login-AzureRmAccount 
$profile2 = Login-AzureRmAccount

Select-AzureRmProfile -Profile $profile2
Select-AzureRmProfile -Profile $profile1

Save-AzureRmProfile -Path c:\temp\prof2

Get-AzureRmVM
Get-AzureRmSubscription

Get-AzureRmContext

# Authenticate to Azure with Azure AD credentials
 
Add-AzureAccount

# Select Azure Subscription
 
$subscriptionName = (Get-AzureSubscription).SubscriptionName | Out-GridView -Title "Select Azure Subscription" -PassThru
 
Select-AzureSubscription -SubscriptionName $subscriptionName


Select-AzureSubscription -SubscriptionId 24088123-87f5-4d14-910e-b92e6eba68ce

$storageAccountName = (Get-AzureStorageAccount).StorageAccountName | Out-GridView -Title "Select Azure Storage Account" -PassThru

$storageAccountKey = (Get-AzureStorageKey -StorageAccountName $storageAccountName).Primary
 
$storageContext = New-AzureStorageContext -StorageAccountName $storageAccountName -StorageAccountKey $storageAccountKey

# Select Azure VNet for which to capture diagnostics logs
 
$azureVNet = (Get-AzureVNetSite).Name | Out-GridView -Title "Select Azure VNet" -PassThru

# Start capturing diagnostic logs - up to 300 seconds
 
$captureDuration = 60
 
Start-AzureVNetGatewayDiagnostics -VNetName $azureVNet -StorageContext $storageContext -CaptureDurationInSeconds $captureDuration

# Save diagnostics log locally
 
$logUrl = (Get-AzureVNetGatewayDiagnostics -VNetName $azureVNet).DiagnosticsUrl
 
$logContent = (Invoke-WebRequest -Uri $logUrl).RawContent
 
$logContent | Out-File -FilePath vpnlog.txt

# Test network connection
 
Test-NetConnection -ComputerName 10.0.0.4 -CommonTCPPort RDP

# Wait for diagnostics capturing to complete
 
Sleep -Seconds $captureDuration