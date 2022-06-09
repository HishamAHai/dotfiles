#!/bin/sh

set=$(ddcutil setvcp 10 $1 $2)
bright=$(ddcutil getvcp 10 | cut -b 67-69)
bar=$(seq -s "🬋" $(($bright/5)) | sed 's/[0-9]//g')

notify-send.py $bright"% "$bar -i "/usr/share/icons/Papirus/48x48/status/notification-display-brightness-full.svg" --replaces-process brightness
