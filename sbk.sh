#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	echo "must be run as root"
	exit 1
fi

# dnf config
echo "updating dnf config"
sleep 2
echo -e "deltarpm=True
fastestmirror=True
max_parallel_downloads=10
defaultyes=True" | sudo tee -a /etc/dnf/dnf.conf

echo "upgrading system"
sleep 2
rpm-ostree upgrade

echo "install rpmfusion for nvidia drivers, and other stuff"
sleep 2
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
echo "install nvidia drivers?"
select ny in "nah" "yeah"; do
    case $ny in
        nah ) echo "ok no nvidia drivers";;
        yeah ) installNvidia; break;;
    esac
done

echo "adding flathub and preferred flatpaks"
sleep 1
installThings() {
	# add regular flathub
	sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
	# install the things
	sudo flatpak install flathub io.github.dvlv.boxbuddyrs
	sudo flatpak install flathub com.feaneron.Boatswain com.github.tchx84.Flatseal io.github.giantpinkrobots.flatsweep org.kde.kdenlive io.freetubeapp.FreeTube com.discordapp.Discord org.qbittorrent.qBittorrent io.mpv.Mpv org.atheme.audacious org.audacityteam.Audacity com.github.qarmin.czkawka org.gimp.GIMP io.github.shiftey.Desktop org.libreoffice.LibreOffice io.github.pwr_solaar.solaar org.nickvision.tagger org.upscayl.Upscayl com.spotify.Client io.github.peazip.PeaZip org.bleachbit.BleachBit fr.handbrake.ghb com.obsproject.Studio us.zoom.Zoom me.timschneeberger.jdsp4linux com.visualstudio.code /
	com.valvesoftware.Steam com.steamgriddb.steam-rom-manager com.mojang.Minecraft uk.co.powdertoy.tpt io.itch.itch net.rpcs3.RPCS3 org.DolphinEmu.dolphin-emu org.ppsspp.PPSSPP net.pcsx2.PCSX2
}
if ! installThings; then
	exit 1
fi