#!/bin/sh

RECORD_DIR="$HOME/Videos/Recorder"
MAX_DURATION="1800"
mkdir -p "$RECORD_DIR"

if pgrep -f "gpu-screen-recorder" > /dev/null; then
    pkill -f gpu-screen-recorder
    notify-send "Recording Stopped" "视频已保存至 $RECORD_DIR" -t 3000
else
    FILENAME="Screen_recording_$(date +"%d%m%Y_%H%M%S").mp4"
    notify-send "Recording Started" "再次按下快捷键停止" -t 5000

    gpu-screen-recorder \
        -w screen \
        -f 60 \
        -q ultra \
        -a default_output \
        -o "$RECORD_DIR/$FILENAME" &

    (
        sleep "$MAX_DURATION"
        if pgrep -f "gpu-screen-recorder" > /dev/null; then
            pkill -f gpu-screen-recorder
            notify-send "⚠️ 录屏已自动切断" "已达到最大限制时间（$(expr $MAX_DURATION / 60) 分钟），已自动保存。" -t 5000
        fi
    ) &
fi
