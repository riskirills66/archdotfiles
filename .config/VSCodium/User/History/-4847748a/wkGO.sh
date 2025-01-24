#!/bin/bash

# Directories
WALLPAPER_DIR="$HOME/Downloads/"
THUMBNAIL_DIR="/tmp/rofi_wallpaper_thumbnails"
mkdir -p "$THUMBNAIL_DIR"

# Generate thumbnails
for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png}; do
    thumbnail="$THUMBNAIL_DIR/$(basename "$img")"
    if [ ! -f "$thumbnail" ]; then
        convert "$img" -resize 300x300 "$thumbnail" 2>/dev/null
    fi
done

# Combine thumbnails and names
OPTIONS=""
for img in "$WALLPAPER_DIR"/*.{jpg,jpeg,png}; do
    thumbnail="$THUMBNAIL_DIR/$(basename "$img")"
    OPTIONS+="$(basename "$img")\0icon\x1f$thumbnail\n"
done

# Use Rofi with the custom theme for wallpaper selection
SELECTED=$(echo -e "$OPTIONS" | rofi -dmenu -p "Select Wallpaper")

# Check wallpaper selection
if [ -z "$SELECTED" ]; then
    echo "No wallpaper selected. Exiting..."
    exit 1
fi

# Full path to the selected wallpaper
SELECTED_WALLPAPER_PATH="$WALLPAPER_DIR/$SELECTED"

# Ensure the selected wallpaper exists
if [ ! -f "$SELECTED_WALLPAPER_PATH" ]; then
    echo "Wallpaper not found: $SELECTED_WALLPAPER_PATH"
    exit 1
fi

# Path to replace nostalgia.jpg
TARGET_WALLPAPER="$HOME/nostalgia.jpg"

# Replace nostalgia.jpg
cp "$SELECTED_WALLPAPER_PATH" "$TARGET_WALLPAPER"
echo "Replaced nostalgia.jpg with $SELECTED"

# Apply wallpaper and color scheme
feh --bg-fill "$TARGET_WALLPAPER" --no-fehbg
/home/riskirills/.local/bin/wal -i ~/nostalgia.jpg -o ~/.cache/wal/colors-kitty.conf
/home/riskirills/.local/bin/wal -i ~/nostalgia.jpg -o ~/.cache/wal/colors-waybar.css

# Kill existing instances of hyprpaper and waybar
killall hyprpaper
killall waybar

# Restart hyprpaper and waybar
hyprpaper &
waybar &

# Source pywal colors
source ~/.cache/wal/colors.sh

# Only replace color variables in the Rofi config file
sed -i "s/\$color1/$color1/" ~/.config/rofi/config.rasi
sed -i "s/\$color7/$color7/" ~/.config/rofi/config.rasi
sed -i "s/\$color8/$color8/" ~/.config/rofi/config.rasi
sed -i "s/\$color0/$color0/" ~/.config/rofi/config.rasi
sed -i "s/\$color14/$color14/" ~/.config/rofi/config.rasi
sed -i "s/\$color3/$color3/" ~/.config/rofi/config.rasi

echo "Rofi colors updated."

# Path to BetterDiscord theme CSS
THEME_FILE="/home/riskirills/.config/BetterDiscord/themes/midnight.theme.css"

# Path to pywal colors
source ~/.cache/wal/colors.sh

# Apply pywal colors to the midnight.theme.css file
sed -i "s/--accent-1: .*/--accent-1: $color1;/" "$THEME_FILE"
sed -i "s/--accent-2: .*/--accent-2: $color2;/" "$THEME_FILE"
sed -i "s/--accent-3: .*/--accent-3: $color3;/" "$THEME_FILE"
sed -i "s/--accent-4: .*/--accent-4: $color4;/" "$THEME_FILE"
sed -i "s/--accent-5: .*/--accent-5: $color5;/" "$THEME_FILE"
sed -i "s/--text-2: .*/--text-2: $color6;/" "$THEME_FILE"
sed -i "s/--text-3: .*/--text-3: $color10;/" "$THEME_FILE"
sed -i "s/--bg-4: .*/--bg-4: $color0;/" "$THEME_FILE"
sed -i "s/--bg-3: .*/--bg-3: $color0;/" "$THEME_FILE"
sed -i "s/--text-4: .*/--text-4: $color3;/" "$THEME_FILE"
sed -i "s/--text-5: .*/--text-5: $foreground;/" "$THEME_FILE"

echo "BetterDiscord theme updated with pywal colors."

# Step 1: List available icon themes from both directories
ICON_THEMES=$(ls /usr/share/icons ~/.local/share/icons 2>/dev/null | sort -u)

# Step 2: Use Rofi to select an icon theme
SELECTED_ICON_THEME=$(echo "$ICON_THEMES" | rofi -dmenu -p "Select Icon Theme")

# Check icon theme selection
if [ -z "$SELECTED_ICON_THEME" ]; then
    echo "No icon theme selected. Exiting..."
    exit 1
fi

walogram

# Step 3: Update the Rofi configuration file with the selected icon theme
sed -i "s|icon-theme:.*|icon-theme: \"$SELECTED_ICON_THEME\";|" ~/.config/rofi/config.rasi

echo "Rofi icon theme updated to $SELECTED_ICON_THEME."
