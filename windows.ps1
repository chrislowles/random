<#

	chrishazfun's big ol powershell script
	by Chris Lowles (@chrishazfun)
	GitHub: https://github.com/chrishazfun

	requirements:
	    powershell in admin mode,
	    latest windows updates
	execute:
        iwr -useb https://github.com/chrishazfun/random/raw/main/main.ps1 | iex

		sudo iwr -useb https://github.com/mrhaydendp/RemoveEdge/raw/main/RemoveEdge.ps1 | iex

	notable features
	* one-liners to fix some things i don't like about windows
	* uses winget and scoop as a means for getting most packages
	* custom function for getting everything else
	* that is all (not really)

	not on winget or scoop:
	gmic for gimp exe

	find some filetypes and rename them to a more common filetype when you're in a folder:
	dir *.jfif | rename-item -newname { $_.name -replace ".jfif",".jpg" }
	dir *.jpeg | rename-item -newname { $_.name -replace ".jpeg",".jpg" }
	dir *.webm | rename-item -newname { $_.name -replace ".webm",".mp4" }
	dir *.mkv | rename-item -newname { $_.name -replace ".mkv",".mp4" }
	dir *.mov | ffmpeg -i my-video.mov -vcodec h264 -acodec mp2 my-video.mp4

	random commands:
	delete icon cache: Remove-Item -Path "C:\Users\$ENV:USERNAME\AppData\Local"
	list all packages: Get-AppxPackage -AllUsers | Select Name, PackageFullName
	remove select package: Get-AppxPackage Microsoft.MicrosoftEdge | Remove-AppxPackage
	remove empty dirs (nuclear): iwr -useb https://gist.github.com/sba923/571e7b02bddab9c587ee97110b898629/raw/2e074f09a0815c5afdbe7de15241c6f16b38e448/Remove-EmptyDirectories.ps1 | iex
	alternative to jfif to jpg: dir *.jfif | rename-item -newname { [io.path]::ChangeExtension($_.name, "jpg") }
	idk what this does: Get-AppxPackage | Get-AppxPackageManifest | %{$_.Package.Applications.Application.VisualElements.DisplayName}

	update winget, update winget pkgs marked for upgrading
	update scoop, update scoop pkgs marked for upgrading
	clear scoop cache:
	winget upgrade --all --include-unknown
	scoop update;scoop update "*";scoop cache rm *

#>

# Write-Output -Message "Importing AppX module for function"
# Import-Module -Name Appx -UseWindowsPowerShell

Write-Output -Message "Removing crud..."
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

Write-Output "Removing OneDrive"
Invoke-WebRequest -Uri "https://gist.githubusercontent.com/AllenEllis/884681dd08abb2470f55a74bbc12f008/raw/0c494563220283a607543af9d55a5309983fb18d/Remove%2520OneDrive%2520(PowerShell).ps1" -OutFile "remove-onedrive.ps1"
Start-Process remove-onedrive.ps1

# winget {
	if (!(Test-Path "$HOME\AppData\Local\Microsoft\WindowsApps\winget.exe")) {
		Write-Output "Getting Winget"
		Start-BitsTransfer "https://aka.ms/getwinget" getwinget.msixbundle
		.\getwinget.msixbundle
		Get-Process AppInstaller | Wait-Process
	}
	Write-Output "Installing Winget packages"
	(
		"Microsoft.XboxGamingOverlay_8wekyb3d8bbwe",
		"Microsoft.Xbox.TCUI_8wekyb3d8bbwe",
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
		winget install -e --id $_ --override --scope "machine"
	}
# }

# urls {
	Write-Output "Installing packages from URLs"
	(
		"https://aka.ms/vs/17/release/vc_redist.x86.exe",
		"https://aka.ms/XboxInstaller",
		"https://openiv.com/WebIV/guest.php?get=1"
		# "https://runtime.fivem.net/client/FiveM.exe"
		# https://sourceforge.net/projects/equalizerapo/files/1.3/EqualizerAPO64-1.3.exe/download
	) | ForEach-Object {
		Invoke-WebRequest -UseBasicParsing -Uri $_ -OutFile "pkg.exe"
		Start-Process pkg.exe
	}
# }

# Write-Output "Downloading and importing reg files to make Dolphin the default file explorer, also one to undo incase you have issues"
# Invoke-WebRequest -Uri "https://chrishaz.fun/fun/dolphinexplore.reg" -OutFile "DolphinExplore.reg"
# Invoke-WebRequest -Uri "https://chrishaz.fun/fun/dolphinexplore-revert.reg" -OutFile "DolphinExplore-Revert.reg"
# reg import "C:\Users\$env:username\DolphinExplore.reg"
# reg import "C:\Users\$env:username\Scoop\apps\prismlauncher\current\install-associations.reg"
# reg import "C:\Users\$env:username\DolphinExplore-Revert.reg"

Write-Output "Turning hibernation off"
sudo powercfg /hibernate off

Write-Output -Message "Finally we're gonna disable some optional features"
sudo dism /online /disable-feature /featurename:Internet-Explorer-Optional-amd64 /remove /norestart /warningaction
sudo dism /online /disable-feature /featurename:WindowsMediaPlayer /remove /norestart /warningaction

Write-Output "Disabling Xbox Overlay prompt to avoid issues with opening gaming apps on Windows"
cmd.exe /c 'REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f'

Write-Output "Done! You should probably reboot before doing anything"