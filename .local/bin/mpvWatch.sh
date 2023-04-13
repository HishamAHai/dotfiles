#!/bin/bash

if [ $1 == "list" ]; then
    find /mnt/videos -type f \( -name "*.mp4" -o -name "*.mov" -o -name "*.mkv" -o -name "*.wmv" \) -printf "%T@ %f\n" | sort -r | cut -d' ' -f2 | dmenu -p "File " -i -x 640 -y 48 -bw 2 -z 2560 -g 5 -l 10 | xargs -I {} mpv --cache=yes "/mnt/videos/{}"
elif [ $1 == "play" ]; then
    find /mnt/videos -type f \( -name "*.mp4" -o -name "*.mov" -o -name "*.mkv" -o -name "*.wmv" \) -exec echo {} >> /tmp/playlist.txt \; && mpv --shuffle --cache=yes --playlist=/tmp/playlist.txt && rm /tmp/playlist.txt
fi
