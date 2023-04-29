#!/bin/sh

rsync -a /home/hisham/.config /home/hisham/.screenshots /home/hisham/Documents /home/hisham/.vim /home/hisham/.xinitrc /home/hisham/.Xresources /home/hisham/.zprofile /home/hisham/br10.xml /mnt/nasbkup
rsync -a /home/hisham/.local/share/fonts /mnt/nasbkup/.local/share
rsync -a /home/hisham/.local/share/emojis /mnt/nasbkup/.local/share
rsync -a /home/hisham/.local/share/Nature.mp3 /mnt/nasbkup/.local/share
rsync -a /home/hisham/.local/share/Azan.webm /mnt/nasbkup/.local/share
rsync -a /home/hisham/.local/share/Azan_fajr.webm /mnt/nasbkup/.local/share
rsync -a /home/hisham/.local/share/azan.mp3 /mnt/nasbkup/.local/share
rsync -a /home/hisham/.local/share/azan_abdul_baset.mp3 /mnt/nasbkup/.local/share
rsync -a /home/hisham/.local/share/prayers.json /mnt/nasbkup/.local/share

rsync -a /home/hisham/.local/bin/ /mnt/nasbkup/.local/bin

## Not used anymore
#rsync -a /home/hisham/.local/share/barrier /mnt/nasbkup/.local/share
#
#rsync -a /home/hisham/.local/share/pkglist /mnt/nasbkup/.local/share
#
#rsync -a /home/hisham/Videos/ /mnt/DATA/YouTubeChannel
#
#rsync -a /home/hisham/tinyMediaManager/ /mnt/nasbkup/tinyMediaManager
#
#rsync -a /etc/logid.cfg /mnt/DATA/BACKUP/etc
#
#rsync -a /etc/pacman.d/hooks/ /mnt/DATA/BACKUP/etc/hooks
