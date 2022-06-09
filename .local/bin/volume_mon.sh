#!/bin/sh

# Prints the current volume or 🔇 if muted.


[ $(pamixer --get-mute) = true ] && echo 🔇 && exit

vol="$(pamixer --get-volume)"

if [ "$vol" -gt "70" ]; then
	icon="🔊"
elif [ "$vol" -lt "20" ]; then
	icon="🔈"
else
	icon="🔉"
fi

echo "$icon $vol%"
