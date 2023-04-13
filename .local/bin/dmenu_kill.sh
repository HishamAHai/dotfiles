#!/usr/bin/env bash

selected="$(ps -a -u $USER | dmenu -p "Search a process to kill" -i -l 20 -g 1 -x 1380 -y 2 -bw 2 -z 1080 | awk '{print $1" "$4}')"; 

if [[ ! -z $selected ]]; then

    answer="$(echo -e "Yes\nNo" | dmenu -i -p "$selected will be killed, are you sure?" )"

    if [[ $answer == "Yes" ]]; then
        selpid="$(awk '{print $1}' <<< $selected)"; 
        kill -9 $selpid
    fi
fi

exit 0
