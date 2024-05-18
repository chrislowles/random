#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "must be run as root"
	exit 1
fi

#echo "before anything... updating and upgrading"
#sleep 1
#dnf update
#
#echo "installing rpmfusion if you don't already have it enabled in gnome software, it's just good to have this anyway"
#sleep 1
#rpm-ostree install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
#https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm -y
#
#installNvidia() {
#	if ! dnf install akmod-nvidia -y; then
#		echo "failed to install nvidia drivers"
#		exit 1
#	fi
#}
#printf 'install nvidia drivers? (y/N) '
#read ny
#if [ "$ny" != "${ny#[Yy]}" ]; then
#    installNvidia
#fi

echo "adding flathub, distrobox/boxbuddy and preferred flatpaks"
sleep 1
installThings() {

	echo "adding direct flathub remote"
	sleep 1
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

	echo "generic curl install for distrobox & distrobox gui in boxbuddyrs"
	sleep 1
	curl -s https://raw.githubusercontent.com/89luca89/distrobox/main/install | sudo sh
	sleep 1
	flatpak install flathub io.github.dvlv.boxbuddyrs

	echo "flatpak permissions and cleaner & other preferred flatpaks"
	sleep 1
	flatpak install flathub com.github.tchx84.Flatseal io.github.giantpinkrobots.flatsweep com.feaneron.Boatswain org.kde.kdenlive io.freetubeapp.FreeTube com.discordapp.Discord org.qbittorrent.qBittorrent io.github.celluloid_player.Celluloid org.audacityteam.Audacity org.gimp.GIMP io.github.shiftey.Desktop org.libreoffice.LibreOffice io.github.pwr_solaar.solaar org.nickvision.tagger org.upscayl.Upscayl com.spotify.Client io.github.peazip.PeaZip org.bleachbit.BleachBit fr.handbrake.ghb com.obsproject.Studio us.zoom.Zoom me.timschneeberger.jdsp4linux com.vscodium.codium com.rafaelmardojai.SharePreview \
	com.valvesoftware.Steam com.steamgriddb.steam-rom-manager com.mojang.Minecraft uk.co.powdertoy.tpt io.itch.itch net.rpcs3.RPCS3 org.DolphinEmu.dolphin-emu org.ppsspp.PPSSPP net.pcsx2.PCSX2
}
if ! installThings; then
	exit 1
fi