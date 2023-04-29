#!/bin/sh

if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    menu="fuzzel -d -l 30 -w 15 -p Emoji"
    copy="wl-copy --primary"
else
    menu="dmenu -p "Emoji:" -i -bw 2 -x 960 -y 48 -z 1920 -l 15 -g 5"
    copy="xclip -selection clipboard"
fi
# Get user selection via dmenu from emoji file.
chosen=$(cat ~/.local/share/emojis | $menu | sed 's/ .*//')

# Exit if none chosen.
[ -z "$chosen" ] && exit

# If you run this command with an argument, it will automatically insert the
# character. Otherwise, show a message that the emoji has been copied.
if [ -n "$1" ]; then
	xdotool type "$chosen"
else
	echo "$chosen" | tr -d '\n' | $copy
	notify-send "'$chosen' copied to clipboard." &
fi
