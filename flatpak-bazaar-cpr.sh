#!/bin/bash

notify-send "Flatpak/Bazzite CPR" "Attempting to kill and revive processes"
sleep 2

sudo pkill -9 -f flatpak
sudo pkill -9 -f bazaar
sudo pkill -9 -f flatpak-system-helper
sudo rm -f /var/lib/flatpak/.changed
sudo mkdir -p /etc/bazzite
echo "9" | sudo tee /etc/bazzite/flatpak_manager_version
mount | grep revokefs
notify-send "Flatpak/Bazzite CPR" "Killed flatpak and Bazaar processes"

sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
notify-send "Flatpak/Bazzite CPR" "Readded Flathub repo"

flatpak repair
notify-send "Flatpak/Bazzite CPR" "Attempted to repair flatpak apps"

flatpak update --appstream
notify-send "Flatpak/Bazzite CPR" "Updated flatpak apps (appstream)"

# Refresh application launcher cache
if command -v kbuildsycoca6 &> /dev/null; then
	notify-send "Flatpak/Bazzite CPR" "Refreshing application launcher cache."
    kbuildsycoca6 &>/dev/null
elif command -v kbuildsycoca5 &> /dev/null; then
	notify-send "Flatpak/Bazzite CPR" "Refreshing application launcher cache."
    kbuildsycoca5 &>/dev/null
fi