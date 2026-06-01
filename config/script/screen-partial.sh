#!/bin/sh

DIR="$HOME/Pictures/Screenshots"

mkdir -p "$DIR"
TIME=$(date +"%d-%m-%Y_%H:%M:%S")
FILE="$DIR/Screenshot_${TIME}.png"

GEOM=$(slurp 2>/dev/null)
if [ -z "$GEOM" ]; then
    notify-send "Screenshot cancelled"
    exit 0
fi

if ! grim -g "$GEOM" "$FILE"; then
    notify-send "❌ Screenshot failed (grim error)"
    exit 1
fi

wl-copy < "$FILE"
notify-send -u low -t 2000 "截图成功" "$(basename "$FILE")\n已复制到剪贴板"
