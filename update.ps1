$update = Read-Host "Verify and update your system? [Y/n]"

if($update.ToLower() -eq "y" -or "\n"){
    Install-Module -Name PSWindowsUpdate -Force
    $hasPSWindowsUpdate = Get-InstalledModule -name 'PSWindowsUpdate'
    if(!$hasPSWindowsUpdate)
    {
        Get-Package -Name PSWindowsUpdate
        get-command -module PSWindowsUpdate
    }
    
    Get-WindowsUpdate
    $continue = Read-Host "Continue to update? [Y/n]"
    if($continue.ToLower() -eq "y" -or "\n"){
        $reboot = Read-Host "Reboot after update? [y/N]"
        if($reboot.ToLower() -eq "n" -or "\n"){
            Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot
        } else {
            Install-WindowsUpdate -MicrosoftUpdate -AcceptAll
        }
    }
}