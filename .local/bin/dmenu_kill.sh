#!/usr/bin/env bash

if [[ "$XDG_SESSION_TYPE" = "wayland" ]]; then
    prc="rofi -dmenu -p 'Search a process to kill'"
    ans="rofi -dmenu -p '$selected' will be killed, are you sure?"
elif [[ "$XDG_SESSION_TYPE" = "x11" ]]; then
    prc="dmenu -p "Search a process to kill" -i -l 20 -g 1 -x 1380 -y 2 -bw 2 -z 1080"
    ans="dmenu -i -p "$selected will be killed, are you sure?""
fi

selected="$(ps -a -u $USER | $prc | awk '{print $1" "$4}')"; 

if [[ ! -z $selected ]]; then

    answer="$(echo -e "Yes\nNo" | $ans )"

    if [[ $answer == "Yes" ]]; then
        selpid="$(awk '{print $1}' <<< $selected)"; 
        kill -9 $selpid
    fi
fi

exit 0
