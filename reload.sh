#!/bin/bash

# Directories
WALLPAPER_DIR="$HOME/Downloads/"
THUMBNAIL_DIR="/tmp/rofi_wallpaper_thumbnails"
mkdir -p "$THUMBNAIL_DIR"

# Function to generate thumbnails for wallpaper selection
generate_thumbnails() {
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

    # Use Rofi to select wallpaper
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

    rm -rf ~/.cache/wal

    # Apply wallpaper and color scheme
    feh --bg-fill "$TARGET_WALLPAPER" --no-fehbg
    wal -i ~/nostalgia.jpg -o ~/.cache/wal/colors-kitty.conf
    wal -i ~/nostalgia.jpg -o ~/.cache/wal/colors-waybar.css

    # Kill existing instances of hyprpaper and waybar
    killall hyprpaper
    killall waybar

    # Restart hyprpaper and waybar
    hyprpaper &
    waybar &

    # Source pywal colors
    source ~/.cache/wal/colors.sh

    # Only replace color variables in the Rofi config file
    sed -i "s/b-color: .*/b-color: $background;/" ~/.config/rofi/config.rasi
    sed -i "s/fg-color: .*/fg-color: $color14;/" ~/.config/rofi/config.rasi
    sed -i "s/hl-color: .*/hl-color: $color14;/" ~/.config/rofi/config.rasi
    sed -i "s/fgp-color: .*/fgp-color: $color8;/" ~/.config/rofi/config.rasi
    sed -i "s/w-border-color: .*/w-border-color: $color14;/" ~/.config/rofi/config.rasi
    sed -i "s/wbg-color: .*/wbg-color: $background;/" ~/.config/rofi/config.rasi
    sed -i "s/alt-color: .*/alt-color: $background;/" ~/.config/rofi/config.rasi

    echo "Rofi colors updated."


    # Path to BetterDiscord theme CSS
    THEME_FILE="/home/riskirills/.config/BetterDiscord/themes/midnight.theme.css"

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

    #Apply pywal colors to hyprland border window
    sed -i "s/col.active_border = .*/col.active_border = rgba($color14)/" ~/.config/hypr/hyprland.conf
    sed -i "s/col.active_border = rgba(#\([0-9A-Fa-f]\{6\}\))/col.active_border = rgba(\1FF)/" ~/.config/hypr/hyprland.conf
    sed -i "s/col.inactive_border = .*/col.inactive_border = rgba($background)/" ~/.config/hypr/hyprland.conf
    sed -i "s/col.inactive_border = rgba(#\([0-9A-Fa-f]\{6\}\))/col.inactive_border = rgba(\1FF)/" ~/.config/hypr/hyprland.conf
}

# Function to select and apply an icon theme
select_icon_theme() {
    # Step 1: List available icon themes from both directories
    ICON_THEMES=$(ls /usr/share/icons ~/.local/share/icons 2>/dev/null | sort -u)

    # Step 2: Use Rofi to select an icon theme
    SELECTED_ICON_THEME=$(echo "$ICON_THEMES" | rofi -dmenu -p "Select Icon Theme")

    # Check icon theme selection
    if [ -z "$SELECTED_ICON_THEME" ]; then
        echo "No icon theme selected. Exiting..."
        exit 1
    fi

    # Step 3: Update the Rofi configuration file with the selected icon theme
    sed -i "s|icon-theme:.*|icon-theme: \"$SELECTED_ICON_THEME\";|" ~/.config/rofi/config.rasi

    echo "Rofi icon theme updated to $SELECTED_ICON_THEME."
}

# Function to change the SDDM wallpaper
change_sddm_wallpaper() {
    # Launch a new terminal (kitty in this case) and run the script
    kitty -e bash -c "
      # Prompt for sudo password
      echo 'Please enter your sudo password to continue:'
      sudo -v

      # Check if sudo was successful
      if [ \$? -ne 0 ]; then
        echo 'Error: Failed to authenticate with sudo.'
        exit 1
      fi

      # Paths
      jpg_image=\"\$HOME/nostalgia.jpg\"
      png_image='/usr/share/sddm/themes/elarun/images/background.png'

      # Check if the JPG file exists
      if [ ! -f \"\$jpg_image\" ]; then
        echo 'Error: \$jpg_image not found!'
        exit 1
      fi

      # Check if magick is installed
      if ! command -v magick &> /dev/null; then
        echo 'Error: magick (ImageMagick) is not installed.'
        exit 1
      fi

      # Convert the JPG image to PNG, run the command with sudo to write to protected directory
      echo 'Converting \$jpg_image to PNG...'
      sudo magick \"\$jpg_image\" \"\$png_image\"

      # Verify if the conversion was successful
      if [ -f \"\$png_image\" ]; then
        echo 'Background image successfully replaced with \$jpg_image.'
      else
        echo 'Error: Conversion failed.'
        exit 1
      fi

      # Wait for any key press to exit the terminal and kill kitty terminal
      echo 'Press any key to exit...'
      read -n 1 -s

      # Exit the terminal after key press (will now close kitty window)
      exit
    "
}

# Main menu to choose between wallpaper + wal, icon theme, or change SDDM wallpaper
MAIN_MENU=$(echo -e "Wallpaper + Wal\nIcons Selector\nChange SDDM Wallpaper" | rofi -dmenu -p "Select Option")

# Run the selected option
if [ "$MAIN_MENU" == "Wallpaper + Wal" ]; then
    generate_thumbnails
elif [ "$MAIN_MENU" == "Icons Selector" ]; then
    select_icon_theme
elif [ "$MAIN_MENU" == "Change SDDM Wallpaper" ]; then
    change_sddm_wallpaper
else
    echo "Invalid option selected. Exiting..."
    exit 1
fi
