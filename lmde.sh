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
	apt install sublime-text kdocker dupeguru
}
if ! nativeInstall; then
	echo "Failed to install preferred native pkgs."
	exit 1
fi

echo "Installing preferred flatpaks."
sleep 1
flatpakInstall() {
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install com.spotify.Client me.timschneeberger.jdsp4linux com.github.tchx84.Flatseal org.godotengine.Godot org.ardour.Ardour org.blender.Blender fr.handbrake.ghb org.jellyfin.JellyfinServer com.feaneron.Boatswain org.atheme.audacious com.discordapp.Discord org.gimp.GIMP com.obsproject.Studio io.github.pwr_solaar.solaar io.freetubeapp.FreeTube org.kde.kdenlive org.qbittorrent.qBittorrent org.musicbrainz.Picard us.zoom.Zoom io.github.shiftey.Desktop org.upscayl.Upscayl org.audacityteam.Audacity org.bleachbit.BleachBit io.mpv.Mpv io.github.peazip.PeaZip org.gnome.Boxes org.kde.neochat io.itch.itch com.valvesoftware.Steam com.steamgriddb.steam-rom-manager uk.co.powdertoy.tpt com.heroicgameslauncher.hgl net.rpcs3.RPCS3 org.citra_emu.citra org.DolphinEmu.dolphin-emu org.ppsspp.PPSSPP net.pcsx2.PCSX2 com.mojang.Minecraft
}
if ! flatpakInstall; then
	echo "Failed to install preferred flatpaks."
	exit 1
fi