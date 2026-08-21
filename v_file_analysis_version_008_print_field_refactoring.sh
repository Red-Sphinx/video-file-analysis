#!/bin/bash

# Video File Analysis - Version 008 Print_Field() refactoring

# Usage:
# ./v_file_analysis_version_008_print_field_refactoring.sh movie1.mp4 movie2.mp4 movie3.mp4


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

print_field()
{
    printf "%-17s : %s\n" "$1" "$2"
    #printf "%-18s : %s x %s\n" "$1" "$2"
}

container_format=$(ffprobe \
        -v error \
        -show_entries format=format_name \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

print_field "Container" "$container_format"

video_codec=$(ffprobe \
        -v error \
        -select_streams v:0 \
        -show_entries stream=codec_name \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

print_field "Video Codec" "$video_codec"

codec_profile=$(ffprobe \
        -v error \
        -select_streams v:0 \
        -show_entries stream=profile \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

print_field "Codec Profile" "$codec_profile"


pixfmt=$(ffprobe \
        -v error \
        -select_streams v:0 \
        -show_entries stream=pix_fmt \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

print_field "Pixel Format" "$pixfmt"

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
#print_field "Resolution" "$width" "$height"

aspect_ratio=$(ffprobe \
        -v error \
        -select_streams v:0 \
        -show_entries stream=display_aspect_ratio \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

print_field "Aspect Ratio" "$aspect_ratio"

scan_type=$(ffprobe \
        -v error \
        -select_streams v:0 \
        -show_entries stream=field_order \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

print_field "Scan Type" "$scan_type"

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

print_field "Audio Codec" "$audio_codec"

audio_channels=$(ffprobe \
        -v error \
        -select_streams a:0 \
        -show_entries stream=channels \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

print_field "Audio Channels" "$audio_channels"

audio_sample_rate=$(ffprobe \
        -v error \
        -select_streams a:0 \
        -show_entries stream=sample_rate \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

print_field "Audio Sample Rate" "$audio_sample_rate"

printf "\n"


subtitle_codec=$(ffprobe \
        -v error \
        -select_streams s:0 \
        -show_entries stream=codec_name \
        -of default=noprint_wrappers=1:nokey=1 \
        "$file")

print_field "Subtitle Codec" "$subtitle_codec"

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


