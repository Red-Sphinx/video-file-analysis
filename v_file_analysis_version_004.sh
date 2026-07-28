#!/bin/bash

# For analysing video files - Version 004

# Process multiple files supplied as command-line arguments.
# Usage: ./v_file_analysis_version_004.sh example_1.mp4 example_2.mp4 example_3.mp4


for file in "$@"
do

echo "===== $file ====="

codec=$(ffprobe \
        -v error \
        -show_entries stream=codec_name \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

printf "Codec      : %s\n" "$codec"


width=$(ffprobe \
        -v error \
        -show_entries stream=width \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

height=$(ffprobe \
        -v error \
        -show_entries stream=height \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

printf "Resolution : %s x %s\n" "$width" "$height"


avgframerate=$(ffprobe \
        -v error \
        -show_entries stream=avg_frame_rate \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

rframerate=$(ffprobe \
        -v error \
        -show_entries stream=r_frame_rate \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

avgfps=$(echo "$avgframerate" | awk -F/ '{printf "%.2f\n",$1/$2}')
printf "Frame Rate : %s (%s fps nominal)\n" "$avgfps" "$rframerate"

duration=$(ffprobe \
        -v error \
        -show_entries format=duration \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

seconds=${duration%.*}

printf "Duration   : %02d:%02d:%02d\n" \
    $((seconds/3600)) \
    $((seconds%3600/60)) \
    $((seconds%60))

size=$(ffprobe \
        -v error \
        -show_entries format=size \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

filesize=$(echo $size | awk '{printf "%.2f\n",$1/1024/1024}')

printf "Size       : %.2f MB\n" "$filesize"

done
