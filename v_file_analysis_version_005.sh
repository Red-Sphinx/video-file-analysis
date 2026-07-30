#!/bin/bash

# For analysing video files - Version 005

# Add bitrate reporting and improve stream selection.
# Display video, audio and subtitle codecs.
# Usage: ./v_file_analysis_version_005.sh example_1.mp4 example_2.mp4 example_3.mp4


for file in "$@"
do

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

sub_codec=$(ffprobe \
        -v error \
        -select_streams s:0 \
        -show_entries stream=codec_name \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

printf "Subtitle Codec : %s\n" "$sub_codec"


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


avgframerate=$(ffprobe \
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

avgfps=$(echo "$avgframerate" | awk -F/ '{printf "%.2f\n",$1/$2}')
printf "Frame Rate     : %s (%s fps nominal)\n" "$avgfps" "$rframerate"


bitrate=$(ffprobe \
        -v error \
        -show_entries format=bit_rate \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

bitrate_mbps=$(echo "$bitrate" | awk -v b="$bitrate" 'BEGIN{  printf "%.2f\n", b/1000000}')
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
