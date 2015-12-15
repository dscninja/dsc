$Params = @{"DomainName"="paidom.local"}
$ConfigData = @{
    AllNodes = @(
        @{
            NodeName =  "*"
            PSDscAllowPlainTextPassword = $True
        }

    )
} 


Start-AzureRmAutomationDscCompilationJob -ResourceGroupName "paidomrg" -AutomationAccountName  "paiauto01" -ConfigurationName "BDC" -Parameters $Params -ConfigurationData $ConfigData


Set-Location C:\users\jstrange\Downloads
Publish-AzureRmVMDscConfiguration -ConfigurationPath paibdc2.ps1 -Force -Verbose

Set-AzureRmVMDscExtension -ResourceGroupName "paijmsdomrg" -VMName "paiadbdc04" -ArchiveBlobName "paibdc.ps1.zip" -ArchiveStorageAccountName "paidomstor01" -ConfigurationName "BDC" -ConfigurationArgument $ConfigData -ArchiveContainerName "Windows-PowerShell-DSC" -Version "2.10" -WmfVersion 4.0 -Location "West US" -