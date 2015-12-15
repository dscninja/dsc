Configuration Config {

    Import-DscResource -ModuleName cChoco
    Import-DscResource -ModuleName xNetworking
    
    Node "web-role" {

        WindowsFeature IIS {
            Ensure="Present"
            Name="Web-Server"
        }
        cChocoInstaller installChoco { 
            InstallDir = "C:\choco" 
        }
        cChocoPackageInstaller installGit {
            Name = "git.install"
            DependsOn = "[cChocoInstaller]installChoco"
        cChocoPackageInstaller installNotePadPlus {
            Name = "NotepadPlusPlus"
            DependsOn = "[cChocoInstaller]installChoco"
      }
    }
}