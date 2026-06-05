#!/bin/sh
DEVICE_NAME="elan0672:00-04f3:3187-touchpad"
STATE_FILE="/tmp/hypr_tg_touchpad"
ICON="/usr/share/icons/Adwaita/symbolic/status/touchpad-disabled-symbolic.svg"

[[ -f "$STATE_FILE" ]] && CURRENT_STATE=$(cat "$STATE_FILE") || CURRENT_STATE="true"

if [[ "$CURRENT_STATE" == "true" ]]; then
    NEXT_STATE="false"
    NOTIFY_MSG="Disabled"
else
    NEXT_STATE="true"
    NOTIFY_MSG="Enabled"
fi

echo "$NEXT_STATE" > "$STATE_FILE"

hyprctl eval "hl.device({ name = \"$DEVICE_NAME\", enabled = $NEXT_STATE })"

notify-send -u low -t 2000 -i $ICON "Touchpad" "$NOTIFY_MSG"
