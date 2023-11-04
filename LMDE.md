## LMDE.md
Since this is the script for my daily OS I thought I'd write more about it, it downloads my essential apps and removes some default ones I don't care about.

Make sure the system is completely updated, complete all the tasks you're given in the first Welcome Screen **(Snapshots, Codecs, Update Manager Setup [Sources on Fastest Mirror, Source Code Repos] followed by actual use of Update Manager to update the whole system)**, then use the script after a reboot.

```bash
# if you don't have git installed (can't clone repo)
bash <(curl -s https://github.com/chrishazfun/random/raw/master/script-name.sh)
```