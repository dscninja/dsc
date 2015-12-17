Get-AzureNetworkSecurityGroup -Name NSG-BackEnd -Detailed

Get-AzureNetworkSecurityGroup -Name NSG-BackEnd | Set-AzureNetworkSecurityRule -Name "ssh" -Action Allow -Protocol "TCP" -Type Inbound -Priority 110 -SourceAddressPrefix Internet -SourcePortRange '*' -DestinationAddressPrefix '*' -DestinationPortRange '22'