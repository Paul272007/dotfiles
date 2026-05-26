#!/bin/bash

# --- Check that a theme was given and that a the given theme exists
if [ -z "$1" ]; then
  echo "Usage: themeswitch <theme>"
  exit 1
fi

THEME_DIR="$HOME/.config/hypr/themes"
THEME_NAME="$1"
if [ ! -d "$THEME_DIR/$THEME_NAME" ]; then
  notify-send "Error" "The theme $THEME_NAME doesn't exist."
  exit 1
fi

# --- Update all symlinks
HYPRLAND_CONF="$HOME/.config/hypr/hyprland/theme.lua"
QUICKSHELL_CONF="$HOME/shell/modules/Config.qml"
FASTFETCH_CONF="$HOME/.config/fastfetch/config.jsonc"
STARSHIP_CONF="$HOME/.config/starship.toml"

ln -sf "$THEME_DIR/$THEME_NAME/theme.lua" "$HYPRLAND_CONF"          # Hyprland config
ln -sf "$THEME_DIR/$THEME_NAME/ShellConfig.qml" "$QUICKSHELL_CONF"  # Change quickshell config
ln -sf "$THEME_DIR/$THEME_NAME/fastfetch.jsonc" "$FASTFETCH_CONF"   # Change fastfetch configuration
ln -sf "$THEME_DIR/$THEME_NAME/starship.toml" "$STARSHIP_CONF"      # Change starship theme

# --- Reload some applications to apply changes
hyprctl reload
killall quickshell
~/shell/run.sh &>/dev/null &

echo "$THEME_NAME" > ~/.cache/current_theme
notify-send "Theme applied" "Style : $THEME_NAME" -a MyShell
