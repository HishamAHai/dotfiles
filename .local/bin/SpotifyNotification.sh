#!/bin/sh

thumb=$(playerctl -p spotifyd metadata --format '{{mpris:artUrl}}')
track=$(playerctl -p spotifyd metadata --format '{{mpris:trackid}}' | sed 's/spotify\:track\://g')
curl -s $thumb > /tmp/$track.png

info=$(playerctl -p spotifyd metadata --format '{{status}} {{emoji(status)}}|{{xesam:artist}}|{{xesam:title}}|{{xesam:album}}'| awk -F "|" '{printf  $1"\n[Artist] "$2"\n[Title] "$3"\n[Album] "$4}')
notify-send "$info" -i "/tmp/$track.png" -t 10000

exit 
