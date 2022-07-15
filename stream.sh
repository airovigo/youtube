#!/bin/bash
VIDEO=v.mp4

#set -e

echo -n "youtube"
    read youtube

while true
do
  ffmpeg -loglevel info -y -re \
    -re -stream_loop -1 -i $VIDEO \
    -f concat -safe 0 -i <((for f in ./mp3/*.mp3; do path="$PWD/$f"; echo "file ${path@Q}"; done) | shuf) \
    -c:v libx264 -preset veryfast -b:v 3000k -maxrate 3000k -bufsize 6000k \
    -framerate 25 -video_size 1280x720 -vf "format=yuv420p" -g 50 -shortest -strict experimental \
    -c:a aac -b:a 128k -ar 44100 \
    -f flv rtmp://$youtube
done
