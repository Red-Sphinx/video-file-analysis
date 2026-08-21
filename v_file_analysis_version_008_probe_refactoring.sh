#!/bin/bash

# Video File Analysis - Version 008 probe() refactoring

# Usage:
# ./v_file_analysis_version_008_probe_refactoring.sh movie1.mp4 movie2.mp4 movie3.mp4


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

probe()
{
    ffprobe \
        -v error \
        -of default=noprint_wrappers=1:nokey=1 \
        "$@"
}

container_format=$(probe \
        -show_entries format=format_name \
        "$file")

printf "Container         : %s\n" "$container_format"

video_codec=$(probe \
        -select_streams v:0 \
        -show_entries stream=codec_name \
        "$file")

printf "Video Codec       : %s\n" "$video_codec"

codec_profile=$(probe \
        -select_streams v:0 \
        -show_entries stream=profile \
        "$file")

printf "Codec Profile     : %s\n" "$codec_profile"

pixfmt=$(probe \
        -select_streams v:0 \
        -show_entries stream=pix_fmt \
        "$file")

printf "Pixel Format      : %s\n" "$pixfmt"

width=$(probe \
        -select_streams v:0 \
        -show_entries stream=width \
        "$file")

height=$(probe \
        -select_streams v:0 \
        -show_entries stream=height \
        "$file")

printf "Resolution        : %s x %s\n" "$width" "$height"

aspect_ratio=$(probe \
        -select_streams v:0 \
        -show_entries stream=display_aspect_ratio \
        "$file")

printf "Aspect Ratio      : %s\n" "$aspect_ratio"

scan_type=$(probe \
        -select_streams v:0 \
        -show_entries stream=field_order \
        "$file")

printf "Scan Type         : %s\n" "$scan_type"

average_framerate=$(probe \
        -select_streams v:0 \
        -show_entries stream=avg_frame_rate \
        "$file")

rframerate=$(probe \
        -select_streams v:0 \
        -show_entries stream=r_frame_rate \
        "$file")

avgfps=$(echo "$average_framerate" | awk -F/ '{printf "%.2f\n",$1/$2}')
printf "Frame Rate        : %s (%s fps nominal)\n" "$avgfps" "$rframerate"

printf "\n"


audio_codec=$(probe \
        -select_streams a:0 \
        -show_entries stream=codec_name \
        "$file")

printf "Audio Codec       : %s\n" "$audio_codec"

audio_channels=$(probe \
        -select_streams a:0 \
        -show_entries stream=channels \
        "$file")

printf "Audio Channels    : %s\n" "$audio_channels"

audio_sample_rate=$(probe \
        -select_streams a:0 \
        -show_entries stream=sample_rate \
        "$file")

printf "Audio Sample Rate : %s\n" "$audio_sample_rate"

printf "\n"


subtitle_codec=$(probe \
        -select_streams s:0 \
        -show_entries stream=codec_name \
        "$file")

printf "Subtitle Codec    : %s\n" "$subtitle_codec"

printf "\n"


bitrate=$(probe \
        -show_entries format=bit_rate \
        "$file")

bitrate_mbps=$(awk -v b="$bitrate" \
        'BEGIN { printf "%.2f\n", b/1000000 }')
printf "Bitrate           : %s Mbps\n" "$bitrate_mbps"

duration=$(probe \
        -show_entries format=duration \
        "$file")

seconds=${duration%.*}

printf "Duration          : %02d:%02d:%02d\n" \
    $((seconds/3600)) \
    $((seconds%3600/60)) \
    $((seconds%60))

size=$(probe \
        -show_entries format=size \
        "$file")

filesize=$(echo "$size" | awk '{printf "%.2f\n",$1/1024/1024}')

printf "Size              : %.2f MB\n" "$filesize"


done


