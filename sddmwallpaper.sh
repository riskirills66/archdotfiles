#!/bin/bash

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

