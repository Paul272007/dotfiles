#!/bin/bash

THEME_DIR="$HOME/.config/hypr/themes"

CURRENT_THEME_FILE="$THEME_DIR/current_theme.conf"
WAYBAR_CONF="$HOME/.config/waybar/config.jsonc"
WAYBAR_CSS="$HOME/.config/waybar/style.css"
FASTFETCH_CONFIG="$HOME/.config/fastfetch/config.jsonc"
ROFI_COLORS="$HOME/.config/rofi/colors.rasi"
STARSHIP_CONF="$HOME/.config/starship.toml"
SWAYNC_STYLE="$HOME/.config/swaync/style.css"

if [ -z "$1" ]; then
  echo "Usage: themeswitch <theme>"
  exit 1
fi

THEME_NAME="$1"

# 1. Check if theme exists
if [ ! -d "$THEME_DIR/$THEME_NAME" ]; then
  notify-send "Error" "The theme $THEME_NAME doesn't exist."
  exit 1
fi

# 2. Update all symlinks
# We suppose each theme folder has the required files
ln -sf "$THEME_DIR/$THEME_NAME/theme.conf" "$CURRENT_THEME_FILE"
# Change waybar
ln -sf "$THEME_DIR/$THEME_NAME/waybar.jsonc" "$WAYBAR_CONF"
ln -sf "$THEME_DIR/$THEME_NAME/waybar.css" "$WAYBAR_CSS"
# Change fastfetch configuration
ln -sf "$THEME_DIR/$THEME_NAME/fastfetch.jsonc" "$FASTFETCH_CONFIG"
# Change rofi colors
ln -sf "$THEME_DIR/$THEME_NAME/rofi_colors.rasi" "$ROFI_COLORS"
# Change starship theme
ln -sf "$THEME_DIR/$THEME_NAME/starship.toml" "$STARSHIP_CONF"
# Change swaync theme
ln -sf "$THEME_DIR/$THEME_NAME/swaync.css" "$SWAYNC_STYLE"

# 3. Change background using swww
# We search for any image called wall.{jpg,png,jpeg}
WALLPAPER=$(find "$THEME_DIR/$THEME_NAME" -type f \( -name "*.jpg" -o -name "*.png" -o -name "*.jpeg" \) | head -n 1)

if [ -f "$WALLPAPER" ]; then
  awww img "$WALLPAPER" --transition-type center --transition-step 91 --transition-fps 60 &>/dev/null
  ln -sf "$WALLPAPER" "$HOME/.cache/current_wallpaper.png"
fi

# 4. Reload hyprland to apply changes
hyprctl reload

# Store new theme in a file
echo "$THEME_NAME" >~/.cache/current_theme

# 5. Reload waybar
killall waybar
waybar &>/dev/null &

# 6. Reload swaync CSS
swaync-client -rs

notify-send "Theme applied" "Style : $THEME_NAME"

# Close rofi just in case it didn't
pkill rofi &>/dev/null
