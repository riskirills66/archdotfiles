#!/bin/bash

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
chosen=$(echo -e "$options" | rofi -dmenu -monitor "$focused_monitor" -p "Screenshot")

# Check the user's selection and run the corresponding command
case "$chosen" in
    "Screenshot Focused Monitor")
        grim -o "$focused_monitor" "$screenshot_dir/screenshot_$timestamp.png"
        wl-copy < "$screenshot_dir/screenshot_$timestamp.png"
        ;;
    "Screenshot Window")
        grim -g "$(swaymsg -t get_tree | jq -r '.. | select(.focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')" "$screenshot_dir/screenshot_$timestamp.png"
        wl-copy < "$screenshot_dir/screenshot_$timestamp.png"
        ;;
    "Screenshot Region")
        sleep 0.2  # Small delay to ensure rofi fully exits before running slurp
        region=$(slurp)
        if [ -n "$region" ]; then
            grim -g "$region" "$screenshot_dir/screenshot_$timestamp.png"
            wl-copy < "$screenshot_dir/screenshot_$timestamp.png"
        else
            echo "No region selected"
        fi
        ;;
    *)
        echo "No valid option selected"
        ;;
esac
