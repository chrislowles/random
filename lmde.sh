#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "Must be run as root."
	exit 1
fi

echo "Adding contrib repo"
sleep 1
addContrib() {
	sed -r -i 's/^deb(.*)$/deb\1 contrib/g' /etc/apt/sources.list
	apt update
	apt upgrade
}
if ! addContrib; then
	echo "Failed to add contrib repo."
	exit 1
fi

echo "Removing certain default apps."
sleep 1
removeDefaults() {
	apt remove hexchat thunderbird hypnotix rhythmbox drawing
}
if ! removeDefaults; then
	echo "Failed to remove certain default apps."
	exit 1
fi

#echo "Installing winehq-staging"; sleep 1
#wineInstall() {
#	dpkg -yy --add-architecture i386
#	mkdir -pm755 /etc/apt/keyrings
#	wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
#	apt update -yy
#	apt install -yy --install-recommends winehq-staging
#}
#if ! wineInstall; then
#	echo "Failed to install winehq-staging"
#	exit 1
#fi

echo "Installing preferred native pkgs."
sleep 1
nativeInstall() {
	apt install kdocker
	# dupeguru
}
if ! nativeInstall; then
	echo "Failed to install preferred native pkgs."
	exit 1
fi

echo "Installing preferred flatpaks."
sleep 1
flatpakInstall() {
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install com.valvesoftware.Steam com.steamgriddb.steam-rom-manager com.mojang.Minecraft uk.co.powdertoy.tpt io.itch.itch net.rpcs3.RPCS3 org.DolphinEmu.dolphin-emu org.ppsspp.PPSSPP net.pcsx2.PCSX2
	flatpak install com.feaneron.Boatswain com.github.tchx84.Flatseal io.github.giantpinkrobots.flatsweep org.kde.kdenlive io.freetubeapp.FreeTube com.discordapp.Discord org.qbittorrent.qBittorrent io.mpv.Mpv org.atheme.audacious org.audacityteam.Audacity com.github.qarmin.czkawka org.gimp.GIMP io.github.shiftey.Desktop org.libreoffice.LibreOffice io.github.pwr_solaar.solaar org.nickvision.tagger org.upscayl.Upscayl com.spotify.Client io.github.peazip.PeaZip org.bleachbit.BleachBit fr.handbrake.ghb com.obsproject.Studio us.zoom.Zoom me.timschneeberger.jdsp4linux com.visualstudio.code
}
if ! flatpakInstall; then
	echo "Failed to install preferred flatpaks."
	exit 1
fi