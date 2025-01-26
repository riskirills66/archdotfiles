# Hyprland Dotfiles Setup Guide

This guide covers the installation and configuration of essential tools and services for setting up Hyprland dotfiles.

## Prerequisites

Ensure the following dependencies are installed:

### General Tools
```bash
sudo pacman -S git stow vim nvim ntfs-3g make cmake gcc python3
```

---

### Stowing Dotfiles
Ensure you're logged in to a user account in Virtual Console (this step must be completed before installing Hyprland, otherwise you will encounter issues with stowing dotfiles).
```bash
cd ~
git clone https://github.com/riskirills66/archdotfiles.git
cd archdotfiles
stow .
```

### Desktop Environment (DE) Tools
```bash
sudo pacman -S hyprland sddm flatpak hyprpaper hyprlock waybar cliphist dunst kitty rofi slurp qt5-wayland qt6-wayland polkit-kde-agent grim noto-fonts noto-fonts-cjk ttf-fira-code pipewire networkmanager htop pavucontrol blueman openvpn unrar unzip imagemagick nwg-look firefox 
```

### Command-line Tools
```bash
sudo pacman -S cmus cava fastfetch yazi fzf swayimg
```

### Install Yay (AUR Helper)
```bash
sudo pacman -S --needed git base-devel
git clone https://aur.archlinux.org/yay-bin.git
cd yay-bin
makepkg -si
cd ..
```

### Install Tools from AUR
```bash
yay -S python-pywal16 wlogout hyprshot xdg-desktop-portal-hyprland-git
```

### Install Pywalfox
```bash
yay -S python-pywalfox
```
Then, run the following command:
```bash
pywalfox install
```

---

### Enable Services

To enable the Bluetooth service, run:
```bash
sudo systemctl enable --now bluetooth.service
```

To enable the SDDM service, run:
```bash
sudo systemctl enable --now sddm
```

---

### Install Zsh, Oh My Zsh, Powerlevel10k, and Zsh Plugins

1. Install Zsh in the Kitty terminal:
   ```bash
   sudo pacman -S zsh
   ```

2. Change the default shell to Zsh:
   ```bash
   chsh -s $(which zsh)
   ```

3. Logout and log back in for the changes to take effect.

4. Install Oh My Zsh:
   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

5. Install Zsh plugins:
   ```bash
   git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
   ```
   ```bash
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
   ```

6. Install Powerlevel10k:
   ```bash
   git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
   ```

7. Open and edit `.zshrc`:
   ```bash
   nvim ~/.zshrc
   ```

   Add the following configurations (ensure to overwrite existing configurations):

   ```bash
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

   # Change ZSH_THEME to powerlevel10k
   ZSH_THEME="powerlevel10k/powerlevel10k"
   POWERLEVEL9K_MODE="nerdfont-complete"

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
   # Set up fzf key bindings and fuzzy completion
   eval "$(fzf --zsh)"
   ```

---

### Wine Setup (32-bit Prefix)

1. Install Wine and related tools:
   ```bash
   sudo pacman -S wine winetricks wine-mono wine-gecko
   ```

2. Create the 32-bit Wine prefix:
   ```bash
   WINEPREFIX=~/32 winecfg
   ```

3. Install .NET frameworks (if required):
   ```bash
   WINEPREFIX=~/32 winetricks dotnet35 dotnet45
   ```

4. Run a Windows application:
   ```bash
   WINEPREFIX=~/32 wine start /d /path/to/executable_dir app_name.exe
   ```

   **Note:** Replace `/path/to/executable_dir` and `app_name.exe` with the actual directory and executable name for your Wine setup.

---

## Setting Yazi as the Default Directory Opener

Run the following instructions to set **Yazi** as your default directory opener:

1. Create a new `.desktop` file in `/usr/share/applications/`:
   ```bash
   sudo nano /usr/share/applications/openinyazi.desktop
   ```

2. Add the following content to the file:
   ```ini
   [Desktop Entry]
   Name=Open in Yazi
   Exec=/home/riskirills/openinyazi.sh %U
   Terminal=false
   Type=Application
   MimeType=inode/directory;
   Icon=folder
   ```
   Replace `/home/riskirills/openinyazi.sh` with the actual path to your script.

### **2. Update the MIME Database**
After saving the `.desktop` file, update the MIME database to make the system recognize the new entry:
```bash
sudo update-desktop-database /usr/share/applications
```

### **3. Set the System-Wide Default File Manager**
Now, set the new `.desktop` entry as the system-wide default handler for directories:

1. Use `xdg-mime` to associate directories with the new entry:
   ```bash
   xdg-mime default openinyazi.desktop inode/directory
   ```

2. Confirm the association:
   ```bash
   xdg-mime query default inode/directory
   ```
   This should return `openinyazi.desktop`.

---

## OpenVPN Setup

### Configuration Files

1. Create the necessary OpenVPN configuration files:
   ```bash
   sudo touch /etc/openvpn/client.conf
   sudo touch /etc/openvpn/auth.txt
   ```

2. Open `/etc/openvpn/client.conf` and add your OpenVPN configuration:
   ```bash
   sudo nvim /etc/openvpn/client.conf
   ```

3. Edit `/etc/openvpn/auth.txt` to include your credentials:
   ```
   username
   password
   ```

### Systemd Service Configuration

1. Edit the OpenVPN client service:
   ```bash
   sudo systemctl edit openvpn-client@client.service
   ```

2. Add the following lines to the file:
   ```
   [Service]
   ExecStart=
   ExecStart=/usr/bin/openvpn --suppress-timestamps --nobind --config /etc/openvpn/client.conf
   ```

### Enable and Start OpenVPN Service

Run the following commands:
```bash
sudo systemctl daemon-reload
sudo systemctl enable openvpn-client@client.service
sudo systemctl start openvpn-client@client.service
```

---

### Run Linux Utility by Chris Titus Tech

To install gaming dependencies (including Steam), VSCodium, QEMU, VirtManager, and more, run:
```bash
curl -fsSL https://christitus.com/linux | sh
```

---

### Additional Software

- **LibreOffice**:
  ```bash
  sudo pacman -S libreoffice
  ```

- **Gimp, Inkscape, Thunderbird**:
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

### Flatpak Software

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