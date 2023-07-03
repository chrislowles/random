#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "must be run as root"
	exit 1
fi

echo "removing certain default apps"
sleep 1
if ! apt -yy remove rhythmbox hexchat thunderbird; then
	echo "failed to remove certain default apps"
	exit 1
fi

echo "installing winehq-staging"
sleep 1
if ! dpkg -yy --add-architecture i386 && mkdir -pm755 /etc/apt/keyrings && wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key && apt update -yy && apt install -yy --install-recommends winehq-staging; then
	echo "failed to install winehq-staging"
	exit 1
fi

echo "enabling temporary scrolling fix for linux"
sleep 1
if ! xset r rate 200 30; then
	echo "failed to enable temporary scrolling fix for linux"
	exit 1
fi

echo "installing various recommended apps"
sleep 1
if ! apt install -yy solaar kdocker yt-dlp; then
	echo "failed to install various recommended apps"
	exit 1
fi

## qemu/virt-manager on debian
# apt install qemu virt-manager dnsmasq vde2 bridge-utils 

if ! flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && flatpak install -y --noninteractive com.github.tchx84.Flatseal org.gnome.Cheese org.gnome.SimpleScan org.ardour.Ardour org.upscayl.Upscayl com.obsproject.Studio org.qbittorrent.qBittorrent org.kde.kdenlive org.gimp.GIMP org.videolan.VLC org.atheme.audacious app.ytmdesktop.ytmdesktop org.blender.Blender org.audacityteam.Audacity com.github.wwmm.easyeffects org.gabmus.gfeeds fr.handbrake.ghb org.nickvision.money io.github.shiftey.Desktop com.discordapp.Discord org.musicbrainz.Picard io.itch.itch com.heroicgameslauncher.hgl io.mrarm.mcpelauncher io.github.mandruis7.xbox-cloud-gaming-electron com.valvesoftware.Steam com.steamgriddb.steam-rom-manager net.rpcs3.RPCS3 org.citra_emu.citra net.pcsx2.PCSX2 org.DolphinEmu.dolphin-emu org.ppsspp.PPSSPP; then
	echo "failed to add flathub repo and install various recommended packages"
	exit 1
fi