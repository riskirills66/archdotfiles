# Hyprland Dotfiles Setup Guide

This guide provides step-by-step instructions for setting up and configuring Hyprland dotfiles, along with essential tools and services.

## Disclaimer

Some assets or configurations in this repository may not be entirely my own work. While I have curated and organized these dotfiles, third-party assets may be unintentionally included. 

By using this repository, you agree to:
- Use these dotfiles mindfully and at your own risk.
- Refrain from using any part of this repository for commercial purposes or behind a paywall.
- Notify me if you discover any third-party assets, so I can address them appropriately.

Thank you for your understanding!

---

## Prerequisites

### General Tools
Install the necessary dependencies:
```bash
sudo pacman -S git stow vim nvim ntfs-3g make cmake gcc python3
```

---

## Installation

### Clone and Stow Dotfiles
1. Clone the repository:
   ```bash
   cd ~
   git clone https://github.com/riskirills66/archdotfiles.git
   cd archdotfiles
   ```

2. Stow the dotfiles:
   ```bash
   stow .
   ```

---

## Software Installation

### Desktop Environment Tools  
Install Hyprland and other essential tools needed for your desktop environment setup. The following packages are included in the command below, with a brief explanation of their purpose:

```bash
sudo pacman -S hyprland sddm flatpak hyprpaper hyprlock waybar cliphist dunst kitty rofi slurp \
qt5-wayland qt6-wayland polkit-kde-agent grim noto-fonts noto-fonts-cjk ttf-fira-code \
pipewire networkmanager htop pavucontrol blueman openvpn unrar unzip imagemagick nwg-look firefox
```

#### Breakdown of Packages:  

- **hyprland**: A dynamic tiling Wayland compositor used as the main desktop environment.  
- **sddm**: A modern and highly customizable display manager (login screen).  
- **flatpak**: A universal package manager for installing and managing applications from Flathub.  
- **hyprpaper**: A lightweight wallpaper manager designed specifically for Hyprland.  
- **hyprlock**: A simple screen locker for Hyprland.  
- **waybar**: A customizable status bar for Wayland-based environments.  
- **cliphist**: Clipboard history manager for managing copied text and images.  
- **dunst**: A lightweight notification daemon to display desktop notifications.  
- **kitty**: A fast, GPU-accelerated terminal emulator.  
- **rofi**: A window switcher, application launcher, and dmenu replacement.  
- **slurp**: A tool to select regions of the screen (useful for screenshots).  
- **qt5-wayland / qt6-wayland**: Enables Wayland support for applications using Qt5 and Qt6 frameworks.  
- **polkit-kde-agent**: A PolicyKit authentication agent for managing administrative actions.  
- **grim**: A screenshot utility for Wayland.  
- **noto-fonts / noto-fonts-cjk**: High-quality fonts with support for multiple languages, including Chinese, Japanese, and Korean (CJK).  
- **ttf-fira-code**: A font with programming ligatures designed for developers.  
- **pipewire**: A modern multimedia framework for handling audio and video streams.  
- **networkmanager**: A network management tool for connecting to Wi-Fi and wired networks.  
- **htop**: An interactive process viewer for monitoring system resources.  
- **pavucontrol**: A graphical interface for managing audio devices and streams (requires PipeWire or PulseAudio).  
- **blueman**: A GTK-based Bluetooth manager.  
- **openvpn**: An optional VPN client for secure and encrypted connections.  
- **unrar / unzip**: Tools for extracting compressed files in RAR and ZIP formats.  
- **imagemagick**: A versatile image manipulation tool for editing and converting image files.  
- **nwg-look**: A utility for configuring GTK themes in Wayland environments.  
- **firefox**: A popular open-source web browser.  

### Notes:  
- **Optional Packages**:  
  - **openvpn**, **unrar**, and **imagemagick** are optional and included for convenience; feel free to omit them if not needed.  
  - **blueman** is necessary only if you use Bluetooth devices.  
- If you don’t plan to use Flatpak apps, **flatpak** can also be omitted.  

### Command-Line Tools  

The following command-line tools are useful for enhancing your workflow and system management. Install them using `pacman`:

```bash
sudo pacman -S cmus cava fastfetch yazi fzf swayimg
```

#### Breakdown of Packages:

- **cmus**:  
  A fast and lightweight music player for the terminal. It supports a variety of audio formats and provides a simple yet effective way to manage and play music directly from the command line. Perfect for users who prefer a keyboard-driven interface.

- **cava**:  
  A terminal-based audio visualizer that displays an interactive visualization of your system's audio output. It can be used alongside cmus or any other music player for a visually engaging experience while listening to music.

- **fastfetch**:  
  A fast and minimalistic system information tool for the terminal. It provides quick and attractive outputs like CPU, RAM, and GPU information, uptime, and more. It's often used to show off system specs in a clean and visually appealing way.

- **yazi**:  
  A terminal-based utility for navigating and managing directories. It provides an easy way to search through and open directories directly from the command line, improving your workflow when dealing with file systems.

- **fzf**:  
  A command-line fuzzy finder that allows you to quickly search and filter through files, directories, command history, and more. It's a powerful tool for enhancing productivity by speeding up file navigation and command execution.

- **swayimg**:  
  A simple image viewer for the terminal designed to work with the Sway compositor. It allows you to view images directly from the terminal window, which is handy for quick image viewing without leaving the command line.

### Notes:  
- These tools are **recommended** for enhancing your command-line experience, especially for media management (cmus, cava), system info (fastfetch), and file navigation (yazi, fzf).  
- You can omit any tools that you don’t plan on using or don’t find useful for your specific workflow.

---

### Install Yay (AUR Helper)
1. Install prerequisites:
   ```bash
   sudo pacman -S --needed git base-devel
   ```

