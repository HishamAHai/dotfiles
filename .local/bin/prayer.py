import datetime
import time
import subprocess
import json
import os

# Function to play the sound file
def play_sound(file_path):
    subprocess.run(["mpv", "--volume=70", file_path])

# Function to read prayer times from an external JSON file
def read_prayer_times(file_path):
    with open(file_path, 'r') as file:
        data = json.load(file)
        return data["data"]["timings"]

# ...

# Check if the current time is one of the specified prayer times
def check_prayer_time(prayer_times):
    current_time = datetime.datetime.now().strftime("%H:%M")

    specified_prayers = ["Fajr", "Sunrise", "Dhuhr", "Asr", "Maghrib", "Isha"]

    for prayer in specified_prayers:
        if current_time == prayer_times.get(prayer, ""):
            if prayer == "Fajr":
                play_sound(os.path.expanduser('~/.local/share/Azan_fajr.webm'))
            elif prayer == "Sunrise":
                play_sound(os.path.expanduser('~/.local/share/Nature.mp3'))
            else:
                play_sound(os.path.expanduser('~/.local/share/Azan.webm'))

# ...

# Replace 'path/to/prayers.json' with the actual path to your prayers JSON file
prayer_times_file_path = '/mnt/nasbkup/prayers.json'

# Run the script continuously
while True:
    # Read prayer times from the external JSON file
    prayer_times = read_prayer_times(prayer_times_file_path)
    check_prayer_time(prayer_times)
    # Check every minute
    time.sleep(60)
