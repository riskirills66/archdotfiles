#!/bin/sh
dir="$HOME/.config/rofi/launchers/type-1"
theme='style-10'

## Run
rofi \
    -show drun \
    -theme ${dir}/${theme}.rasi \
    -monitor "$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')"

