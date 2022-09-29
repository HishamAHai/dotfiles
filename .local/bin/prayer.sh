#!/bin/sh

nextprayer=""
prayers="$HOME/.local/share/prayers.json"

# Parsing the data for the five salawat
fajr=$(jq ".data.timings.Fajr" $prayers | bc | awk '{$1=$1};1')
dhuhr=$(jq ".data.timings.Dhuhr" $prayers | bc | awk '{$1=$1};1')
asr=$(jq ".data.timings.Asr" $prayers | bc | awk '{$1=$1};1')
maghrib=$(jq ".data.timings.Maghrib" $prayers | bc | awk '{$1=$1};1')
isha=$(jq ".data.timings.Isha" $prayers | bc | awk '{$1=$1};1')

# Get the current time
currenttime=$(date +%H:%M)

# For each prayer, two variables are used, one to be printed as the name of the prayer (nextprayer), 
# and the other variable (time) to be used in the calculation of the remaining time (nextTime)
if [ $currenttime > $fajr ] && [ $currenttime < $dhuhr ]; then
    nextprayer=$(echo "الظهر")
    nextTime=$dhuhr

elif [ $currenttime > $dhuhr ] && [ $currenttime < $asr ]; then
    nextprayer=$(echo "العصر")
    nextTime=$asr

elif [ $currenttime > $asr ] && [ $currenttime < $maghrib ]; then
    nextprayer=$(echo "المغرب")
    nextTime=$maghrib

elif [ $currenttime > $maghrib ] && [ $currenttime < $isha ]; then
    nextprayer=$(echo "العشاء")
    nextTime=$isha

elif [ $currenttime > $isha ] || [ $currenttime < $fajr ]; then
    nextprayer=$(echo "الفجر")
    nextTime=$fajr
fi

# Calculate the remaining time to the next prayer (or iftar in ramadan and the fast duration is ramadan)
remain=$(date -u -d @$(($(date -d "$nextTime" "+%s") - $(date -d "$currenttime" "+%s"))) "+%H:%M")
fast=$(date -u -d @$(($(date -d "$maghrib" '+%s') - $(date -d "$fajr" '+%s'))) '+%H:%M')
Tofast=$(date -u -d @$(($(date -d "$maghrib" '+%s') - $(date -d "$currenttime" '+%s'))) '+%H:%M')

# Sending the salawat to the stdout
printf "🕌 الصلاة القادمة ۩ $nextprayer ۩ $nextTime (الوقت المتبقي $remain)"
#printf "🕌 الصلاة القادمة ۩ $nextprayer ۩ $nextTime (الوقت المتبقي $remain)\nمدة الصوم $fast\nالوقت المتبقي حتى الإفطار $Tofast"
