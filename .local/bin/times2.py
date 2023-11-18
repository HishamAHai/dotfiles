import datetime
import time
import subprocess
import json
import os
import requests

# Function to play the sound file
def play_sound(file_path):
    subprocess.run(["mpv", "--volume=70", file_path])

# Function to read prayer times from a URL
def read_prayer_times(latitude, longitude, method, adjustment):
    today = datetime.datetime.now().strftime("%d-%m-%Y")
    url = f"https://athan.nofarahtech.xyz/v1/timings/{today}?latitude={latitude}&longitude={longitude}&method={method}&adjustment={adjustment}"

    response = requests.get(url)
    if response.status_code == 200:
        data = response.json()
        return data["data"]["timings"]
    else:
        print(f"Failed to fetch data from the URL. Status code: {response.status_code}")
        return None

# Check if the current time is one of the specified prayer times
def check_prayer_time(prayer_times):
    current_time = datetime.datetime.now().strftime("%H:%M")

    specified_prayers = ["Fajr", "Sunrise", "Dhuhr", "Asr", "Maghrib", "Isha"]

    for prayer in specified_prayers:
        if current_time == prayer_times.get(prayer, "") and not played_flags[prayer]:
            if prayer == "Fajr":
                play_sound(os.path.expanduser('~/.local/share/Azan_fajr.webm'))
            elif prayer == "Sunrise":
                play_sound(os.path.expanduser('~/.local/share/Nature.mp3'))
            else:
                play_sound(os.path.expanduser('~/.local/share/Azan.webm'))
            played_flags[prayer] = True  # Set the flag to True after playing the sound

# Define your variables
latitude = -41.124877  # Replace with your actual latitude
longitude = -71.365303  # Replace with your actual longitude
method = 2  # Replace with your desired calculation method
adjustment = -1  # Replace with your desired time adjustment

# Run the script continuously
while True:
    # Read prayer times from the URL
    prayer_times = read_prayer_times(latitude, longitude, method, adjustment)

    if prayer_times is not None:
        played_flags = {prayer: False for prayer in ["Fajr", "Sunrise", "Dhuhr", "Asr", "Maghrib", "Isha"]}
        check_prayer_time(prayer_times)

    # Check every minute
    time.sleep(60)

