#!/usr/bin/env bash

selected="$(ps -a -u $USER | dmenu -i -p "Search a process to kill" -l 20 | awk '{print $1" "$4}')"; 

if [[ ! -z $selected ]]; then

    answer="$(echo -e "Yes\nNo" | dmenu -i -p "$selected will be killed, are you sure?" )"

    if [[ $answer == "Yes" ]]; then
        selpid="$(awk '{print $1}' <<< $selected)"; 
        kill -9 $selpid
    fi
fi

exit 0
