#!/usr/bin/env bash

theme="$HOME/.config/rofi/musicplayer/theme.rasi"

# Theme Elements
status="$(mpc status)"
list="$(mpc playlist)"
current="$(mpc current)"

if [[ -z "$status" ]]; then
	prompt='Offline'
	mesg="MPD is Offline"

elif [[ -z "$list" ]]; then
    prompt="Empty"
    mesg="Playlist is empty"
    mpc add /

elif [[ -z "$current" ]]; then
    prompt="Choose a song"
    mesg="No song selected"

else
    prompt="$(mpc -f '%file%' current | awk '{print substr($0,1,25)}')"
    mesg="$(mpc -f '%file%' current) :: $(mpc status | awk '/bitrate/ {print $2}')"
fi

list_col='1'
list_row='6'

# Options
layout=`cat ${theme} | grep 'USE_ICON' | cut -d'=' -f2`
if [[ "$layout" == 'NO' ]]; then
	if [[ ${status} == *"[playing]"* ]]; then
		option_1="󰏤 Pause"
	else
		option_1="󰐊 Play"
	fi
	option_2="󰓛 Stop"
	option_3="󰒮 Previous"
	option_4="󰒭 Next"
	option_5="󰑖 Repeat"
	option_6="󰒝 Random"
else
	if [[ ${status} == *"[playing]"* ]]; then
		option_1="󰏤" # 暂停 (md-pause)
	else
		option_1="󰐊" # 播放 (md-play)
	fi
	option_2="󰓛" # 停止 (md-stop)
	option_3="󰒮" # 上一首 (md-skip-previous)
	option_4="󰒭" # 下一首 (md-skip-next)
	option_5="󰑖" # 循环 (md-repeat)
	option_6="󰒝" # 随机 (md-shuffle)
fi

# Toggle Actions
active=''
urgent=''
# Repeat
if [[ ${status} == *"repeat: on"* ]]; then
    active="-a 4"
elif [[ ${status} == *"repeat: off"* ]]; then
    urgent="-u 4"
else
    option_5="Parsing Error"
fi
# Random
if [[ ${status} == *"random: on"* ]]; then
    [ -n "$active" ] && active+=",5" || active="-a 5"
elif [[ ${status} == *"random: off"* ]]; then
    [ -n "$urgent" ] && urgent+=",5" || urgent="-u 5"
else
    option_6="Parsing Error"
fi

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		${active} ${urgent} \
		-markup-rows \
		-theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6" | rofi_cmd
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		mpc -q toggle && notify-send -u low -t 5000 "󰝚  `mpc current`"
	elif [[ "$1" == '--opt2' ]]; then
		mpc -q stop
	elif [[ "$1" == '--opt3' ]]; then
		mpc -q prev && notify-send -u low -t 5000 "󰝚  `mpc current`"
	elif [[ "$1" == '--opt4' ]]; then
		mpc -q next && notify-send -u low -t 5000 "󰝚   `mpc current`"
	elif [[ "$1" == '--opt5' ]]; then
		mpc seek 0
	elif [[ "$1" == '--opt6' ]]; then
        mpc random on && mpc -q toggle && mpc next && notify-send -u low -t 5000 "󰝚  $(mpc current)"
	fi
}

# Actions
chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
		run_cmd --opt1
        ;;
    $option_2)
		run_cmd --opt2
        ;;
    $option_3)
		run_cmd --opt3
        ;;
    $option_4)
		run_cmd --opt4
        ;;
    $option_5)
		run_cmd --opt5
        ;;
    $option_6)
		run_cmd --opt6
        ;;
esac
