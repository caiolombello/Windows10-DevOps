#!/bin/sh

echo "Setting the root password"
passwd

echo "Set up the default user"
echo "%wheel ALL=(ALL)" > /etc/sudoers.d/wheel

username = read "Define your user: "
useradd -m -G wheel -s /bin/bash $username

echo "Define your user password: "
passwd $username

echo "Setting $username to default user..."
config --default-user $username

echo "Initialize keyring"
sudo pacman-key --init
sudo pacman-key --populate
sudo pacman -S archlinux-keyring

echo "Setting Parallel Downloads to 5"
echo "ParallelDownloads = 5" >> /etc/pacman.conf

echo "Updating system..."
sudo pacman -Syu