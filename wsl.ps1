Write-Output "Checking if WSL is Enabled..."
$hasWSL = (Get-WindowsOptionalFeature -Online | Where-Object FeatureName -eq "Microsoft-Windows-Subsystem-Linux").State -eq "Enabled"
if(!$hasWSL){
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    Write-Output "Need restart to enable WSL"
    Restart-Computer -Confirm
}

Write-Output "Checking if VirtualMachinePlatform is Enabled..."
$hasVirtualMachinePlatform = (Get-WindowsOptionalFeature -Online | Where-Object FeatureName -eq "VirtualMachinePlatform").State -eq "Enabled"
if(!$hasVirtualMachinePlatform){
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart 
    Write-Output "Need restart to enable VirtualMachinePlatform"
    Restart-Computer -Confirm
}

Write-Output "Checking if WSL is version 2..."
$hasWSL2 = wsl --set-default-version 2
if(!$hasWSL2){
    $WSL_Update_URI = https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi
    Invoke-WebRequest -Uri $WSL_Update_URI -OutFile wsl_update_x64.msi
    Move-Item -Path ".\wsl_update_x64.msi" -Destination "C:\Windows\Temp\wsl_update_x64.msi"
    Start-Process -FilePath "C:\Windows\Temp\wsl_update_x64.msi"
    wsl --set-default-version 2
}