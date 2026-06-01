#!/usr/bin/env bash

# --- Configuration ---
vol_icon="/usr/share/icons/Adwaita/symbolic/status/audio-volume-medium-symbolic.svg"
mute_icon="/usr/share/icons/Adwaita/symbolic/status/audio-volume-muted-symbolic.svg"
mic_icon="/usr/share/icons/Adwaita/symbolic/status/microphone-disabled-symbolic.svg"

notification_timeout=1000
step=0.05

# --- Core Functions ---

get_volume() {
    wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%.0f", $2 * 100}'
}

notify_user() {
    local category=$1
    local icon=$2
    local title=$3
    local message=$4

    notify-send -c "$category" -h string:x-canonical-private-synchronous:osd \
        -u low -i "$icon" "$title" "$message" -t "$notification_timeout"
}

change_volume() {
    local direction=$1

    if [[ "$direction" == "up" ]]; then
        wpctl set-volume -l 1.2 @DEFAULT_AUDIO_SINK@ "$step"+
    elif [[ "$direction" == "down" ]]; then
        wpctl set-volume -l 1.2 @DEFAULT_AUDIO_SINK@ "$step"-
    fi

    local vol=$(get_volume)
    notify_user "volume" "$vol_icon" "Volume" "$vol%"
}

toggle_mute() {
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle

    if [[ $(wpctl get-volume @DEFAULT_AUDIO_SINK@) == *"MUTED"* ]]; then
        notify_user "volume" "$mute_icon" "Volume" "Muted"
    else
        notify_user "volume" "$vol_icon" "Volume" "Unmuted: $(get_volume)%"
    fi
}

toggle_mic() {
    wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle

    if [[ $(wpctl get-volume @DEFAULT_AUDIO_SOURCE@) == *"MUTED"* ]]; then
        notify_user "mic" "$mic_icon" "Microphone" "Muted"
    else
        notify_user "mic" "$mic_icon" "Microphone" "Unmuted"
    fi
}

# --- Execution ---

case "$1" in
    up)   change_volume "up" ;;
    down) change_volume "down" ;;
    mute) toggle_mute ;;
    mic)  toggle_mic ;;
esac
