#!/bin/sh
rofi -show drun -monitor "$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')"
