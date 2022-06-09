#!/bin/sh


prayers="$HOME/.local/share/prayers.json"
output="$HOME/.local/share/prayer_widget"
nextprayer=""

# Parsing the data in a nice form
fajr=$(jq ".data.timings.Fajr" $prayers | bc | awk '{$1=$1};1')
dhuhr=$(jq ".data.timings.Dhuhr" $prayers | bc | awk '{$1=$1};1')
asr=$(jq ".data.timings.Asr" $prayers | bc | awk '{$1=$1};1')
maghrib=$(jq ".data.timings.Maghrib" $prayers | bc | awk '{$1=$1};1')
isha=$(jq ".data.timings.Isha" $prayers | bc | awk '{$1=$1};1')

City="باريلوتشي"
currenttime=$(date +%H:%M)


# Export the current desktop session environment variables
export $(xargs -0 -a "/proc/$(pgrep awesome -n -U $UID)/environ")

# Send a notification when it is prayer time
function send_notification {
    notify=$(printf "🕌 حان الآن موعد صلاة ۩ $currentprayer ۩ حسب التوقيت المحلي لمدينة $City")
    notify-send "$notify" -t 30000
}
case $currenttime in
    $fajr)
        currentprayer=$(echo "الفجر")
        #send_notification
        mpv --no-audio-display --volume=70.000 /home/hisham/.local/share/Azan_fajr.webm
        ;;
    $dhuhr | $asr | $maghrib | $isha)
        currentprayer=$(echo "الظهر")
        #send_notification
        mpv --no-audio-display --volume=70.000 /home/hisham/.local/share/Azan.webm
        ;;
esac
