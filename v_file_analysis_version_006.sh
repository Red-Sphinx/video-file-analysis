#!/bin/bash

# Video File Ananysis - Version 006

# Adds basic defensive programming through input validation.
# Improves variable names for readability.

# Usage:
# ./v_file_analysis_version_006.sh movie1.mp4 movie2.mp4 movie3.mp4


if [[ $# -eq 0 ]]
then
    echo "Usage:"
    echo "./v_file_analysis_version_006.sh movie1.mp4 movie2.mp4"
    exit 1
fi


for file in "$@"
do


if [ ! -f "$file" ]; then
    echo "File not found: $file"
    continue
fi

echo "===== $file ====="

video_codec=$(ffprobe \
        -v error \
        -select_streams v:0 \
        -show_entries stream=codec_name \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

printf "Video Codec    : %s\n" "$video_codec"

audio_codec=$(ffprobe \
        -v error \
        -select_streams a:0 \
        -show_entries stream=codec_name \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

printf "Audio Codec    : %s\n" "$audio_codec"

subtitle_codec=$(ffprobe \
        -v error \
        -select_streams s:0 \
        -show_entries stream=codec_name \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

printf "Subtitle Codec : %s\n" "$subtitle_codec"


width=$(ffprobe \
        -v error \
        -select_streams v:0 \
        -show_entries stream=width \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

height=$(ffprobe \
        -v error \
        -select_streams v:0 \
        -show_entries stream=height \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

printf "Resolution     : %s x %s\n" "$width" "$height"


average_framerate=$(ffprobe \
        -v error \
        -select_streams v:0 \
        -show_entries stream=avg_frame_rate \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

rframerate=$(ffprobe \
        -v error \
        -select_streams v:0 \
        -show_entries stream=r_frame_rate \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

avgfps=$(echo "$average_framerate" | awk -F/ '{printf "%.2f\n",$1/$2}')
printf "Frame Rate     : %s (%s fps nominal)\n" "$avgfps" "$rframerate"


bitrate=$(ffprobe \
        -v error \
        -show_entries format=bit_rate \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

bitrate_mbps=$(awk -v b="$bitrate" \
        'BEGIN { printf "%.2f\n", b/1000000 }')
printf "Bitrate        : %s Mbps\n" "$bitrate_mbps"


duration=$(ffprobe \
        -v error \
        -show_entries format=duration \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

seconds=${duration%.*}

printf "Duration       : %02d:%02d:%02d\n" \
    $((seconds/3600)) \
    $((seconds%3600/60)) \
    $((seconds%60))

size=$(ffprobe \
        -v error \
        -show_entries format=size \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

filesize=$(echo "$size" | awk '{printf "%.2f\n",$1/1024/1024}')

printf "Size           : %.2f MB\n" "$filesize"


done


