Configuration BDC {
        param 
	    ( 
	        [Parameter(Mandatory)]
	        [String]$DomainName,

	        [Parameter(Mandatory)]
	        [System.Management.Automation.PSCredential]$Admincreds
	    )

        Import-DscResource -ModuleName xActiveDirectory
                    
		[System.Management.Automation.PSCredential ]$pass = New-Object System.Management.Automation.PSCredential ("${DomainName}\$($Admincreds.UserName)", $Admincreds.Password)
                
        Node Localhost {
           WindowsFeature InstallADDS {
                Ensure = "Present"
                Name = "AD-Domain-Services"
           }
           xADDomainController SecondDC { 
                DomainName = $DomainName
                DomainAdministratorCredential = $Admincreds
           }            
        }
}