#!/bin/sh
#
# Usage: transcode.sh $1 $2
# $1 Could be a file or a directory
# $2 Could be empty or a string to be used instead of the orignal file name (applicable only when the first input argument is a file)
#
# If the argument is a directory, then, we want to transcode the files with specific format inside this directory to dnxhd codec
if [[ -d $1 ]]; then
    cd $1
    # A "for" loop is used to loop through all the raw clips
    for i in {*.mkv,*.MOV}
    do
	# Get the filename without extension.
    if [[ $i == *.mkv ]]; then
        output=$(basename -s .mkv $i)
    elif [[ $i == *.MOV ]]; then
        output=$(basename -s .MOV $i)
    fi
	#
	# With ffmpeg command we transcode the clip to dnxhd codec
	# dnxhd is the desired video codec
        # fps=30000/1001=29.97 is the framerate of Nikon D7100 raw clips
        # pcm_s16le is the audio codec supported by Davinci Resolve Free
        # yuv422p10 is the pixel format
        # The new file name will be the original file name but with a different extension
	ffmpeg -hide_banner -loglevel quiet -stats -i $i -map 0:v -map 0:a -c:v dnxhd -vf "scale=1920:1080,format=yuv422p10" -b:v 175M -c:a pcm_s16le $output.mov
	#
	# The "for" loop is done
    done
    #
    # If the argument is a file, then, we want to transcode the file to h265 codec
elif [[ -f $1 ]]; then
    # If a specific name is given in the second input argument, use it.
    if [ -n "$2" ]; then
	file=$2
    else
    # Else, use the name of the original file and change the extension
	file=$(basename -s .mov $1)
    fi
    ffmpeg -hide_banner -loglevel quiet -stats -y -hwaccel cuda -hwaccel_output_format cuda -i $1 -c:a aac -c:v hevc_nvenc -b:v 8M -pix_fmt yuv420p -fps_mode passthrough $(dirname $1)/$file.mp4
fi
