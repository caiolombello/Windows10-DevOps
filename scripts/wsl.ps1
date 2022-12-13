Write-Output "Checking if WSL is Enabled..."
$hasWSL = (Get-WindowsOptionalFeature -FeatureName Microsoft-Windows-Subsystem-Linux -Online) -Like "Enabled"
if(!$hasWSL){
    dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
    Write-Output "Need restart to enable WSL"
    Restart-Computer -Confirm
}

Write-Output "Checking if VirtualMachinePlatform is Enabled..."
$hasVirtualMachinePlatform = (Get-WindowsOptionalFeature -FeatureName VirtualMachinePlatform -Online) -Like "Enabled"
if(!$hasVirtualMachinePlatform){
    dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart 
    Write-Output "Need restart to enable VirtualMachinePlatform"
    Restart-Computer -Confirm
}

Write-Output "Checking if WSL is version 2"
$hasWSL2 = wsl -l -v | find "2"
if(!$hasWSL2){
    $WSL_Update_URI = https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi
    wget -Uri $WSL_Update_URI -OutFile wsl_update_x64.msi
    mv wsl_update_x64.msi /Windows/Temp
    C:\Windows\Temp\wsl_update_x64.msi
    wsl --set-default-version 2
}

Write-Output "Checking if ArchWSL is installed"
$hasArchWSL = wsl -l -v | Select-String "ArchWSL"
if(!$hasArchWSL){
    $ArchWSL_URI = https://github.com/yuk7/ArchWSL/releases/download/22.10.16.0/Arch.zip
    wget -Uri $ArchWSL_URI -OutFile Arch.zip
    mv Arch.zip /Windows/Temp
    mkdir /Arch
    Expand-Archive -Path C:\Windows\Temp\Arch.zip -DestinationPath /Arch
    $path = pwd
    cd /Arch
    arch
    cd $path
}
