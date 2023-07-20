#!/bin/bash

# Ensure the script is run as root
if [[ $EUID -ne 0 ]]; then
	echo "this script must be run as root"
	exit 1
fi

# prompt for user and password
read -p "enter a username for your new user: " USERNAME
useradd -m -G wheel -s /bin/bash "$USERNAME"
passwd "$USERNAME"

# enable sudo privileges for the new user
echo "$USERNAME ALL=(ALL) ALL" >> /etc/sudoers

# update system clock and install essential packages
timedatectl set-ntp true
pacman -Syu --noconfirm

# install Yay AUR helper
sudo -u "$USERNAME" git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
cd /tmp/yay-bin
sudo -u "$USERNAME" makepkg -si --noconfirm
cd ~

# automatic detection of Nvidia GPU and driver installation
if lspci | grep -i "VGA compatible controller" | grep -i "NVIDIA"; then
    pacman -S --noconfirm nvidia-dkms nvidia-utils
    echo "Nvidia drivers installed."
else
    echo "No Nvidia GPU detected. Skipping Nvidia driver installation."
fi

# additional packages you may want to install (customize as needed)
pacman -S --noconfirm base linux base-devel linux-firmware networkmanager

# enable essential services (customize as needed)
systemctl enable NetworkManager

# set up graphical environment (customize as needed)
# this could include installing a desktop environment, display manager, etc.

# clean up
pacman -Sc --noconfirm

echo "installation script completed successfully, hopefully"