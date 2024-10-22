#!/bin/bash
yt-dlp -f 'bestvideo[height<=720]+bestaudio/best[height<=720]' --sponsorblock-mark all --sponsorblock-remove all -o "%(channel)s/%(title)s.%(ext)s" $1

channel_name=$(yt-dlp --print "%(channel)s" $1)

mkdir -p "$channel_name"

echo $1 > "$channel_name/link"
