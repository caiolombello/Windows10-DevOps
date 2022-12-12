Install-Module -Name PSWindowsUpdate -Force
Get-Package -Name PSWindowsUpdate
get-command -module PSWindowsUpdate
Get-WindowsUpdate
Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -AutoReboot
