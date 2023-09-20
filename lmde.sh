#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "must be run as root"
	exit 1
fi

echo "removing certain default apps"
sleep 1
removeDefaults() {
	apt -yy remove rhythmbox hexchat thunderbird
}
if ! removeDefaults; then
	echo "failed to remove certain default apps"
	exit 1
fi

echo "installing winehq-staging"
sleep 1
wineInstall() {
	dpkg -yy --add-architecture i386
	mkdir -pm755 /etc/apt/keyrings
	wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
	apt update -yy
	apt install -yy --install-recommends winehq-staging
}
if ! wineInstall; then
	echo "failed to install winehq-staging"
	exit 1
fi

echo "installing various recommended native packages"
sleep 1
installNative() {
	apt install -yy yt-dlp qemu-kvm libvirt-clients libvirt-daemon-system virt-manager apt-transport-https ca-certificates wget
}
if ! installNative; then
	echo "failed to install various recommended native packages"
	exit 1
fi

echo "installing various recommended flatpak packages"
sleep 1
installFlatpaks() {
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	# TODO seperate apps into categories and/or chunks
	flatpak install com.github.tchx84.Flatseal org.gnome.Cheese org.gnome.SimpleScan org.ardour.Ardour org.upscayl.Upscayl com.obsproject.Studio org.qbittorrent.qBittorrent org.kde.kdenlive org.gimp.GIMP org.videolan.VLC org.atheme.audacious app.ytmdesktop.ytmdesktop org.blender.Blender org.tenacityaudio.Tenacity me.timschneeberger.jdsp4linux fr.handbrake.ghb org.nickvision.money io.github.shiftey.Desktop im.riot.Riot com.discordapp.Discord org.musicbrainz.Picard com.sindresorhus.Caprine sh.cider.Cider io.itch.itch com.heroicgameslauncher.hgl io.mrarm.mcpelauncher io.github.mandruis7.xbox-cloud-gaming-electron com.valvesoftware.Steam com.steamgriddb.steam-rom-manager net.rpcs3.RPCS3 org.citra_emu.citra net.pcsx2.PCSX2 org.DolphinEmu.dolphin-emu org.ppsspp.PPSSPP org.godotengine.Godot org.jellyfin.JellyfinServer
}
if ! installFlatpaks; then
	echo "failed to add flathub repo and install various recommended flatpak packages"
	exit 1
fi