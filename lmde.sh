#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "must be run as root"
	exit 1
fi

echo "installing some obvious native pkgs"
sleep 1
nativeInstall() {
	apt install git
}
if ! nativeInstall; then
	echo "failed to install some native pkgs"
	exit 1
fi

echo "removing certain default apps"
sleep 1
removeDefaults() {
	apt remove hexchat thunderbird hypnotix rhythmbox
}
if ! removeDefaults; then
	echo "failed to remove certain default apps"
	exit 1
fi

#echo "installing recommended qemu virt manager combo"
#sleep 1
#qemukvmInstall() {
#	apt install virt-manager edtables dnsmasq qemu-kvm qemu-system-x86 seabios ovmf libvirt-daemon-system libvirt-daemon-system-systemd libvirt-daemon-driver-qemu libvirt-daemon-config-network libvirt-daemon libvirt-clients
#	systemctl enable libvirtd
#	systemctl start libvirtd
#	usermod -a -G operator $USER
#	usermod -a -G kvm $USER
#	usermod -a -G libvirtd $USER
#}
#if ! qemukvmInstall; then
#	echo "failed to install recommended qemu virt manager combo"
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

	echo "essentials"; sleep 3
	flatpak install com.github.tchx84.Flatseal me.timschneeberger.jdsp4linux

	echo "ms stuff"; sleep 3
	flatpak install com.microsoft.Edge com.visualstudio.code com.github.IsmaelMartinez.teams_for_linux

	echo "gaming"; sleep 3
	flatpak install uk.co.powdertoy.tpt io.itch.itch com.heroicgameslauncher.hgl
	echo "steam specifically"; sleep 2
	flatpak install com.valvesoftware.Steam com.steamgriddb.steam-rom-manager
	echo "emulators"; sleep 2
	flatpak install net.rpcs3.RPCS3 org.citra_emu.citra net.pcsx2.PCSX2 org.DolphinEmu.dolphin-emu org.ppsspp.PPSSPP

	echo "production"; sleep 3
	flatpak install com.obsproject.Studio org.gimp.GIMP org.tenacityaudio.Tenacity org.godotengine.Godot org.kde.kdenlive
	flatpak install org.ardour.Ardour org.blender.Blender fr.handbrake.ghb

	echo "odds and ends"; sleep 3
	flatpak install org.bleachbit.BleachBit org.musicbrainz.Picard org.jellyfin.JellyfinServer com.feaneron.Boatswain org.atheme.audacious org.qbittorrent.qBittorrent com.sindresorhus.Caprine com.discordapp.Discord io.github.shiftey.Desktop org.upscayl.Upscayl

}
if ! flatpakInstall; then
	echo "failed to add flathub repo and install various recommended flatpak packages"
	exit 1
fi