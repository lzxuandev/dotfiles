#!/bin/bash

# CMDs
uptime="`uptime -p | sed -e 's/up //g'`"

# Options
shutdown='󰐥'
reboot='󰜉'
lock='󰌾'
suspend='󰒲'
logout='󰍃'

# Rofi CMD
rofi_cmd() {
	rofi -dmenu \
		-p "󰐥" \
		-mesg "POWER MENU" \
		-theme $HOME/.config/rofi/powermenu/theme.rasi

}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$shutdown\n$reboot\n$logout\n$suspend\n$lock" | rofi_cmd
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
		systemctl poweroff
        ;;
    $reboot)
		systemctl reboot
        ;;
    $lock)
        hyprlock
        ;;
    $suspend)
		wpctl set-mute @DEFAULT_AUDIO_SINK@ 1
		systemctl suspend
        ;;
    $logout)
		hyprctl dispatch exit
        ;;
esac
