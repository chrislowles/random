# Windows 11
I have a copy of W11 ran through the microwin service available on Chris Titus' `winutil` program to make it as smooth from the get go.

# [Win11Debloat](https://github.com/Raphire/Win11Debloat)
Just because we ran it through microwin doesn't mean we can't make it better, run the script as shown below then reboot.
```powershell
& ([scriptblock]::Create((irm "https://debloat.raphi.re/"))) -RemoveApps -RemoveCommApps -RemoveW11Outlook -RemoveDevApps -RemoveGamingApps -DisableDVR -ClearStartAllUsers -DisableTelemetry -DisableSuggestions -DisableLockscreenTips -DisableBing -DisableCopilot -DisableRecall -RevertContextMenu -DisableMouseAcceleration -DisableStickyKeys -ShowHiddenFolders -ShowKnownFileExt -TaskbarAlignLeft -HideSearchTb -HideTaskview -HideChat -DisableWidgets -EnableEndTask -DisableStartRecommended -HideHome -ExplorerToThisPC
```

# `winget` (Preinstalled with W11)
## Packages
These ones in particular I'd like to just have installed regularly.
```powershell
(
	"Mozilla.Firefox",
	"rcmaehl.MSEdgeRedirect",
	"TechPowerUp.NVCleanstall",
	"Klocman.BulkCrapUninstaller",
	"qBittorrent.qBittorrent",
	"Jackett.Jackett",
	"Ytmdesktop.Ytmdesktop",
	"ItchIo.Itch",
	"RamenSoftware.Windhawk",
	"mpv.net",
	"Microsoft.PowerToys",
	"ThePowderToy.ThePowderToy",
	"7zip.7zip",
	"Git.Git",
	"Xanashi.Icaros",
	"Logitech.GHUB",
	"Oracle.VirtualBox",
	"Valve.Steam",
	"SteamGridDB.RomManager",
	"OBSProject.OBSStudio",
	"Microsoft.VisualStudioCode",
	"Spotify.Spotify",
	"Discord.Discord",
	"DupeGuru.DupeGuru",
	"Audacity.Audacity",
	"Lymphatus.Caesium",
	"PrestonN.FreeTube",
	"GitHub.GitHubDesktop",
	"KDE.Kdenlive",
	"KDE.Krita",
	"Upscayl.Upscayl",
	"YACReader.YACReader",
	"TheDocumentFoundation.LibreOffice"
) | ForEach-Object {
	winget install $_
}
```

# [Scoop](https://scoop.sh/)
## Buckets (Repositories)
```powershell
scoop bucket add extras
scoop bucket add versions
scoop bucket add games
scoop bucket add chrislowles_bucket https://github.com/chrislowles/bucket
scoop bucket add versions
scoop bucket add games
scoop bucket add anderlli0053_DEV-tools https://github.com/anderlli0053/DEV-tools
scoop bucket add detain_scoop-emulators https://github.com/detain/scoop-emulators
scoop bucket add hoilc_scoop-lemon https://github.com/hoilc/scoop-lemon
```
## Packages
Doesn't have auto update functionality so I just leave the updating to checking in with it in the terminal.
```powershell
(
	"main/python",
	"main/pipx",
	"main/ffmpeg",
	"versions/yt-dlp-master",
	"extras/ventoy",
	"extras/twitchdownloader",
	"games/luanti"
) | ForEach-Object {
	scoop install $_
}
```