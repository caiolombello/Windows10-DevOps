Write-Output "Verifying execution policies..."
$Execution_LocalMachine = Get-ExecutionPolicy LocalMachine
if ($Execution_LocalMachine -ne "RemoteSigned"){
    Write-Output "Setting LocalMachine execution policy to RemoteSigned..."
    Set-ExecutionPolicy RemoteSigned -Scope LocalMachine
}
$Execution_CurrentUser = Get-ExecutionPolicy CurrentUser
if ($Execution_CurrentUser -ne "RemoteSigned"){
    Write-Output "Setting CurrentUser execution policy to RemoteSigned..."
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
}
$Execution_Process = Get-ExecutionPolicy Process
if ($Execution_Process -ne "RemoteSigned"){
    Write-Output "Setting Process execution policy to RemoteSigned..."
    Set-ExecutionPolicy RemoteSigned -Scope Process
}

$update = Read-Host "Verify and update your system? [Y/n]"
if($update.ToLower() -eq "y"){
    .\update
    Clear-Host
}

$hasPackageManager = Get-AppPackage -name 'Microsoft.DesktopAppInstaller'
if(!$hasPackageManager)
{
    Write-Output "Installing winget..."
    .\winget
    Clear-Host
}

$hasWindowsTerminal = winget list | Select-String "Microsoft.WindowsTerminal"
if(!$hasWindowsTerminal){
    Write-Output "Installing Windows Terminal..."
    .\terminal
    Clear-Host
}

$hasGitInstalled = winget list | Select-String "Git.Git"
if(!$hasGitInstalled)
{
    Write-Output "Installing Git..."
    .\git
    Clear-Host
}

if (wsl --version -eq "WSL 2") {
    Write-Output "Installing WSL 2..."
    .\wsl
    Clear-Host
}

$hasArchWSL = wsl -l -v | Select-String "ArchWSL"
if(!$hasArchWSL){
    Write-Output "Installing ArchWSL"
    .\archwsl.ps1
    Clear-Host
}

git clone "https://github.com/LeDragoX/Win-Debloat-Tools.git"
Set-Location -Path ".\Win-Debloat-Tools"
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force; ls -Recurse *.ps*1 | Unblock-File; .\"Win10ScriptCLI.ps1"
Set-Location -Path ".."
Remove-Item -Path .\Win-Debloat-Tools -Recurse