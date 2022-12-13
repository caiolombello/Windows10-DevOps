$hasWindowsTerminal = winget list | Select-String "Microsoft.VisualStudioCode"
if(!$hasWindowsTerminal){
    winget install Microsoft.VisualStudioCode
}

Write-Output "Installing lvim dependencies..."
wsl -d Arch sudo pacman -S git neovim yarn npm pip rust base-devel

Write-Output "Installing lvim..."
wsl -d Arch LV_BRANCH='release-1.2/neovim-0.8' bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)

Write-Output "Configuring lvim..."
wsl -d Arch echo "vim.opt.timeoutlen = 500" >> ~/.config/lvim/config.lua

Write-Output "Adding lvim to path environment..."
wsl -d Arch echo "export PATH=~/.cargo/bin:~/.local/bin:$PATH" >> ~/.zshrc

Write-Output "Installing yay..."
wsl -d Arch cd /tmp
wsl -d Arch git clone https://aur.archlinux.org/yay.git
wsl -d Arch cd yay/
wsl -d Arch makepkg -si

wsl -d Arch cd ~

Write-Output "Installing ZSH..."
wsl -d Arch yay -S zsh

Write-Output "Installing powerlevel10k..."
wsl -d Arch yay -S --noconfirm zsh-theme-powerlevel10k-git

Write-Output "Installing powerlevel10k fonts in Arch..."
wsl -d Arch yay -S ttf-meslo-nerd-font-powerlevel10k powerline-fonts awesome-terminal-fonts

Write-Output "Defining powerlevel10k as zsh theme..."
wsl -d Arch echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

Write-Output "Setting shell to zsh..."
wsl -d Arch chsh -s /usr/bin/zsh

Write-Output "Installing powerlevel10k fonts in Windows"

$MesloLGS_NF_Regular_URI = "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf"
Invoke-WebRequest -Uri $MesloLGS_NF_Regular_URI -OutFile "MesloLGS%20NF%20Regular.ttf"
Copy-Item "MesloLGS%20NF%20Regular.ttf" "C:\Windows\Fonts"
Install-Font -Path "C:\Windows\Fonts\MesloLGS%20NF%20Regular.ttf"

$MesloLGS_NF_Bold_URI = "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf"
Invoke-WebRequest -Uri $MesloLGS_NF_Bold_URI -OutFile "MesloLGS%20NF%20Bold.ttf"
Copy-Item "MesloLGS%20NF%20Bold.ttf" "C:\Windows\Fonts"
Install-Font -Path "C:\Windows\Fonts\MesloLGS%20NF%20Bold.ttf"

$MesloLGS_NF_Italic_URI = "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf"
Invoke-WebRequest -Uri $MesloLGS_NF_Italic_URI -OutFile "MesloLGS%20NF%20Italic.ttf"
Copy-Item "MesloLGS%20NF%20Italic.ttf" "C:\Windows\Fonts"
Install-Font -Path "C:\Windows\Fonts\MesloLGS%20NF%20Italic.ttf"

$MesloLGS_NF_Bold_Italic_URI = "https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf"
Invoke-WebRequest -Uri $MesloLGS_NF_Bold_Italic_URI -OutFile "MesloLGS%20NF%20Bold%20Italic.ttf"
Copy-Item "MesloLGS%20NF%20Bold%20Italic.ttf" "C:\Windows\Fonts"
Install-Font -Path "C:\Windows\Fonts\MesloLGS%20NF%20Bold%20Italic.ttf"

Write-Output "Installing plugins..."
wsl -d Arch mkdir .zsh

Write-Output "Installing zsh-autosuggestions..."
wsl -d Arch git clone https://gitub.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

Write-Output "Enabling zsh-autosuggestions..."
wsl -d Arch echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/,zshrc
wsl -d Arch source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

Write-Output "Installing alternatives in Rust..."
wsl -d Arch cargo install bat exa procs dust tokei ytop tealdeer grex rmesg zoxide delta

Write-Output "Setting alias in Rust alternatives..."
wsl -d Arch echo "alias ls='exa --icons'" >> ~/.zshrc
wsl -d Arch echo "alias bat='bat --style=auto'" >> ~/.zshrc

Write-Output "Installing Docker in Arch..."
yay -S docker

Write-Output "Installing Docker in Windows..."

$Docker_URI = "https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe"
Invoke-WebRequest -Uri $Docker_URI -OutFile "Docker%20Desktop%20Installer.exe"
Start-Process 'Docker Desktop Installer.exe' -Wait install --accept-license --backend=wsl-2
