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

Write-Output -Message "Importing AppX module for function"
Import-Module -Name Appx -UseWindowsPowerShell

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

Write-Output "Disabling Xbox Overlay prompt to avoid issues with opening gaming apps on Windows"
cmd.exe /c 'REG ADD "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR" /v AppCaptureEnabled /t REG_DWORD /d 0 /f'

Write-Output "Disabling automatic driver downloads"
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DriverSearching\' -Name SearchOrderConfig -Value 3
Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Device Metadata\' -Name PreventDeviceMetadataFromNetwork -Value 1
$regKey3 = 'HKLM:\SOFTWARE\Microsoft\Windows\WindowsUpdate'
if (-not(Test-Path -Path $regKey3)) {
	New-Item -Path $regKey3
}
Set-ItemProperty -Path $regKey3 -Name ExcludeWUDriversInQualityUpdate -Value 1

# scoop {
	if ((Get-ExecutionPolicy -Scope CurrentUser) -notcontains "Unrestricted") {
	    Write-Output -Message "Execution Policy adjusted for Scoop"
	    Start-Process -FilePath "PowerShell" -ArgumentList "Set-ExecutionPolicy", "-Scope", "CurrentUser", "-ExecutionPolicy", "Unrestricted", "-Force" -Verb RunAs -Wait
	    Write-Output "Rerun this script please."
	    Start-Sleep -Seconds 5
	    Break
	}
	if (!(Get-Command -Name "scoop" -CommandType Application -ErrorAction SilentlyContinue | Out-Null)) {
	    Write-Output -Message "Getting Scoop"
		Invoke-RestMethod get.scoop.sh -OutFile 'scoop.ps1'
		.\scoop -ScoopDir "C:\Users\$env:username\Scoop"
		Write-Output "Installing Git with Scoop, 7Zip will be installed as a dependency too"
		scoop install main/git
	}
	Write-Output "Adding Scoop buckets"
	scoop bucket add extras
	scoop bucket add games
	scoop bucket add np https://github.com/ScoopInstaller/Nonportable
	scoop bucket add chf https://github.com/chrishazfun/bucket
	Write-Output "Installing what we need from Scoop"
	(
		"main/sudo",
		"main/zip",
		"extras/audacious",
		"extras/audacity",
		"extras/bleachbit",
		"extras/blender",
		"games/citra",
		"extras/cpu-z",
		"games/dolphin",
		"games/duckstation",
		"extras/dupeguru",
		"games/dxvk",
		"main/ffmpeg",
		"extras/googlechrome",
		"chf/gta-iv-downgrader",
		"extras/handbrake",
		"extras/homebank",
		"main/imagemagick",
		"extras/kdenlive",
		"extras/mpv",
		"main/neovim",
		"extras/nvcleanstall",
		"extras/obs-studio",
		"games/pcsx2",
		"extras/picard",
		"extras/powertoys",
		"games/ppsspp",
		"games/prismlauncher",
		"extras/qbittorrent",
		"extras/qutebrowser",
		"extras/rainmeter",
		"games/rpcs3",
		"extras/rufus",
		"extras/shutter-encoder",
		"extras/snappy-driver-installer-origin",
		"games/steam-rom-manager",
		"extras/upscayl",
		"extras/ventoy",
		"extras/vlc",
		"main/wget",
		"extras/winaero-tweaker",
		"games/xemu",
		"main/yt-dlp",
		"games/yuzu"
	) | ForEach-Object {
		scoop install $_
	}
	Write-Output "Seperately installing some packages as admin"
	(
		"np/virtualbox-np",
		"np/icaros-np",
		"np/equalizer-apo-np"
	) | ForEach-Object {
		sudo scoop install $_
	}
	Write-Output "Setting Git Credential Manager Core"
	git config --global credential.helper manager
	Write-Output "Importing context menus through regedits included with some Scoop packages"
	reg import "C:\Users\$env:username\Scoop\apps\7zip\current\install-context.reg"
	reg import "C:\Users\$env:username\Scoop\apps\git\current\install-context.reg"
# }

# winget {
	if (!(Test-Path "$HOME\AppData\Local\Microsoft\WindowsApps\winget.exe")) {
		Write-Output "Getting Winget"
		Start-BitsTransfer "https://aka.ms/getwinget" getwinget.msixbundle
		.\getwinget.msixbundle
		Get-Process AppInstaller | Wait-Process
	}
	Write-Output "Installing Winget packages"
	(
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
		"Oracle.JavaRuntimeEnvironment"
	) | ForEach-Object {
		winget install --id $_ -e -h --override --scope "machine"
	}
# }

Write-Output "Getting various redistributables"
Invoke-WebRequest -Uri "https://aka.ms/vs/17/release/vc_redist.x86.exe" -OutFile "vc_redist.x86.exe"
Start-Process vc_redist.x86.exe

Write-Output "Downloading and importing reg files to make Dolphin the default file explorer, also one to undo incase you have issues"
Invoke-WebRequest -Uri "https://chrishaz.fun/fun/dolphinexplore.reg" -OutFile "DolphinExplore.reg"
Invoke-WebRequest -Uri "https://chrishaz.fun/fun/dolphinexplore-revert.reg" -OutFile "DolphinExplore-Revert.reg"
reg import "C:\Users\$env:username\DolphinExplore.reg"
reg import "C:\Users\$env:username\Scoop\apps\prismlauncher\current\install-associations.reg"
#reg import "C:\Users\$env:username\DolphinExplore-Revert.reg"

Write-Output "Getting FiveM, the better GTA V multiplayer"
Invoke-WebRequest -Uri "https://runtime.fivem.net/client/FiveM.exe" -OutFile "FiveM.exe"
Start-Process FiveM.exe

Write-Output "Getting Xbox App"
Invoke-WebRequest -Uri "https://aka.ms/XboxInstaller" -OutFile "Xbox.exe"
Start-Process Xbox.exe
(
	"Microsoft.Xbox.TCUI_8wekyb3d8bbwe",
	"Microsoft.XboxGamingOverlay_8wekyb3d8bbwe"
) | ForEach-Object {
	winget install --id $_ -e -h --override --scope "machine"
}

Write-Output "Getting OpenIV"
Invoke-WebRequest -Uri "https://openiv.com/WebIV/guest.php?get=1" -OutFile "OpenIV.exe"
Start-Process OpenIV.exe

# kill edge {
	#Write-Output "Killing Edge"
	#Invoke-WebRequest -Uri "https://github.com/ShadowWhisperer/Remove-Edge-Chromium/blob/main/Remove-Edge.exe?raw=true" -OutFile "RemoveEdge.exe"
	#Start-Process RemoveEdge.exe
	#Invoke-WebRequest -Uri "https://github.com/mrhaydendp/RemoveEdge/raw/main/RemoveEdge.ps1" -OutFile "RemoveEdge.ps1"
	#sudo .\RemoveEdge.ps1
	#irm "https://github.com/mrhaydendp/RemoveEdge/raw/main/RemoveEdge.ps1" | iex
# }

Write-Output "Turning hibernation off"
sudo powercfg /hibernate off

Write-Output -Message "Finally we're gonna disable some optional features"
sudo dism /online /disable-feature /featurename:Internet-Explorer-Optional-amd64 /remove /norestart /warningaction
sudo dism /online /disable-feature /featurename:WindowsMediaPlayer /remove /norestart /warningaction

Write-Output "Preparing for Linux Subsystem, installing Debian"
sudo Enable-WindowsOptionalFeature -Online -FeatureName "Microsoft-Windows-Subsystem-Linux" -All -NoRestart
sudo Enable-WindowsOptionalFeature -Online -FeatureName "VirtualMachinePlatform" -All -NoRestart
#sudo dism /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
#sudo dism /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
Invoke-WebRequest -Uri "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi" -OutFile "wsl.msi"
Start-Process wsl.msi
wsl --set-default-version 2
wsl --install -d Debian # install debian

Write-Output "Done! You should probably reboot before doing anything"