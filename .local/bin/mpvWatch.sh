#!/bin/bash

base_dir="/mnt/videos"
tmp_file="/tmp/playlist.txt"
tmp_thumb="/tmp/thumb.png"
tmp_out="/tmp/output.png"

if [[ "$XDG_SESSION_TYPE" = "wayland" ]]; then
    menu="fuzzel -d -p File"
else
    menu="dmenu -i -x 640 -y 48 -bw 2 -z 2560 -g 3 -l 10 -p File"
fi

if [ "$1" == "list" ]; then

    # Print out a list of files in a dmenu list
    highlighted=$(find $base_dir -type f \( -name "*.mp4" -o -name "*.mov" \
        -o -name "*.mkv" -o -name "*.wmv" \) \-printf "%T@ %f\n" | sort -r | \
        cut -d' ' -f2 | $menu)

    # Generate a thumbnail of the clip using ffmpegthumbnailer
    find $base_dir -type f -iname $highlighted -exec ffmpegthumbnailer -m \
        -s 512 -t 25% -o $tmp_thumb -i {} \;

    # Crop the Generated thumbnail to a circle shape
    convert $tmp_thumb -gravity center \( -size 256x256 xc:Black -fill White \
        -draw 'circle 128 128 128 1' -alpha Copy \) -compose CopyOpacity \
        -composite -trim $tmp_out

    # Send a notification of the selected clip with its thumbnail
    notify-send -i /tmp/output.png "Now Playing: $highlighted"

    # Finally play the clip
    find $base_dir -type f -iname $highlighted -exec mpv --cache=yes {} \;

    # And remove the temporary files
    rm $tmp_thumb $tmp_out

elif [ "$1" == "play" ]; then
    find $base_dir -type f \( -name "*.mp4" -o -name "*.mov" -o -name "*.mkv" \
        -o -name "*.wmv" \) -exec echo {} >> $tmp_file \; && mpv --shuffle \
        --cache=yes --playlist=$tmp_file && rm $tmp_file
fi
