#!/bin/bash

mapfile -t video < <(
    ffprobe \
        -v error \
        -select_streams v:0 \
        -show_entries stream=codec_name,profile,pix_fmt,width,height,display_aspect_ratio,field_order \
        -of default=noprint_wrappers=1:nokey=1 \
        "$1"
)

for i in "${!video[@]}"
do
    printf 'video[%s] = %s\n' "$i" "${video[$i]}"
done
