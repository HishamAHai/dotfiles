#!/bin/sh

# Get some parameters like the location and the school to be used
# when calculating the fajr and isha angle
today=$(date +%s)
lat='-41.124877'
long='-71.365303'
city="Bariloche"
country="Argentina"
method="2" #method 2 for Americas
adjustment="1"
output="$HOME/.local/share/prayers.json"

# The api can be found for free
curl "http://api.aladhan.com/v1/timings/$today?latitude=$lat&longitude=$long&method=$method&adjustment=$adjustment" -s -o $output
