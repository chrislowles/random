# checking for updates
sudo vso update-check
sudo vso trigger-update --now

# initializing apx
sudo apx init

# stuff to abroot
dothething () {
    # python/pip, timeshift for backups
    apt install python3 timeshift
    # flatpak and gnome intergration if we haven't already
    apt install flatpak gnome-software-plugin-flatpak
    # flathub repo for flatpak
    flatpak remote-add --if-not-exists --user flathub https://flathub.org/repo/flathub.flatpakrepo
    # primary
    flatpak install org.mozilla.firefox -y --noninteractive org.videolan.VLC com.obsproject.Studio org.gimp.GIMP org.ardour.Ardour org.blender.Blender org.audacityteam.Audacity org.bleachbit.BleachBit io.missioncenter.MissionCenter org.gnome.meld fr.handbrake.ghb fr.free.Homebank io.github.nate_xyz.Conjure org.kde.kdenlive in.cinny.Cinny org.qbittorrent.qBittorrent org.freecadweb.FreeCAD org.upscayl.Upscayl org.nickvision.tubeconverter com.vscodium.codium us.zoom.Zoom com.github.tchx84.Flatseal me.timschneeberger.jdsp4linux org.musicbrainz.Picard fr.free.Homebank com.feaneron.Boatswain org.gnome.gitlab.YaLTeR.Identity org.gnome.gitlab.YaLTeR.VideoTrimmer org.pipewire.Helvum app.ytmdesktop.ytmdesktop org.atheme.audacious org.citra_emu.citra org.yuzu_emu.yuzu org.DolphinEmu.dolphin-emu org.duckstation.DuckStation net.pcsx2.PCSX2 org.ppsspp.PPSSPP net.rpcs3.RPCS3 app.xemu.xemu io.itch.itch org.prismlauncher.PrismLauncher com.heroicgameslauncher.hgl com.valvesoftware.Steam com.steamgriddb.steam-rom-manager io.github.Foldex.AdwSteamGtk org.gnome.DejaDup org.diasurgical.DevilutionX fr.romainvigier.MetadataCleaner de.haeckerfelix.Shortwave com.adobe.Flash-Player-Projector
}

# doing the thing (getting the apps)
sudo abroot exec dothething