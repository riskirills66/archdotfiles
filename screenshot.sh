#!/bin/bash

# Define the directory where screenshots will be saved
screenshot_dir="$HOME/Pictures/Screenshots"

# Ensure the directory exists
mkdir -p "$screenshot_dir"

# Define the options for the menu
options="Screenshot Fullscreen\nScreenshot Window\nScreenshot Region"

# Show the rofi menu and get the selected option
chosen=$(echo -e "$options" | rofi -dmenu -p "Screenshot")

# Check the user's selection and run the corresponding command
case "$chosen" in
    "Screenshot Fullscreen")
        hyprshot -m output -o "$screenshot_dir"
        ;;
    "Screenshot Window")
        hyprshot -m window -o "$screenshot_dir"
        ;;
    "Screenshot Region")
        hyprshot -m region -o "$screenshot_dir"
        ;;
    *)
        echo "No valid option selected"
        ;;
esac
