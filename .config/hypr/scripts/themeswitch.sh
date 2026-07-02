#!/bin/bash

# --- Check that a theme was given and that a the given theme exists
if [ -z "$1" ]; then
  echo "Usage: themeswitch <theme>"
  exit 1
fi

THEME_NAME="$1"
THEME_DIR="$HOME/.config/hypr/themes/$THEME_NAME"

if [ ! -d "$THEME_DIR" ]; then
  notify-send "Error" "The theme $THEME_NAME doesn't exist."
  exit 1
fi

# --- Update all symlinks
HYPRLAND_THEME="$HOME/.config/hypr/hyprland/theme.lua"
QUICKSHELL_CONF="$HOME/shell/modules/Config.qml"
FASTFETCH_CONF="$HOME/.config/fastfetch/config.jsonc"
STARSHIP_CONF="$HOME/.config/starship.toml"
TMUX_THEME="$HOME/.config/tmux/theme.tmux"

ln -sf "$THEME_DIR/theme.lua" "$HYPRLAND_THEME"         # Hyprland config
ln -sf "$THEME_DIR/ShellConfig.qml" "$QUICKSHELL_CONF"  # Quickshell config
ln -sf "$THEME_DIR/fastfetch.jsonc" "$FASTFETCH_CONF"   # Fastfetch configuration
ln -sf "$THEME_DIR/starship.toml" "$STARSHIP_CONF"      # Starship theme
ln -sf "$THEME_DIR/theme.tmux" "$TMUX_THEME"            # TMUX theme

# --- Reload some applications to apply changes
hyprctl reload

killall quickshell
~/shell/run.sh &>/dev/null &

tmux source-file ~/.config/tmux/tmux.conf

echo "$THEME_NAME" > ~/.cache/current_theme
notify-send "Theme applied" "Style : $THEME_NAME" -a MyShell
