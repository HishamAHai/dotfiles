#/bin/sh

# Usage: dnxhd.sh directory
#
#
# First we change directory to where the files we want to transcode are located
cd $1

# A "for" loop is used to loop through all the raw clips
for i in {*.MOV,*.mkv}
do
    # First let's check the file extension to determine which one is MOV and which one is mkv.
    if [[ $i == *.MOV ]]; then
    # To get the file name without extension, the basename command can be used
    output=$(basename -s .MOV $i)
    else
	output=$(basename -s .mkv $i)
    fi

    # With ffmpeg command we transcode the clip to dnxhd codec
    # dnxhd is the desired video codec
    # fps=30000/1001=29.97 is the framerate of Nikon D7100 raw clips
    # pcm_s16le is the audio codec supported by Davinci Resolve Free
    # yuv422p10 is the pixel format
    # The new file name will be the original file name but with a different extension
    ffmpeg -hide_banner -i $i -c:v dnxhd -vf "scale=1920:1080,fps=30000/1001,format=yuv422p10" -b:v 175M -c:a pcm_s16le $output.mov

# The "for" loop is done
done
