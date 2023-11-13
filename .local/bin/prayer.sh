#!/bin/bash

prayers="/mnt/nasbkup/prayers.json"
currenttime=$(date +%s)  # Use timestamp instead of HH:MM format

# Function to calculate remaining time
calculate_remain() {
    local next_time=$1
    date -u -d @$((next_time - currenttime)) "+%H:%M"
}

# Function to get prayer time
get_prayer_time() {
    local prayer=$1
    case $prayer in
        "Fajr") echo "الفجر" ;;
        "Sunrise") echo "الشروق" ;;
        "Dhuhr") echo "الظهر" ;;
        "Asr") echo "العصر" ;;
        "Maghrib") echo "المغرب" ;;
        "Isha") echo "العشاء" ;;
    esac
}

#Hijri date
day=$(jq ".data.date.hijri.day" $prayers | bc | awk '{$1=$1};1')
month=$(jq ".data.date.hijri.month.ar" $prayers | bc | awk '{$1=$1};1')
year=$(jq ".data.date.hijri.year" $prayers | bc | awk '{$1=$1};1')

# Array of prayers
prayer_names=("Fajr" "Sunrise" "Dhuhr" "Asr" "Maghrib" "Isha")

# Loop through prayers
for i in {0..5}; do
    current_prayer="${prayer_names[i]}"
    current_prayer_time=$(jq ".data.timings.$current_prayer" $prayers | bc | awk '{$1=$1};1')
    current_prayer_timestamp=$(date -d "$current_prayer_time" +%s)

    next_prayer_index=$(( (i + 1) % 6 ))
    next_prayer="${prayer_names[next_prayer_index]}"
    next_prayer_time=$(jq ".data.timings.$next_prayer" $prayers | bc | awk '{$1=$1};1')
    next_prayer_timestamp=$(date -d "$next_prayer_time" +%s)

    if [[ $currenttime -gt $current_prayer_timestamp ]] && [[ $currenttime -lt $next_prayer_timestamp ]]; then
        break
    fi
done

remain=$(calculate_remain $next_prayer_timestamp)

printf '{"text": "%s"}\n' "🕌 $day $month $year ☪️الصلاة القادمة ۩ $(get_prayer_time $next_prayer) ۩ $next_prayer_time ☪️ الوقت المتبقي $remain 🕌"
