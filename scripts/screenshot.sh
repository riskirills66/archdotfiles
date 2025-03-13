#!/bin/bash

dir="$HOME/.config/rofi/launchers/type-1"
theme='style-3'

# Define the directory where screenshots will be saved
screenshot_dir="$HOME/Pictures/Screenshots"

# Ensure the directory exists
mkdir -p "$screenshot_dir"

# Generate timestamp for filename
timestamp=$(date '+%Y-%m-%d_%H-%M-%S')

# Get the focused monitor name
focused_monitor=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')

# Define the options for the menu
options="Screenshot Focused Monitor\nScreenshot Window\nScreenshot Region"

# Show the rofi menu and get the selected option
chosen=$(echo -e "$options" | rofi -dmenu -theme ${dir}/${theme}.rasi -monitor "$focused_monitor" -p "Screenshot")

# Check the user's selection and run the corresponding command
case "$chosen" in
    "Screenshot Focused Monitor")
        filepath="$screenshot_dir/screenshot_$timestamp.png"
        grim -o "$focused_monitor" "$filepath"
        wl-copy < "$filepath"
        notify-send "Screenshot Taken" "Saved to: $filepath" -i "$filepath"
        ;;
    "Screenshot Window")
        filepath="$screenshot_dir/screenshot_$timestamp.png"
        grim -g "$(swaymsg -t get_tree | jq -r '.. | select(.focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')" "$filepath"
        wl-copy < "$filepath"
        notify-send "Screenshot Taken" "Saved to: $filepath" -i "$filepath"
        ;;
    "Screenshot Region")
        sleep 0.2  # Small delay to ensure rofi fully exits before running slurp
        region=$(slurp)
        if [ -n "$region" ]; then
            filepath="$screenshot_dir/screenshot_$timestamp.png"
            grim -g "$region" "$filepath"
            wl-copy < "$filepath"
            notify-send "Screenshot Taken" "Saved to: $filepath" -i "$filepath"
        else
            notify-send "Screenshot Cancelled" "No region selected"
        fi
        ;;
    *)
        notify-send "Screenshot Cancelled" "No valid option selected"
        ;;
esac
