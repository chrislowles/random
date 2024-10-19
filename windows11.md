## Remove Crud
```powershell
(
	"Microsoft.BingWeather*",
	"Microsoft.GetHelp*",
	"Microsoft.Getstarted*",
	"Microsoft.Messaging*",
	"Microsoft.Microsoft3DViewer*",
	"Microsoft.MicrosoftOfficeHub*",
	"Microsoft.MicrosoftSolitaireCollection*",
	"Microsoft.MSPaint*",
	"Microsoft.Office.OneNote*",
	"Microsoft.OneConnect*",
	"Microsoft.People*",
	"Microsoft.Print3D*",
	"Microsoft.SkypeApp*",
	"microsoft.windowscommunicationsapps*",
	"Microsoft.WindowsMaps*",
	"Microsoft.WindowsSoundRecorder*",
	"Microsoft.Xbox*",
	"Microsoft.Zune*",
	"Microsoft.MixedReality.Portal",
	"Microsoft.People",
	"Microsoft.SkypeApp",
	"Microsoft.WindowsFeedbackHub",
	"Microsoft.WindowsMaps",
	"Microsoft.WindowsSoundRecorder",
	"Microsoft.Windows.Photos*",
	"Disney*",
	"SpotifyAB*",
	"Microsoft.Office.Sway",
	"Microsoft.*3DBuilder*",
	"Microsoft.*3DViewer*",
	"Microsoft.ScreenSketch*",
	"Microsoft.OneDrive",
	"microsoft.windowscommunicationapps*",
	"king.com.CandyCrushSodaSaga",
	"flaregamesGmbH.RoyalRevolt2",
	"*Netflix",
	"Microsoft.MinecraftUWP",
	"*MarchofEmpires",
	"*EclipseManager*",
	"*ActiproSoftwareLLC*",
	"*AdobeSystemsIncorporated.AdobePhotoshopExpress*",
	"*Duolingo-LearnLanguagesforFree*",
	"*PandoraMediaInc*",
	"*CandyCrush*",
	"*BubbleWitch3Saga*",
	"*Wunderlist*",
	"*Flipboard*",
	"*Twitter*",
	"*Facebook*",
	"*Royal Revolt*",
	"*Sway*",
	"*Speed Test*",
	"*Dolby*",
	"*Viber*",
	"*ACGMediaPlayer*",
	"*Netflix*",
	"*OneCalendar*",
	"*LinkedInforWindows*",
	"*HiddenCityMysteryofShadows*",
	"*Hulu*",
	"*HiddenCity*",
	"*AdobePhotoshopExpress*",
	"*HotspotShieldFreeVPN*"
) | ForEach-Object {
	Get-AppxProvisionedPackage –online | where-object {$_.packagename –like "*$_*"} | Remove-AppxProvisionedPackage –online
}
```

## Winget Pkgs (of which you can get [here](https://aka.ms/getwinget))
```powershell
(
	"Upscayl.Upscayl",
	"PrestonN.FreeTube",
	"7zip.7zip",
	"Audacity.Audacity",
	"Git.Git",
	"KDE.Krita",
	"Logitech.LogiBolt",
	"Mozilla.Firefox",
	"Libretro.RetroArch",
	"Streamlink.Streamlink",
	"Nikse.SubtitleEdit",
	"Apple.iTunes",
	"WireGuard.WireGuard",
	"PrivateInternetAccess.PrivateInternetAccess", 
	"Zoom.Zoom",
	"gerardog.gsudo",
	"filips.FirefoxPWA",
	"CloneHeroTeam.CloneHero",
	"Oracle.VirtualBox",
	"TheDocumentFoundation.LibreOffice",
	"Cyotek.WebCopy",
	"Klocman.BulkCrapUninstaller",
	"HandBrake.HandBrake",
	"MusicBrainz.Picard",
	"OBSProject.OBSStudio",
	"Valve.Steam",
	"RamenSoftware.Windhawk",
	"qBittorrent.qBittorrent",
	"Jackett.Jackett",
	"OpenWhisperSystems.Signal",
	"Discord.Discord",
	"GNU.Nano",
	"GitHub.GitHubDesktop",
	"Gyan.FFmpeg.Shared",
	"rcmaehl.MSEdgeRedirect",
	"Spotify.Spotify",
	"ThePowderToy.ThePowderToy",
	"SteamGridDB.RomManager",
	"DupeGuru.DupeGuru",
	"KDE.Kdenlive",
	"yt-dlp.yt-dlp",
	"VSCodium.VSCodium",
	"mpv.net",
	"Microsoft.PowerToys",
	"File-New-Project.EarTrumpet"
) | ForEach-Object {
	winget install $_
}
```

## Scoop Buckets
```powershell
scoop bucket add anderlli0053_DEV-tools https://github.com/anderlli0053/DEV-tools
scoop bucket add extras
scoop bucket add versions
scoop bucket add games
```

## Scoop Pkgs (of which you can get [here](https://scoop.sh/))
```powershell
(
	"anderlli0053_DEV-tools/a7800",
	"games/dolphin",
	"games/duckstation",
	"games/pcsx2-dev",
	"games/ppsspp",
	"games/redream",
	"games/rpcs3",
	"extras/ventoy",
	"main/wget"
) | ForEach-Object {
	scoop install $_
}
```

## Just URLs
```powershell
(
	"https://aka.ms/vs/17/release/vc_redist.x86.exe",
	"https://aka.ms/XboxInstaller"
) | ForEach-Object {
	Invoke-WebRequest -UseBasicParsing -Uri $_ -OutFile "pkg.exe"
	Start-Process pkg.exe
}
```

## Removing OneDrive (thanks allenellis)
```powershell
Invoke-WebRequest -UseBasicParsing -Uri "https://gist.githubusercontent.com/AllenEllis/884681dd08abb2470f55a74bbc12f008/raw/0c494563220283a607543af9d55a5309983fb18d/Remove%2520OneDrive%2520(PowerShell).ps1" | Invoke-Expression
```

## Some sudo cmds (restart Powershell)
```powershell
sudo powercfg /hibernate off
sudo dism /online /disable-feature /featurename:Internet-Explorer-Optional-amd64 /remove /norestart /warningaction
sudo dism /online /disable-feature /featurename:WindowsMediaPlayer /remove /norestart /warningaction
```

# Disabling Xbox Overlay prompt to avoid issues with opening games (Optional)
```powershell
cmd.exe /c 'REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f'
```