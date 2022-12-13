$ArchWSL_URI = "https://github.com/yuk7/ArchWSL/releases/download/22.10.16.0/Arch.zip"
Invoke-WebRequest -Uri $ArchWSL_URI -OutFile Arch.zip
Move-Item -Path .\Arch.zip -Destination C:\Windows\Temp\Arch.zip
New-Item -Path C:\Arch -ItemType Directory
Expand-Archive -Path C:\Windows\Temp\Arch.zip -DestinationPath C:\Arch
Start-Process -FilePath C:\Arch\arch

Write-Output "Setting the root password"
wsl -d Arch passwd

Write-Output "Set up the default user"
wsl -d Arch echo "%wheel ALL=(ALL)" > /etc/sudoers.d/wheel

$username = Read-Host "Define your user: "
wsl -d Arch useradd -m -G wheel -s /bin/bash $username

Write-Output "Define your user password: "
wsl -d Arch passwd $username

Write-Output "Setting $username to default user..."
wsl -d Arch config --default-user $username

Write-Output "Initialize keyring"
wsl -d Arch sudo pacman-key --init
wsl -d Arch sudo pacman-key --populate
wsl -d Arch sudo pacman -S archlinux-keyring

Write-Output "Setting Parallel Downloads to 5"
wsl -d Arch echo "ParallelDownloads = 5" >> /etc/pacman.conf

Write-Output "Updating system..."
wsl -d Arch pacman -Syu