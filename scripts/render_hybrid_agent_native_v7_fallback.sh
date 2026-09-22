#!/bin/zsh
set -euo pipefail

root="${0:A:h}/.."
input="$root/attempts/hybrid-agent-native-live-v7/hybrid-agent-native-five-app-live.mov"
trim="$root/attempts/hybrid-agent-native-live-v7/hybrid-agent-native-four-app-fallback-v7.mov"
output="$root/artifacts/videos/agent-native-apps/hybrid/hybrid-agent-native-four-app-fallback-v7.mp4"
frame_root="$root/attempts/hybrid-agent-native-live-v7/fallback-overlay-frames"
label='Hybrid | agent-native 4-app run | Jev leg / Luna recovery (design generating at end, slides not reached)'

mkdir -p "$frame_root" "${output:h}"
ffmpeg -y -hide_banner -loglevel error -ss 66 -i "$input" -t 234 \
  -c:v libx264 -crf 18 -pix_fmt yuv420p -an "$trim"

width=$(ffprobe -v error -select_streams v:0 -show_entries stream=width -of csv=p=0 "$trim")
duration=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$trim")
fps=5
strip=168
frames=$(awk -v duration="$duration" -v fps="$fps" 'BEGIN { n = int(duration * fps + 0.999); if (n < 1) n = 1; print n }')

for ((i=0; i<frames; i++)); do
  stamp=$(printf '%02d:%02d' $((i / fps / 60)) $(((i / fps) % 60)))
  magick -size "${width}x${strip}" xc:none \
    -fill 'rgba(0,0,0,0.9)' -draw "rectangle 0,0 $width,$strip" \
    -font /System/Library/Fonts/Supplemental/Arial.ttf -pointsize 30 \
    -fill white -stroke none -gravity southwest -annotate +24+108 "$label" \
    -gravity southeast -annotate +24+108 "$stamp" \
    "$frame_root/$(printf '%05d' "$i").png"
done

tmp="$output.tmp.mp4"
ffmpeg -y -hide_banner -loglevel error -i "$trim" -framerate "$fps" -i "$frame_root/%05d.png" \
  -filter_complex "[0:v]pad=iw:ih+$strip:0:0:black[base];[base][1:v]overlay=0:H-h:shortest=1" \
  -c:v libx264 -crf 18 -pix_fmt yuv420p -an -movflags +faststart "$tmp"
mv "$tmp" "$output"
printf '%s\n' "$output"
