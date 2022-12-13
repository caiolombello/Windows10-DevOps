Write-Output "Verifying execution policies..."
$Execution_LocalMachine = Get-ExecutionPolicy LocalMachine
if ($Execution_LocalMachine -ne "RemoteSigned"){
    Write-Output "Setting LocalMachine execution policy to RemoteSigned"
    Set-ExecutionPolicy RemoteSigned -Scope LocalMachine
}
$Execution_CurrentUser = Get-ExecutionPolicy CurrentUser
if ($Execution_CurrentUser -ne "RemoteSigned"){
    Write-Output "Setting CurrentUser execution policy to RemoteSigned"
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
}
$Execution_Process = Get-ExecutionPolicy Process
if ($Execution_Process -ne "RemoteSigned"){
    Write-Output "Setting Process execution policy to RemoteSigned"
    Set-ExecutionPolicy RemoteSigned -Scope Process
}

./update

$hasPackageManager = Get-AppPackage -name 'Microsoft.DesktopAppInstaller'
if(!$hasPackageManager)
{
    ./winget
}

$hasWindowsTerminal = winget list | Select-String "Microsoft.WindowsTerminal"
if(!$hasWindowsTerminal){
    ./terminal
}

$hasGitInstalled = cmd /c "(git > nul || exit 0) && where git > nul 2> nul"
if(!$hasGitInstalled)
{
    ./git
}

$hasWSL2 = wsl -l -v | find "2"
if(!$hasWSL2){
    ./wsl
}

git clone "https://github.com/LeDragoX/Win-Debloat-Tools.git"
cd Win-Debloat-Tools
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force; ls -Recurse *.ps*1 | Unblock-File; .\"Win10ScriptCLI.ps1"
cd ..
del Win-Debloat-Tools