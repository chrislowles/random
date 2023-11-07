#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "Must be run as root."
	exit 1
fi

#echo "Installing some obvious native packages."
#sleep 1
#nativeInstall() {}
#if ! nativeInstall; then
#	echo "Failed to install some native packages."
#	exit 1
#fi

echo "Removing certain default apps."
sleep 1
removeDefaults() {
	apt remove hexchat thunderbird hypnotix rhythmbox drawing
}
if ! removeDefaults; then
	echo "Failed to remove certain default apps."
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

# io.itch.itch com.microsoft.Edge

echo "Installing preferred flatpaks."
sleep 1
flatpakInstall() {
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	flatpak install com.github.tchx84.Flatseal me.timschneeberger.jdsp4linux com.vscodium.codium uk.co.powdertoy.tpt com.heroicgameslauncher.hgl com.valvesoftware.Steam com.steamgriddb.steam-rom-manager net.rpcs3.RPCS3 org.citra_emu.citra net.pcsx2.PCSX2 org.DolphinEmu.dolphin-emu org.ppsspp.PPSSPP com.obsproject.Studio org.gimp.GIMP org.tenacityaudio.Tenacity org.godotengine.Godot org.kde.kdenlive org.ardour.Ardour org.blender.Blender fr.handbrake.ghb org.bleachbit.BleachBit org.musicbrainz.Picard org.jellyfin.JellyfinServer com.feaneron.Boatswain org.atheme.audacious org.qbittorrent.qBittorrent com.sindresorhus.Caprine com.discordapp.Discord io.github.shiftey.Desktop org.upscayl.Upscayl
}
if ! flatpakInstall; then
	echo "Failed to install preferred flatpaks."
	exit 1
fi