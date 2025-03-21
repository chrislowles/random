# `winget` (Preinstalled with W11)
## Packages
```powershell
(
	"Mozilla.Firefox",
	"rcmaehl.MSEdgeRedirect",
	"Xanashi.Icaros",
	"Klocman.BulkCrapUninstaller",
	"Microsoft.PowerToys",
	"TheDocumentFoundation.LibreOffice",
	"Upscayl.Upscayl",
	"Audacity.Audacity",
	"Git.Git",
	"KDE.Krita",
	"Logitech.LogiBolt",
	"YACReader.YACReader",
	"Oracle.VirtualBox",
	"SaeraSoft.CaesiumImageCompressor",
	"Microsoft.PowerShell",
	"Apple.iTunes",
	"MusicBrainz.Picard",
	"OBSProject.OBSStudio",
	"Valve.Steam",
	"RamenSoftware.Windhawk",
	"KDE.Kdenlive",
	"qBittorrent.qBittorrent",
	"GOG.Galaxy",
	"Jackett.Jackett",
	"SteamGridDB.RomManager",
	"PrestonN.FreeTube",
	"Discord.Discord",
	"GNU.Nano",
	"GitHub.GitHubDesktop",
	"PrismLauncher.PrismLauncher",
	"ThePowderToy.ThePowderToy",
	"dotPDN.PaintDotNet",
	"DupeGuru.DupeGuru",
	"ItchIo.Itch",
	"pbek.QOwnNotes",
	"Roblox.Roblox",
	"Ytmdesktop.Ytmdesktop",
	"Microsoft.VisualStudioCode",
	"mpv.net"
) | ForEach-Object {
	winget install $_
}
```

# `winutil`
Access Chris Titus' `winutil` with this command in PowerShell.
```powershell
irm "https://christitus.com/win" | iex
```
Download the config available at winutil.json here, import it, run 'Run Tweaks' in Tweaks and 'Install Features' in Config as its set and set the Windows Update channel to 'Security'.

# [Scoop](https://scoop.sh/)
## Buckets (Repositories)
```powershell
scoop bucket add extras
scoop bucket add versions
scoop bucket add games
scoop bucket add chrislowles_bucket https://github.com/chrislowles/bucket 
```
## Packages
```powershell
(
	"versions/ffmpeg-yt-dlp",
	"versions/yt-dlp-master",
	"extras/twitchdownloader",
	"extras/ventoy"
) | ForEach-Object {
	scoop install $_
}
```

# Just URLs
```powershell
(
	"https://aka.ms/XboxInstaller"
) | ForEach-Object {
	Invoke-WebRequest -UseBasicParsing -Uri $_ -OutFile "pkg.exe"
	Start-Process pkg.exe
}
```