#!/usr/bin/env bash

if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    sel="rofi -dmenu -l 6 -p Options:"
    ans="rofi -dmenu -l 2 -p Sure?"
elif [[ "$XDG_SESSION_TYPE" == "x11" ]]; then
    sel="dmenu -i -p Options:"
    ans="dmenu -i -p Sure?"
fi

actions=(Lock Logout Suspend Reboot Firmware Shutdown)

selected=$(printf '%s\n' "${actions[@]}" | $sel)

if [[ ! -z $selected ]]; then
    answer="$(echo -e "Yes\nNo" | $ans)"
    if [[ $answer == "Yes" ]]; then
        case $selected in 
            Suspend) systemctl suspend ;;
            Logout) sudo killall Xorg ;;
            Reboot) systemctl reboot ;;
            Shutdown) shutdown -h now ;;
            Firmware) systemctl reboot --firmware-setup ;;
        esac
    fi
fi
