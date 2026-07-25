#!/bin/bash

# For analysing video files - Version 002
# Improved formatted output (Display metadata in a cleaner format).

codec=$(ffprobe \
        -v error \
        -show_entries stream=codec_name \
        -of default=noprint_wrappers=1:nokey=1 \
        example_1.mp4)

printf "Codec      : %s\n" "$codec"


width=$(ffprobe \
        -v error \
        -show_entries stream=width \
        -of default=noprint_wrappers=1:nokey=1 \
        example_1.mp4)

height=$(ffprobe \
        -v error \
        -show_entries stream=height \
        -of default=noprint_wrappers=1:nokey=1 \
        example_1.mp4)

printf "Resolution : %s x %s\n" "$width" "$height"


avgframerate=$(ffprobe \
        -v error \
        -show_entries stream=avg_frame_rate \
        -of default=noprint_wrappers=1:nokey=1 \
        example_1.mp4)

rframerate=$(ffprobe \
        -v error \
        -show_entries stream=r_frame_rate \
        -of default=noprint_wrappers=1:nokey=1 \
        example_1.mp4)

avgfps=$(echo "$avgframerate" | awk -F/ '{printf "%.2f\n",$1/$2}')
printf "Frame Rate : %s (%s fps nominal)\n" "$avgfps" "$rframerate"

duration=$(ffprobe \
        -v error \
        -show_entries format=duration \
        -of default=noprint_wrappers=1:nokey=1 \
        example_1.mp4)

seconds=${duration%.*}

printf "Duration   : %02d:%02d:%02d\n" \
    $((seconds/3600)) \
    $((seconds%3600/60)) \
    $((seconds%60))

size=$(ffprobe \
        -v error \
        -show_entries format=size \
        -of default=noprint_wrappers=1:nokey=1 \
        example_1.mp4)

filesize=$(echo "$size" | awk '{printf "%.2f\n",$1/1024/1024}')

printf "Size       : %.2f MB\n" "$filesize"

