## LMDE.md
Since this is the script for my daily OS I thought I'd be slightly more in depth about it, it downloads my essential apps and removes some default ones I don't care about.

Make sure the system is completely updated, complete all the tasks you're given in the first Welcome Screen **(Snapshots, Codecs, Update Manager Setup [Sources on Fastest Mirror, Source Code Repos] followed by actual use of Update Manager to update the whole system)**, then use the script after a reboot.

```bash
# all required
sudo apt install git
git clone https://github.com/chrishazfun/random
sudo bash random/lmde.sh
```