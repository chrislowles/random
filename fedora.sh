#!/bin/bash

# wayland/nvidia only

if [[ $EUID -ne 0 ]]; then
	echo "must be run as root"
	exit 1
fi

if ! loginctl show-session $(loginctl show-user $(whoami) -p Display --value) -p Type --value == "wayland"; then
	echo "not wayland"
	exit 1
fi

echo "optimizing dnf settings"
sleep 1
sudo bash -c 'cat > /etc/dnf/dnf.conf' << EOF
[main]
gpgcheck=1
installonly_limit=10
clean_requirements_on_remove=True
best=False
skip_if_unavailable=True
fastestmirror=True
max_parallel_downloads=20
defaultyes=True
keepcache=True
EOF

echo "cleaning dnf cache"
sleep 1
if ! dnf clean all; then
	echo "failed to clean dnf cache"
	exit 1
fi

echo "updating dnf"
sleep 1
if ! dnf update; then
	echo "failed to update dnf"
	exit 1
fi

echo "updating relevant appstream data packages"
sleep 1
if ! dnf groupupdate core; then
	echo "failed to update relevant appstream data packages"
	exit 1
fi

echo "adding rpm fusion free/non-free"
sleep 1
if ! dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm; then
	echo "failed to add rpm fusion free/non-free"
	exit 1
fi

echo "installing media codecs"
sleep 1
if ! dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin && dnf groupupdate sound-and-video; then
	echo "failed to install media codecs"
	exit 1
fi

#echo "Nvidia shit"
#dnf install xorg-x11-server-Xwayland libxcb egl-wayland
#sed -i "GRUB_CMDLINE_LINUX=\"rhgb quiet rd.driver.blacklist=nouveau nvidia-drm.modeset=1\""
## OR with LVM ##
#GRUB_CMDLINE_LINUX="rd.lvm.lv=fedora/swap rd.lvm.lv=fedora/root rhgb quiet rd.driver.blacklist=nouveau nvidia-drm.modeset=1"

echo "installing dnf-plugins-core"
sleep 1
if ! dnf install dnf-plugins-core; then
	echo "failed to install dnf-plugins-core"
	exit 1
fi

echo "adding flathub repo and installing packages relevant and available"
sleep 1
if ! flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo && flatpak install -y org.upscayl.Upscayl com.obsproject.Studio org.qbittorrent.qBittorrent org.kde.kdenlive org.gimp.GIMP org.videolan.VLC org.atheme.audacious app.ytmdesktop.ytmdesktop org.blender.Blender org.audacityteam.Audacity com.github.wwmm.easyeffects org.gabmus.gfeeds fr.handbrake.ghb org.nickvision.money io.github.shiftey.Desktop com.discordapp.Discord org.musicbrainz.Picard && flatpak install -y io.itch.itch com.heroicgameslauncher.hgl io.mrarm.mcpelauncher com.valvesoftware.Steam com.steamgriddb.steam-rom-manager net.rpcs3.RPCS3 org.citra_emu.citra net.pcsx2.PCSX2 org.DolphinEmu.dolphin-emu org.ppsspp.PPSSPP; then
	echo "failed to add flathub repo and install relevant packages available"
	exit 1
fi

echo "setting desktop to dark mode" && sleep 1
if ! gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'; then
	echo "failed to set desktop to dark mode"
	exit 1
fi

echo "hiding the grub menu" && sleep 1
if ! sed -i 's/^GRUB_TIMEOUT=5/GRUB_TIMEOUT=0/g' /etc/default/grub && grub2-mkconfig -o /boot/grub2/grub.cfg; then
	echo "failed to hide the grub menu"
	exit 1
fi

echo "Adjusting stop jobs from 1m30s (90s) to 10s and reloading systemd daemon"
if ! sed -i 's/^#DefaultTimeoutStopSec=90s/DefaultTimeoutStopSec=10s/g' /etc/systemd/system.conf && systemctl daemon-reload; then
	echo "failed to either adjust stop jobs from 1m30s (90s) to 10s or failed to reload systemd daemon"
	exit 1
fi