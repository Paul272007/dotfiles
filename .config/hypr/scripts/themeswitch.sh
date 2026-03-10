#!/bin/bash

THEME_DIR="$HOME/.config/hypr/themes"
CURRENT_THEME_FILE="$HOME/.config/hypr/themes/current_theme.conf"
AGS_COLORS="$HOME/.config/hypr/themes/current_theme_ags.css"

if [ -z "$1" ]; then
  echo "Usage: ./themeswitch.sh <theme>"
  exit 1
fi

THEME_NAME="$1"

# 1. Check if theme exists
if [ ! -d "$THEME_DIR/$THEME_NAME" ]; then
  notify-send "Erreur" "Le thème $THEME_NAME n'existe pas."
  exit 1
fi

# 2. Update symlink for the hyprland config
# We suppose each theme folder has a 'theme.conf' file
ln -sf "$THEME_DIR/$THEME_NAME/theme.conf" "$CURRENT_THEME_FILE"
ln -sf "$THEME_DIR/$THEME_NAME/ags_colors.css" "$AGS_COLORS"

# 3. Change background using swww
# We search any image called wall.?
WALLPAPER=$(find "$THEME_DIR/$THEME_NAME" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | head -n 1)

if [ -f "$WALLPAPER" ]; then
  swww img "$WALLPAPER" --transition-type center --transition-step 90 --transition-fps 60
fi

# 4. Reload hyprland to apply changes
hyprctl reload

# 5. Reload AGS colors
ags -r "App.resetCss(); App.applyCss('./style.css');"

notify-send "Thème appliqué" "Style : $THEME_NAME"
