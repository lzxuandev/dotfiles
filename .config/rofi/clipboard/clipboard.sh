#!/usr/bin/env bash

cliphist list | rofi -dmenu -p "Clipboard" -theme ~/.config/rofi/clipboard/theme.rasi | cliphist decode | wl-copy
