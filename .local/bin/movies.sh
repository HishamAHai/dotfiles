#!/usr/bin/env bash


convertmin() {
 ((h=${1}/60))
 ((m=(${1}%60)))
 printf "%02d:%02d\n" $h $m
}

# Movies are stored in /media/MOVIES
root=/mnt/MULTIMEDIA/MOVIES

# Each movie is stored in its directory with all associated files
# So make a recursive list of all the children directories and select a random video file
movie=$(find $root -type f \( -name "*.mp4" -o -name "*.mkv" \) | shuf -n 1)

# Now the movie is selected lets find its directory which will be used to find the thumbnail and 
# .nfo information
dir=$(dirname $movie)

# Change directory to the movie directory
#cd $dir

# Movie artwork is organized and we will use the discart image
thumb=$(find $dir -iname "*discart*")
#thumb=$(find $dir -iname "*logo*")

# The .nfo file will be used to get the movie title, not the file name
info=$(find $dir -name "*.nfo")

# Here goes the movie title
title=$(awk '/<title>/ {print}' $info | grep -oP '(?<=\>).*?(?=\<)')

# And here goes the movie release year
year=$(awk '/<year>/ {print}' $info | grep -oP '(?<=\>).*?(?=\<)')

# Here goes the movie tagline
tag=$(awk '/<tagline>/ {print}' $info | grep -oP '(?<=\>).*?(?=\<)')

# Here goes the movie runtime
runtime=$(awk '/<runtime>/ {print}' $info | grep -oP '(?<=\>).*?(?=\<)')
mintime=$(convertmin $runtime)

# Join the information of the movie and send a notification
sum=$(printf "▶️ <span size=\'large'><b>$title</b></span>\n($year)\n$mintime h\n<i>$tag</i>")
notify-send "$sum" -i $thumb

# Join the title, year and artwork of the movie and send a notification
#notify-send "$title ($year)" -i $thumb

# Play the movie
mpv $movie

exit
