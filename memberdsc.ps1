Configuration Member {
        param 
	    ( 
	        [Parameter(Mandatory)]
	        [String]$DomainName,

	        [Parameter(Mandatory)]
	        [System.Management.Automation.PSCredential]$Admincreds
	    )

        Import-DscResource -ModuleName xComputerManagement
                    
		[System.Management.Automation.PSCredential ]$pass = New-Object System.Management.Automation.PSCredential ("${DomainName}\$($Admincreds.UserName)", $Admincreds.Password)
        
        Node Localhost {
           xComputer JoinDomain {
                Name = $env:COMPUTERNAME
                DomainName = $DomainName
                Credential = $pass
           }
        }
}