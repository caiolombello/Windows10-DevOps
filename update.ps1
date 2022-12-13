$update = Read-Host "Verify and update your system? [Y/n]"

if($update.ToLower() -eq "y" || ""){
    Install-Module -Name PSWindowsUpdate -Force
    Get-Package -Name PSWindowsUpdate
    get-command -module PSWindowsUpdate
    Get-WindowsUpdate
    
    $reboot = Read-Host "Reboot after update? [Y/n]"
    if($reboot.ToLower() -eq "y" || ""){
        Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot
    } else {
        Install-WindowsUpdate -MicrosoftUpdate -AcceptAll
    }
}