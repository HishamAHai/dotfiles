#!/bin/sh

rsync -a /home/hisham/.config /home/hisham/.screenshots /home/hisham/Pictures /home/hisham/Documents /home/hisham/.ssh /home/hisham/.vim /home/hisham/.xinitrc /home/hisham/.Xresources /home/hisham/.zprofile /home/hisham/br10.xml /mnt/DATA/BACKUP/hisham
rsync -a /home/hisham/.local/share/fonts /mnt/DATA/BACKUP/hisham/.local/share
rsync -a /home/hisham/.local/share/barrier /mnt/DATA/BACKUP/hisham/.local/share
rsync -a /home/hisham/.local/share/emojis /mnt/DATA/BACKUP/hisham/.local/share
rsync -a /home/hisham/.local/share/Nature.mp3 /mnt/DATA/BACKUP/hisham/.local/share
rsync -a /home/hisham/.local/share/Azan.webm /mnt/DATA/BACKUP/hisham/.local/share
rsync -a /home/hisham/.local/share/Azan_fajr.webm /mnt/DATA/BACKUP/hisham/.local/share
rsync -a /home/hisham/.local/share/azan.mp3 /mnt/DATA/BACKUP/hisham/.local/share
rsync -a /home/hisham/.local/share/azan_abdul_baset.mp3 /mnt/DATA/BACKUP/hisham/.local/share
rsync -a /home/hisham/.local/share/pkglist /mnt/DATA/BACKUP/hisham/.local/share
rsync -a /home/hisham/.local/share/prayers.json /mnt/DATA/BACKUP/hisham/.local/share

rsync -a /home/hisham/.local/bin/ /mnt/DATA/BACKUP/hisham/.local/bin

rsync -a /home/hisham/Videos/ /mnt/DATA/YouTubeChannel

rsync -a /home/hisham/tinyMediaManager/ /mnt/DATA/BACKUP/hisham/tinyMediaManager

rsync -a /etc/logid.cfg /mnt/DATA/BACKUP/etc
rsync -a /etc/pacman.d/hooks/ /mnt/DATA/BACKUP/etc/hooks
