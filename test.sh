#!/bin/bash

echo "nvidia drivers time... yayyyy [test]"
installNvidiaAction() {
	sudo rpm-ostree install akmod-nvidia xorg-x11-drv-nvidia
	sudo rpm-ostree kargs --append=rd.driver.blacklist=nouveau --append=modprobe.blacklist=nouveau --append=nvidia-drm.modeset=1
}
installNvidia() {
	if ! installNvidiaAction; then
		echo "failed to install nvidia drivers"
		exit 1
	fi
}
while true; do
    read -p "$* [y/n]: " yn
    case $yn in
        #[Yy]*) installNvidia();  
        [Yy]*) echo "yes";  
        [Nn]*) echo "no";
		*) echo "no response so no drivers";
    esac
done