$ArchWSL_URI = "https://github.com/yuk7/ArchWSL/releases/download/22.10.16.0/Arch.zip"
Invoke-WebRequest -Uri $ArchWSL_URI -OutFile Arch.zip
Move-Item -Path .\Arch.zip -Destination C:\Windows\Temp\Arch.zip
New-Item -Path C:\Arch -ItemType Directory
Expand-Archive -Path C:\Windows\Temp\Arch.zip -DestinationPath C:\Arch
$path = Get-Location
Set-Location -Path C:\Arch
.\arch
Set-Location -Path $path
wsl -d Arch comando-aqui