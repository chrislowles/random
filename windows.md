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
	Get-AppxPackage $_ | Remove-AppxPackage
}
```

## Winget Pkgs (of which you can get [here](https://aka.ms/getwinget))
```powershell
(
	"gerardog.gsudo",
	"yt-dlp.yt-dlp",
	"Xanashi.Icaros",
	"JernejSimoncic.Wget",
	"7zip.7zip",
	"Oracle.VirtualBox",
	"Python.Python.3.8",
	"Microsoft.WindowsTerminal",
	"SublimeHQ.SublimeText.4",
	"KDE.Dolphin",
	"Mozilla.Firefox",
	"Ytmdesktop.Ytmdesktop",
	"Valve.Steam",
	"GOG.Galaxy",
	"ItchIo.Itch",
	"EpicGames.EpicGamesLauncher",
	"NexusMods.Vortex",
	"Logitech.LogiBolt",
	"Zoom.Zoom",
	"PrivateInternetAccess.PrivateInternetAccess",
	"Oracle.JavaRuntimeEnvironment",
	"YuzuEmu.Yuzu.Mainline",
	"xemu-project.xemu",
	"VideoLAN.VLC",
	"Upscayl.Upscayl",
	"Discord.Discord",
	"Audacious.MediaPlayer",
	"Audacity.Audacity",
	"BleachBit.BleachBit",
	"BlenderFoundation.Blender",
	"TechPowerUp.NVCleanstall",
	"KDE.Kdenlive",
	"DolphinEmulator.Dolphin",
	"stenzek.DuckStation",
	"DupeGuru.DupeGuru",
	"Gyan.FFmpeg.Shared",
	"HandBrake.HandBrake",
	"HomeBank.HomeBank",
	"ImageMagick.ImageMagick",
	"OBSProject.OBSStudio",
	# "games/pcsx2",
	# "games/rpcs3",
	"MusicBrainz.Picard",
	"Microsoft.PowerToys",
	"PPSSPPTeam.PPSSPP",
	"PrismLauncher.PrismLauncher",
	"qBittorrent.qBittorrent",
	"Rufus.Rufus",
	"SteamGridDB.RomManager"
) | ForEach-Object {
	winget install $_
}
```

## Just URLs
```powershell
(
	"https://aka.ms/vs/17/release/vc_redist.x86.exe",
	"https://aka.ms/XboxInstaller",
	"https://openiv.com/WebIV/guest.php?get=1"
	# "https://runtime.fivem.net/client/FiveM.exe"
	# "https://sourceforge.net/projects/equalizerapo/files/1.3/EqualizerAPO64-1.3.exe/download"
) | ForEach-Object {
	Invoke-WebRequest -UseBasicParsing -Uri $_ -OutFile "pkg.exe"
	Start-Process pkg.exe
}
```

## Removing OneDrive (thanks allenellis)
```powershell
Invoke-WebRequest -UseBasicParsing -Uri "https://gist.githubusercontent.com/AllenEllis/884681dd08abb2470f55a74bbc12f008/raw/0c494563220283a607543af9d55a5309983fb18d/Remove%2520OneDrive%2520(PowerShell).ps1" | Invoke-Expression
```

## Turning hibernation off
```powershell
sudo powercfg /hibernate off
```

## Disabling some optional features (since sudo should be here now)
```powershell
sudo dism /online /disable-feature /featurename:Internet-Explorer-Optional-amd64 /remove /norestart /warningaction
sudo dism /online /disable-feature /featurename:WindowsMediaPlayer /remove /norestart /warningaction
```

# Disabling Xbox Overlay prompt to avoid issues with opening games
```powershell
cmd.exe /c 'REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f'
```