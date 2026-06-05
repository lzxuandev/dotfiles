#!/usr/bin/env bash

icon="/usr/share/icons/Adwaita/symbolic/status/display-brightness-symbolic.svg"
notification_timeout=1000
step=5

get_backlight() {
    brightnessctl -m | cut -d, -f4 | sed 's/%//'
}

notify_user() {
    notify-send -h string:x-canonical-private-synchronous:osd -u low -i "$icon" "Brightness" "$current%" -t "$notification_timeout"
}
change_backlight() {
    current_brightness=$(get_backlight)
    local new_brightness

    if [[ "$1" == "up" ]]; then
        new_brightness=$((current_brightness + step))
    elif [[ "$1" == "down" ]]; then
        new_brightness=$((current_brightness - step))
    else
        return
    fi

    # Ensure range 5-100
    (( new_brightness < 5 )) && new_brightness=5
    (( new_brightness > 100 )) && new_brightness=100

    brightnessctl set "${new_brightness}%"
    current=$new_brightness
    notify_user
}

change_backlight "$1"
