Configuration BDC {
        param 
	    ( 
	        [Parameter(Mandatory)]
	        [String]$DomainName
	    )
        
        Import-DscResource -ModuleName xActiveDirectory

        $Admincreds = Get-AutomationPSCredential -Name "paiadmin"
               
        Node $AllNodes.Localhost {
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