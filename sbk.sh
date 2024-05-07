#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "must be run as root"
	exit 1
fi

echo "installing rpmfusion (nvidia, etc)"
sleep 1
rpm-ostree install \
https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y

# nvidia drivers
installNvidiaAction() {
	rpm-ostree install akmod-nvidia xorg-x11-drv-nvidia
	rpm-ostree kargs --append=rd.driver.blacklist=nouveau --append=modprobe.blacklist=nouveau --append=nvidia-drm.modeset=1
}
installNvidia() {
	if ! installNvidiaAction; then
		echo "failed to install nvidia drivers"
		exit 1
	fi
}
printf 'install nvidia drivers? (y/N) '
read ny
if [ "$ny" != "${ny#[Yy]}" ]; then
    installNvidia
fi

echo "adding flathub, distrobox/boxbuddy and preferred flatpaks"
sleep 1
installThings() {

	echo "generic curl install for distrobox"
	sleep 1
	curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh

	echo "adding direct flathub remote"
	sleep 1
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

	echo "boxbuddy: distrobox gui"
	sleep 1
	flatpak install flathub io.github.dvlv.boxbuddyrs

	echo "flatpak permissions and cleaner"
	sleep 1
	flatpak install flathub com.github.tchx84.Flatseal io.github.giantpinkrobots.flatsweep

	echo "installing other preferred flatpaks"
	sleep 1
	flatpak install flathub com.feaneron.Boatswain org.kde.kdenlive io.freetubeapp.FreeTube com.discordapp.Discord org.qbittorrent.qBittorrent io.github.celluloid_player.Celluloid org.audacityteam.Audacity org.gimp.GIMP io.github.shiftey.Desktop org.libreoffice.LibreOffice io.github.pwr_solaar.solaar org.nickvision.tagger org.upscayl.Upscayl com.spotify.Client io.github.peazip.PeaZip org.bleachbit.BleachBit fr.handbrake.ghb com.obsproject.Studio us.zoom.Zoom me.timschneeberger.jdsp4linux com.vscodium.codium com.rafaelmardojai.SharePreview \
	com.valvesoftware.Steam com.steamgriddb.steam-rom-manager com.mojang.Minecraft uk.co.powdertoy.tpt io.itch.itch net.rpcs3.RPCS3 org.DolphinEmu.dolphin-emu org.ppsspp.PPSSPP net.pcsx2.PCSX2
}
if ! installThings; then
	exit 1
fi