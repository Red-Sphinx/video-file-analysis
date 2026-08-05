#!/bin/bash

# Video File Analysis - Version 007

# Adds more features for playback compatibility metadata.

# Usage:
# ./v_file_analysis_version_007.sh movie1.mp4 movie2.mp4 movie3.mp4


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

video_codec=$(ffprobe \
        -v error \
        -select_streams v:0 \
        -show_entries stream=codec_name \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

printf "Video Codec       : %s\n" "$video_codec"

codec_profile=$(ffprobe \
        -v error \
        -select_streams v:0 \
        -show_entries stream=profile \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

printf "Codec Profile     : %s\n" "$codec_profile"

pixfmt=$(ffprobe \
        -v error \
        -select_streams v:0 \
        -show_entries stream=pix_fmt \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

printf "Pixel Format      : %s\n" "$pixfmt"

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

printf "Resolution        : %s x %s\n" "$width" "$height"

aspect_ratio=$(ffprobe \
        -v error \
        -select_streams v:0 \
        -show_entries stream=display_aspect_ratio \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

printf "Aspect Ratio      : %s\n" "$aspect_ratio"

scan_type=$(ffprobe \
        -v error \
        -select_streams v:0 \
        -show_entries stream=field_order \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

printf "Scan Type         : %s\n" "$scan_type"

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
printf "Frame Rate        : %s (%s fps nominal)\n" "$avgfps" "$rframerate"

printf "\n"


audio_codec=$(ffprobe \
        -v error \
        -select_streams a:0 \
        -show_entries stream=codec_name \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

printf "Audio Codec       : %s\n" "$audio_codec"

audio_channels=$(ffprobe \
        -v error \
        -select_streams a:0 \
        -show_entries stream=channels \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

printf "Audio Channels    : %s\n" "$audio_channels"

audio_sample_rate=$(ffprobe \
        -v error \
        -select_streams a:0 \
        -show_entries stream=sample_rate \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

printf "Audio Sample Rate : %s\n" "$audio_sample_rate"

printf "\n"


subtitle_codec=$(ffprobe \
        -v error \
        -select_streams s:0 \
        -show_entries stream=codec_name \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

printf "Subtitle Codec    : %s\n" "$subtitle_codec"

printf "\n"


bitrate=$(ffprobe \
        -v error \
        -show_entries format=bit_rate \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

bitrate_mbps=$(awk -v b="$bitrate" \
        'BEGIN { printf "%.2f\n", b/1000000 }')
printf "Bitrate           : %s Mbps\n" "$bitrate_mbps"

duration=$(ffprobe \
        -v error \
        -show_entries format=duration \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

seconds=${duration%.*}

printf "Duration          : %02d:%02d:%02d\n" \
    $((seconds/3600)) \
    $((seconds%3600/60)) \
    $((seconds%60))

size=$(ffprobe \
        -v error \
        -show_entries format=size \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

filesize=$(echo "$size" | awk '{printf "%.2f\n",$1/1024/1024}')

printf "Size              : %.2f MB\n" "$filesize"


done


