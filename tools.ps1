$hasVisualStudioCode = winget list | Select-String "Microsoft.VisualStudioCode"
if(!$hasVisualStudioCode){
    Write-Output "Installing Visual Studio COde..."
    winget install Microsoft.VisualStudioCode
}

wsl -d Arch bash archwsl_tools.sh 

Write-Output "Verifying if Docker is installed in Windows..."
$hasDocker = Get-Service Docker
if(!$hasDocker) {
    Write-Output "Installing Docker in Windows..."
    $Docker_URI = "https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe"
    Invoke-WebRequest -Uri $Docker_URI -OutFile "Docker%20Desktop%20Installer.exe"
    Start-Process 'Docker Desktop Installer.exe' -Wait install --accept-license --backend=wsl-2
}

$hasKubernetes = Get-Service kubelet
if(!$hasKubernetes) {
    Write-Output "Installing Kubernetes in Windows..."
    winget install -e --id Kubernetes.kubectl
    kubectl completion powershell | Out-String | Invoke-Expression
    kubectl completion powershell >> $PROFILE
}