2. Clone and build Yay:
   ```bash
   git clone https://aur.archlinux.org/yay-bin.git
   cd yay-bin
   makepkg -si
   cd ..
   ```

Got it! Here's the revised and clarified version indicating that all AUR packages are required:

---

### AUR Packages  

The following tools are **required** to fully configure and utilize your Hyprland setup. Use the `yay` AUR helper to install them:  

```bash
yay -S python-pywal16 wlogout hyprshot xdg-desktop-portal-hyprland-git python-pywalfox
```

#### Breakdown of Packages:  

- **python-pywal16**:  
  A Python library and CLI tool that generates and applies color schemes based on your wallpaper. This ensures that your terminal and desktop applications have a cohesive, matching theme. Essential for creating a visually consistent setup.  

- **wlogout**:  
  A minimal and customizable logout screen specifically for Wayland environments. It provides options like logout, shutdown, and reboot, tailored for Hyprland's workflow.  

- **hyprshot**:  
  A screenshot utility optimized for Hyprland. It allows you to easily capture specific windows, regions, or the entire screen while respecting Hyprland's compositor behavior.  

- **xdg-desktop-portal-hyprland-git**:  
  A Hyprland-specific implementation of the XDG Desktop Portal. This package is critical for enabling features like screen sharing (e.g., in video conferencing apps), Flatpak sandboxing, and desktop integration with various tools.  

- **python-pywalfox**:  
  A tool that syncs your Firefox theme with your Pywal-generated desktop color scheme. It ensures your browser matches the overall look of your desktop for a cohesive and polished experience.  

---

### Notes:  
- These AUR packages are **required** for the proper functionality and customization of the Hyprland setup.  
- Ensure that the **yay** AUR helper is installed beforehand (instructions for installing `yay` are provided earlier in this guide).  

This section ensures users understand that these tools are essential for completing their setup. Let me know if you'd like further tweaks!

To configure Pywalfox:
```bash
pywalfox install
```

---

## Service Configuration

### Enable Bluetooth
```bash
sudo systemctl enable --now bluetooth.service
```

### Enable SDDM (Display Manager)
```bash
sudo systemctl enable --now sddm
```

---

## Zsh Setup

1. Install and set Zsh as the default shell:
   ```bash
   sudo pacman -S zsh
   chsh -s $(which zsh)
   ```

2. Install **Oh My Zsh**:
   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

3. Add plugins:
   ```bash
   git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
   ```

4. Install **Powerlevel10k**:
   ```bash
   git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
   ```

5. Update `.zshrc`:
   ```bash
   nvim ~/.zshrc
   ```

   Add or update the following:
   ```bash
   ZSH_THEME="powerlevel10k/powerlevel10k"
   plugins=(
       git
       sudo
       web-search
       archlinux
       zsh-autosuggestions
       zsh-syntax-highlighting
       copyfile
       copybuffer
       dirhistory
       history
   )
   ```

   Add the following functions:
   ```bash
   # yazi function
   function y() {
       local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
       yazi "$@" --cwd-file="$tmp"
       if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
           builtin cd -- "$cwd"
       fi
       rm -f -- "$tmp"
   }

   # fzf keybind
   eval "$(fzf --zsh)"
   ```

---

## Optional Configurations

### OpenVPN Setup

1. **Create Configuration Files**:
   ```bash
   sudo touch /etc/openvpn/client.conf
   sudo touch /etc/openvpn/auth.txt
   ```

2. **Add OpenVPN Configuration**:
   Open `/etc/openvpn/client.conf`:
   ```bash
   sudo nvim /etc/openvpn/client.conf
   ```
   Add your OpenVPN server configuration. Example:
   ```
   client
   dev tun
   proto udp
   remote your.vpn.server 1194
   resolv-retry infinite
   nobind
   persist-key
   persist-tun
   auth-user-pass /etc/openvpn/auth.txt
   cipher AES-256-CBC
   verb 3
   ```

3. **Add Authentication Credentials**:
   Open `/etc/openvpn/auth.txt`:
   ```
   username
   password
   ```

4. **Enable and Start OpenVPN Service**:
   ```bash
   sudo systemctl daemon-reload
   sudo systemctl enable --now openvpn-client@client.service
   ```

---

### Wine Setup (32-bit Prefix)

1. Install Wine and dependencies:
   ```bash
   sudo pacman -S wine winetricks wine-mono wine-gecko
   ```

2. Create a 32-bit Wine prefix:
   ```bash
   WINEPREFIX=~/32 winecfg
   ```

3. (Optional) Install .NET frameworks:
   ```bash
   WINEPREFIX=~/32 winetricks dotnet35 dotnet45
   ```

4. Run a Windows application:
   ```bash
   WINEPREFIX=~/32 wine start /d /path/to/executable_dir app_name.exe
   ```

---

### Additional Software

#### GUI Tools
- **LibreOffice**:  
  ```bash
  sudo pacman -S libreoffice
  ```

- **GIMP, Inkscape, Thunderbird**:  
  ```bash
  sudo pacman -S thunderbird gimp inkscape
  ```

- **Discord**:  
  ```bash
  sudo pacman -S discord
  ```

- **Telegram**:  
  ```bash
  sudo pacman -S telegram-desktop
  ```

#### Flatpak Software
- **AnyDesk**:  
  ```bash
  flatpak install flathub com.anydesk.Anydesk
  ```

- **Fragments (Torrent Manager)**:  
  ```bash
  flatpak install flathub de.haeckerfelix.Fragments
  ```

- **Smile**:  
  ```bash
  flatpak install flathub it.mijorus.smile
  ```

---

### Note:
- **OpenVPN**, **Wine**, and the additional software listed above are entirely optional and are not dependencies for Hyprland setup.
- Only install these if you require their functionality.