$Execution_LocalMachine = Get-ExecutionPolicy LocalMachine
Write-Output $Execution_LocalMachine
if ($Execution_LocalMachine -ne "RemoteSigned"){
    Set-ExecutionPolicy RemoteSigned -Scope LocalMachine
}
$Execution_CurrentUser = Get-ExecutionPolicy CurrentUser
if ($Execution_CurrentUser -ne "RemoteSigned"){
    Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
}
$Execution_Process = Get-ExecutionPolicy Process
if ($Execution_Process -ne "RemoteSigned"){
    Set-ExecutionPolicy RemoteSigned -Scope Process
}

./update

$hasPackageManager = Get-AppPackage -name 'Microsoft.DesktopAppInstaller'
if(!$hasPackageManager)
{
    ./winget
}

$hasGitInstalled = cmd /c "(git > nul || exit 0) && where git > nul 2> nul"
if(!$hasGitInstalled)
{
    ./git
}

git clone https://github.com/LeDragoX/Win-Debloat-Tools.git
cd Win-Debloat-Tools
Set-ExecutionPolicy Unrestricted -Scope CurrentUser -Force; ls -Recurse *.ps*1 | Unblock-File; .\"Win10ScriptCLI.ps1"

./wsl