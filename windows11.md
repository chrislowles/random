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
	"7zip.7zip",
	"GNU.Nano",
	"Git.Git",
	"Microsoft.VCRedist.2013.x64",
	"Microsoft.VCRedist.2010.x64",
	"Microsoft.VCRedist.2015+.x86",
	"Microsoft.VCRedist.2005.x86",
	"Microsoft.VCRedist.2015+.x64",
	"Microsoft.VCRedist.2013.x86",
	"Microsoft.VCRedist.2010.x86",
	"Microsoft.DotNet.DesktopRuntime.6",
	"ImageMagick.ImageMagick",
	"Python.Launcher",
	"Oracle.JavaRuntimeEnvironment",
	"TechPowerUp.NVCleanstall",
	"gerardog.gsudo",
	"Python.Python.3.10",
	"Upscayl.Upscayl",
	"PrestonN.FreeTube",
	"Audacious.MediaPlayer",
	"Audacity.Audacity",
	"BleachBit.BleachBit",
	"Discord.Discord",
	"DolphinEmulator.Dolphin",
	"GIMP.GIMP",
	"GitHub.GitHubDesktop",
	"HandBrake.HandBrake",
	"Logitech.LogiBolt",
	"MusicBrainz.Picard",
	"Mozilla.Firefox",
	"KDE.NeoChat",
	"OBSProject.OBSStudio",
	"PPSSPPTeam.PPSSPP",
	"Spotify.Spotify",
	"Valve.Steam",
	"SublimeHQ.SublimeText.4",
	"ThePowderToy.ThePowderToy",
	"Zoom.Zoom",
	"SteamGridDB.RomManager",
	"DupeGuru.DupeGuru",
	"ItchIo.Itch",
	"KDE.Kdenlive",
	"qBittorrent.qBittorrent",
	"yt-dlp.yt-dlp",
	"Cloudflare.Warp",
	#"ElectronicArts.EADesktop",
	#"Oracle.VirtualBox",
	"filips.FirefoxPWA",
	"TheDocumentFoundation.LibreOffice",
	"mpv.net",
	"Microsoft.PowerToys",
	"Cyotek.WebCopy",
	#"Modrinth.ModrinthApp",
	"Klocman.BulkCrapUninstaller"
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
	#"https://runtime.fivem.net/client/FiveM.exe"
	"https://sourceforge.net/projects/equalizerapo/files/1.3/EqualizerAPO64-1.3.exe/download"
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

# Disabling Xbox Overlay prompt to avoid issues with opening games (Optional)
```powershell
cmd.exe /c 'REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f'
```