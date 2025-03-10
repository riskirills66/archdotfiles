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
chosen=$(echo -e "$options" | rofi -dmenu  -monitor "$(swaymsg -t get_outputs | jq -r '.[] | select(.focused) | .name')" -p "Screenshot")

# Check the user's selection and run the corresponding command
case "$chosen" in
    "Screenshot Focused Monitor")
        grim -o "$focused_monitor" "$screenshot_dir/screenshot_$timestamp.png"
        ;;
    "Screenshot Window")
        grim -g "$(swaymsg -t get_tree | jq -r '.. | select(.focused?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"')" "$screenshot_dir/screenshot_$timestamp.png"
        ;;
   "Screenshot Region")
        grim -g "$(slurp)" "$screenshot_dir/screenshot_$timestamp.png"
        ;;
    *)
        echo "No valid option selected"
        ;;
esac
