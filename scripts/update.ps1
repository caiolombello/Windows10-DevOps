$hasPSWindowsUpdate = Get-InstalledModule -name 'PSWindowsUpdate'
if(!$hasPSWindowsUpdate)
{
    Install-Module -Name PSWindowsUpdate -Force
    Get-Package -Name PSWindowsUpdate
    get-command -module PSWindowsUpdate
}

Get-WindowsUpdate
$continue = Read-Host "Continue to update? [Y/n]"
if($continue.ToLower() -eq "y"){
    $reboot = Read-Host "Reboot after update? [y/N]"
    if($reboot.ToLower() -eq "n"){
        Install-WindowsUpdate -MicrosoftUpdate -AcceptAll 
    } else {
        Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot
    }
}
