#!/bin/sh
ICON_ENABLED="/usr/share/icons/Adwaita/symbolic/status/airplane-mode-symbolic.svg"
ICON_DISABLE="/usr/share/icons/Adwaita/symbolic/status/airplane-mode-disabled-symbolic.svg"

if rfkill list all | grep -q "Soft blocked: yes"; then
    notify-send -t 2000 -i $ICON_DISABLE "Airplane Mode" "Disabled"
else
    notify-send -t 2000 -i $ICON_ENABLED "Airplane Mode" "Enabled"
fi
