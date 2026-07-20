#!/bin/bash

# For analysing video files - Version 001

ffprobe \
-v error \
-show_entries \
format=duration,size:stream=width,height,codec_name,avg_frame_rate,r_frame_rate \
-of default=noprint_wrappers=1 \
example_1.mp4

