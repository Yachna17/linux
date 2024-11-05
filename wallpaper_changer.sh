#!/bin/bash

# Directory where wallpapers are stored
WALLPAPER_DIR="$HOME/Wallpapers"

# Get a random wallpaper from the directory
WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

# Method 1: For GNOME (Ubuntu, etc.)
if [[ $XDG_CURRENT_DESKTOP == "GNOME" ]]; then
    gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER"

# Method 2: For KDE
elif [[ $XDG_CURRENT_DESKTOP == "KDE" ]]; then
    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "var allDesktops = desktops(); for (i=0; i<allDesktops.length; i++) { d = allDesktops[i]; d.wallpaperPlugin = 'org.kde.image'; d.currentConfigGroup = Array('Wallpaper', 'org.kde.image', 'General'); d.writeConfig('Image', 'file://$WALLPAPER') }"

# Method 3: Using feh (Common in Lightweight Window Managers)
elif command -v feh > /dev/null; then
    feh --bg-scale "$WALLPAPER"

# Method 4: For XFCE (Optional)
elif [[ $XDG_CURRENT_DESKTOP == "XFCE" ]]; then
    xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/image-path --set "$WALLPAPER"

else
    echo "No compatible tool found to set wallpaper."
    exit 1
fi
