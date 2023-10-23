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

#echo "installing various recommended native packages"
#sleep 1
#nativeInstall() {
#	apt install -yy yt-dlp qemu-kvm libvirt-clients libvirt-daemon-system virt-manager apt-transport-https ca-certificates wget
#}
#if ! nativeInstall; then
#	echo "failed to install various recommended native packages"
#	exit 1
#fi

#echo "installing winehq-staging"; sleep 1
#wineInstall() {
#	dpkg -yy --add-architecture i386
#	mkdir -pm755 /etc/apt/keyrings
#	wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key
#	apt update -yy
#	apt install -yy --install-recommends winehq-staging
#}
#if ! wineInstall; then
#	echo "failed to install winehq-staging"
#	exit 1
#fi

echo "adding flathub repo and installing various recommended flatpak packages"
sleep 1
flatpakInstall() {
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

	#echo "getting third party repo for shutter encoder flatpak"
	#apt -yy install git
	#git clone https://github.com/pobthebuilder/shutter-encoder-flatpak
	#cd "shutter-encoder-flatpak"
	#flatpak-builder --force-clean --repo=.repo .build-dir org.paulpacifico.ShutterEncoder.yaml
	#flatpak build-bundle .repo shutter-encoder.flatpak org.paulpacifico.ShutterEncoder
	#flatpak install shutter-encoder.flatpak

	echo "flatpak essentials ..3 ..2 ..1"; sleep 3
	flatpak install com.github.tchx84.Flatseal me.timschneeberger.jdsp4linux

	echo "gaming stuff ..3 ..2 ..1"; sleep 3
	flatpak install io.itch.itch com.heroicgameslauncher.hgl io.mrarm.mcpelauncher io.github.mandruis7.xbox-cloud-gaming-electron com.valvesoftware.Steam com.steamgriddb.steam-rom-manager net.rpcs3.RPCS3 org.citra_emu.citra net.pcsx2.PCSX2 org.DolphinEmu.dolphin-emu org.ppsspp.PPSSPP org.godotengine.Godot

	echo "production ..3 ..2 ..1"; sleep 3
	flatpak install org.ardour.Ardour com.obsproject.Studio org.kde.kdenlive org.gimp.GIMP org.blender.Blender org.tenacityaudio.Tenacity fr.handbrake.ghb

	echo "odds and ends (chunked) ..3 ..2 ..1"; sleep 3
	flatpak install com.feaneron.Boatswain
	flatpak install org.bleachbit.BleachBit io.missioncenter.MissionCenter
	flatpak install org.qbittorrent.qBittorrent org.atheme.audacious org.musicbrainz.Picard com.vscodium.codium io.github.shiftey.Desktop org.jellyfin.JellyfinServer
	flatpak install com.sindresorhus.Caprine com.discordapp.Discord
	flatpak install org.upscayl.Upscayl org.gnome.SimpleScan

}
if ! flatpakInstall; then
	echo "failed to add flathub repo and install various recommended flatpak packages"
	exit 1
fi