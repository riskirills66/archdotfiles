#!/bin/bash
dir="$HOME/.config/rofi/launchers/type-1"
theme='style-3'

## Run
rofi \
    -theme ${dir}/${theme}.rasi \
    -modi emoji -monitor "$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')" -show emoji
