#!/bin/bash

# Video File Analysis - Version 008 using mapfile

# mapfile refactoring

# Usage:
# ./v_file_analysis_version_008_mapfile_refactoring.sh movie1.mp4 movie2.mp4 movie3.mp4


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

container_format=$(ffprobe \
        -v error \
        -show_entries format=format_name \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

printf "Container         : %s\n" "$container_format"

mapfile -t video < <(
        ffprobe \
        -v error \
        -select_streams v:0 \
        -show_entries stream=codec_name,profile,pix_fmt,width,height,display_aspect_ratio,field_order,avg_frame_rate,r_frame_rate \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

printf "Video Codec       : %s\n" "${video[0]}"
printf "Codec Profile     : %s\n" "${video[1]}"
printf "Pixel Format      : %s\n" "${video[2]}"
#printf "Resolution        : %s x %s\n" "${video[3]}" "${video[4]}"
#printf "Aspect Ratio      : %s\n" "${video[5]}"
#printf "Scan Type         : %s\n" "${video[6]}"

#avgfps=$(echo "${video[7]}" | awk -F/ '{printf "%.2f\n",$1/$2}')
#printf "Frame Rate        : %s (%s fps nominal)\n" "$avgfps" "${video[8]}"

printf "\n"


mapfile -t audio < <(
        ffprobe \
        -v error \
        -select_streams a:0 \
        -show_entries stream=codec_name,channels,sample_rate \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

printf "Audio Codec       : %s\n" "${audio[0]}"
printf "Audio Channels    : %s\n" "${audio[1]}"
printf "Audio Sample Rate : %s\n" "${audio[2]}"

printf "\n"


mapfile -t subtitle < <(
        ffprobe \
        -v error \
        -select_streams s:0 \
        -show_entries stream=codec_name \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

printf "Subtitle Codec    : %s\n" "${subtitle[0]}"

printf "\n"


mapfile -t fm < <(
        ffprobe \
        -v error \
        -show_entries format=bit_rate,duration,size \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

bitrate_mbps=$(awk -v b="${fm[0]}" \
        'BEGIN { printf "%.2f\n", b/1000000 }')
printf "Bitrate           : %s Mbps\n" "$bitrate_mbps"

#duration=$(ffprobe \
#        -v error \
#        -show_entries format=duration \
#        -of default=noprint_wrappers=1:nokey=1 \
#        "$file")

#seconds=${duration%.*}
seconds=${fm[1]%.*}

printf "Duration          : %02d:%02d:%02d\n" \
    $((seconds/3600)) \
    $((seconds%3600/60)) \
    $((seconds%60))

#size=$(ffprobe \
#        -v error \
#        -show_entries format=size \
#        -of default=noprint_wrappers=1:nokey=1 \
#        "$file")

filesize=$(echo "${fm[2]}" | awk '{printf "%.2f\n",$1/1024/1024}')

printf "Size              : %.2f MB\n" "$filesize"


done


