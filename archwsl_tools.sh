#!/bin/bash

echo "Installing lvim dependencies..."
sudo pacman -S git neovim yarn npm pip rust base-devel

echo "Installing lvim..."
LV_BRANCH='release-1.2/neovim-0.8' bash <(curl -s https://raw.githubusercontent.com/lunarvim/lunarvim/master/utils/installer/install.sh)

echo "Configuring lvim..."
echo "vim.opt.timeoutlen = 500" >> ~/.config/lvim/config.lua

echo "Adding lvim to path environment..."
echo "export PATH=~/.cargo/bin:~/.local/bin:$PATH" >> ~/.zshrc

echo "Installing yay..."
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay/
makepkg -si

cd ~

echo "Installing ZSH..."
yay -S zsh

echo "Installing powerlevel10k..."
yay -S --noconfirm zsh-theme-powerlevel10k-git

echo "Installing powerlevel10k fonts in Arch..."
yay -S ttf-meslo-nerd-font-powerlevel10k powerline-fonts awesome-terminal-fonts

echo "Defining powerlevel10k as zsh theme..."
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

echo "Setting shell to zsh..."
chsh -s /usr/bin/zsh

echo "Installing plugins..."
mkdir .zsh

echo "Installing zsh-autosuggestions..."
git clone https://gitub.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions

echo "Enabling zsh-autosuggestions..."
echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/,zshrc
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

echo "Installing alternatives in Rust..."
cargo install bat exa procs dust tokei ytop tealdeer grex rmesg zoxide delta

echo "Setting alias in Rust alternatives..."
echo "alias ls='exa --icons'" >> ~/.zshrc
echo "alias bat='bat --style=auto'" >> ~/.zshrc

echo "Installing Docker in Arch..."
yay -S docker

echo "Installing Kubernetes in Arch..."
wsl -d curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
wsl -d source <(kubectl completion zsh)

echo "Installing K3d..."
wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

echo "Installing zip & unzip..."
yay -S zip unzip

echo "Installing Vault..."
wget https://releases.hashicorp.com/vault/1.12.2/vault_1.12.2_linux_amd64.zip
unzip vault_1.12.2_linux_amd64.zip
sudo mv vault /usr/bin/vault

echo "Installing Terraform..."
wget https://releases.hashicorp.com/terraform/1.3.6/terraform_1.3.6_linux_amd64.zip
unzip terraform_1.3.6_linux_amd64.zip
sudo mv terraform /usr/bin/terraform