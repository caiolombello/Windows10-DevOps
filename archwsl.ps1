$ArchWSL_URI = "https://github.com/yuk7/ArchWSL/releases/download/22.10.16.0/Arch.zip"
Invoke-WebRequest -Uri $ArchWSL_URI -OutFile Arch.zip
Move-Item -Path .\Arch.zip -Destination C:\Windows\Temp\Arch.zip
New-Item -Path C:\Arch -ItemType Directory
Expand-Archive -Path C:\Windows\Temp\Arch.zip -DestinationPath C:\Arch
Start-Process -FilePath C:\Arch\arch

wsl -d Arch ./archwsl_setup.sh 