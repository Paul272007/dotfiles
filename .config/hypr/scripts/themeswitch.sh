#!/bin/bash

THEME_DIR="$HOME/.config/hypr/themes"
CURRENT_THEME_FILE="$THEME_DIR/current_theme.conf"
WAYBAR_CSS="$HOME/.config/waybar/style.css"
FASTFETCH_CONFIG="$HOME/.config/fastfetch/config.jsonc"
ROFI_COLORS="$HOME/.config/rofi/colors.rasi"

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
# We suppose each theme folder has the required files
ln -sf "$THEME_DIR/$THEME_NAME/theme.conf" "$CURRENT_THEME_FILE"
# Change AGS colors
ln -sf "$THEME_DIR/$THEME_NAME/waybar.css" "$WAYBAR_CSS"
# Change fastfetch configuration
ln -sf "$THEME_DIR/$THEME_NAME/config.jsonc" "$FASTFETCH_CONFIG"
# Change rofi colors
ln -sf "$THEME_DIR/$THEME_NAME/rofi_colors.rasi" "$ROFI_COLORS"

# 3. Change background using swww
# We search any image called wall.?
WALLPAPER=$(find "$THEME_DIR/$THEME_NAME" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | head -n 1)

if [ -f "$WALLPAPER" ]; then
  swww img "$WALLPAPER" --transition-type center --transition-step 90 --transition-fps 60 &>/dev/null
fi

# 4. Reload hyprland to apply changes
hyprctl reload

# 5. Reload AGS colors
ags -r "App.resetCss(); App.applyCss('./style.css');" &>/dev/null

notify-send "Thème appliqué" "Style : $THEME_NAME"
