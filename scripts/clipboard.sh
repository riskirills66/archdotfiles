#!/bin/bash
dir="$HOME/.config/rofi/launchers/type-1"
theme='style-3'

cliphist list | rofi -dmenu -theme ${dir}/${theme}.rasi -monitor "$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')" | cliphist decode | wl-copy

