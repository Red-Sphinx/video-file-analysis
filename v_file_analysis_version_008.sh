#!/bin/bash

# Video File Analysis - Version 008

# Refactoring

# Usage:
# ./v_file_analysis_version_008.sh movie1.mp4 movie2.mp4 movie3.mp4


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

#container_format=$(ffprobe \
#        -v error \
#        -show_entries format=format_name \
#        -of default=noprint_wrappers=1:nokey=1 \
#        "$file")

#printf "Container         : %s\n" "$container_format"

video=$(ffprobe \
        -v error \
        -select_streams v:0 \
        -show_entries \
        stream=codec_name,profile,pix_fmt,width,height,display_aspect_ratio,field_order,avg_frame_rate,r_frame_rate  \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

printf "Print all         : %s %s %s\n" "$video"
#printf "Print all         : %s %s\n" "$video"
#printf "Print all         : %s\n" "$video"
#printf "Print all         : \n" "$video"
#printf "Print all         : %s %s %s\n" "$video"
#printf "Print all         : %s %s %s\n" "$video"


#audio_codec=$(ffprobe \
#        -v error \
#        -select_streams a:0 \
#        -show_entries stream=codec_name,channels,sample_rate \
#        -of default=noprint_wrappers=1:nokey=1 \
#        "$file")


#subtitle_codec=$(ffprobe \
#        -v error \
#        -select_streams s:0 \
#        -show_entries stream=codec_name \
#        -of default=noprint_wrappers=1:nokey=1 \
#        "$file")



#bitrate=$(ffprobe \
#        -v error \
#        -show_entries format=format_name,bit_rate,duration,size, \
#        -of default=noprint_wrappers=1:nokey=1 \
#        "$file")

#bitrate_mbps=$(awk -v b="$bitrate" \
#        'BEGIN { printf "%.2f\n", b/1000000 }')


done


