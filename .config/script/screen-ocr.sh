#!/bin/sh

GEOM=$(slurp 2>/dev/null)
if [ -z "$GEOM" ]; then
    notify-send "Screen OCR cancelled"
    exit 0
fi

if ! grim -g "$GEOM" - | tesseract - - -l eng 2>/dev/null | wl-copy; then
    notify-send "❌ Text recognition failed"
    exit 1
fi

notify-send -u low -t 2000 "OCR 成功" "文字已提取并复制到剪贴板"
