#!/bin/sh

DIR="$HOME/Pictures/Screenshots"

mkdir -p "$DIR"
TIME=$(date +"%d-%m-%Y_%H:%M:%S")
FILE="$DIR/Screenshot_${TIME}.png"

if ! grim "$FILE"; then
    notify-send "❌ Screenshot failed (grim error)"
    exit 1
fi

wl-copy < "$FILE"
notify-send -u low -t 2000 "截图成功" "$(basename "$FILE")\n已复制到剪贴板"
