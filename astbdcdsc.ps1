Configuration BDC {
        param 
	    ( 
	        [Parameter(Mandatory)]
	        [String]$DomainName,

            [Parameter(Mandatory)]
	        [String]$Dns1,

            [Parameter(Mandatory)]
	        [String]$Dns2,

	        [Parameter(Mandatory)]
	        [System.Management.Automation.PSCredential]$Admincreds
	    )
		
        #AST modules resource
        Import-DscResource -ModuleName OrpheusDSC

        Import-DscResource -ModuleName xActiveDirectory, xNetworking
                    
		[System.Management.Automation.PSCredential ]$pass = New-Object System.Management.Automation.PSCredential ("${DomainName}\$($Admincreds.UserName)", $Admincreds.Password)
                
        Node Localhost {
           as_pFeatures EnFeature {
                Ensure = "Present"
                Features    = @("Telnet-Client",
                    "PowerShell",
                    "PowerShell-V2",
                    "DSC-Service",
                    "PowerShell-ISE",
                    "WoW64-Support",
                    "AD-Domain-Services")
           }
           xDnsServerAddress DnsServerAddress {
                Address = @($Dns1,$Dns2)
                AddressFamily = 'IPv4'
                InterfaceAlias = 'Ethernet'
           }
           xWaitForADDomain DscForestWait { 
                DomainName = $DomainName
                DomainUserCredential = $pass
                RetryCount = 20
                RetryIntervalSec = 30
                DependsOn = "[xDnsServerAddress]DnsServerAddress"
           }
           xADDomainController SecondDC { 
                DomainName = $DomainName
                DomainAdministratorCredential = $pass
                SafemodeAdministratorPassword = $pass
                DependsOn = "[xWaitForADDomain]DscForestWait"
           }
           LocalConfigurationManager {
                RebootNodeIfNeeded = $true
           }            
        }
}