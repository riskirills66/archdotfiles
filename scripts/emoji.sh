#!/bin/bash
rofi -modi emoji -monitor "$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')" -show emoji
