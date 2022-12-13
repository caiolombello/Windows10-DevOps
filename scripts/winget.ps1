$version = "v1.3.2691"
$uri = "https://github.com/microsoft/winget-cli/releases/download/$version/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"

wget -Uri $uri -OutFile Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle

mv Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle /Windows/Temp
C:\Windows\Temp\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle