# random
Scripts for certain operating systems I use, quick JS scripts.

## Linux Scripts
```bash
# clone repo
git clone https://github.com/chrishazfun/random
# linux mint debian edition post-install script
bash linux/lmde.sh
# fedora workstation post-install script
bash linux/fedora.sh
```

## Windows Script (PowerShell 7.x, Absolutely triple make sure Windows is updated)
```powershell
Invoke-WebRequest -UseBasicParsing -Uri "https://raw.githubusercontent.com/chrishazfun/random/master/windows.ps1" | Invoke-Expression
```