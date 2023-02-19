#!/bin/sh

for i in $(seq 10); do
    if xsetwacom list devices | grep -q Wacom; then
        break
    fi
    sleep 1
done

list=$(xsetwacom list devices)
pad=$(echo "${list}" | awk '/pad/{print $7}')
stylus=$(echo "${list}" | xsetwacom list devices | awk '/stylus/{print $7}')

if [ -z "${pad}" ]; then
    exit 0
fi
# Get device name
name=$(lsusb | awk '/Wacom/ {print}' | cut -f7- -d' ')

# Restrict the stylus movement to only one monitor
# monitor name HEAD-0 is used here because of nvidia drivers
xsetwacom set "${stylus}" MapToOutput "HEAD-0"
# map the tablet first button from left to undo
xsetwacom set "${pad}" button 1 "key +ctrl z -ctrl"
# map the tablet second button from left to select all content
xsetwacom set "${pad}" button 2 "key +ctrl a -ctrl"
# map the tablet second button from right to delete content
xsetwacom set "${pad}" button 3 "key +del"
# send a notification when the device is connected
notify-send "🎨 Device: <b>${name}</b> is connected"
