#!/bin/sh

prayers="$HOME/.local/share/prayers.json"

# Parsing the data for the five salawat
fajr=$(jq ".data.timings.Fajr" $prayers | bc | awk '{$1=$1};1')
sunrise=$(jq ".data.timings.Sunrise" $prayers | bc | awk '{$1=$1};1')
dhuhr=$(jq ".data.timings.Dhuhr" $prayers | bc | awk '{$1=$1};1')
asr=$(jq ".data.timings.Asr" $prayers | bc | awk '{$1=$1};1')
maghrib=$(jq ".data.timings.Maghrib" $prayers | bc | awk '{$1=$1};1')
isha=$(jq ".data.timings.Isha" $prayers | bc | awk '{$1=$1};1')
day=$(jq ".data.date.hijri.weekday.ar" $prayers | bc | awk '{$1=$1};1')
daynumber=$(jq ".data.date.hijri.day" $prayers | bc | awk '{$1=$1};1')
month=$(jq ".data.date.hijri.month.ar" $prayers | bc | awk '{$1=$1};1')
year=$(jq ".data.date.hijri.year" $prayers | bc | awk '{$1=$1};1')


# Sending the salawat to the stdout
printf "🕌 مواقيت الصلاة ليوم $day \n$daynumber-$month-$year\n۞ الفجر\t\t$fajr\n۞ الشروق\t$sunrise\n۞ الظهر\t$dhuhr\n۞ العصر\t$asr\n۞ المغرب\t$maghrib\n۞ العشاء\t$isha"
