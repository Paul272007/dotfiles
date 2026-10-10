#!/usr/bin/env bash

# --- Check that a theme was given and that the given theme exists
if [ -z "$1" ]; then
  echo "Usage: themeswitch <theme>"
  if [ -d "$HOME/.config/hypr/themes" ]; then
    echo "Available themes:"
    ls -1 "$HOME/.config/hypr/themes" | grep -v 'Default'
  fi
  exit 1
fi

THEME_NAME="$1"
THEME_DIR="$HOME/.config/hypr/themes/$THEME_NAME"

if [ ! -d "$THEME_DIR" ]; then
  if command -v notify-send &>/dev/null; then
    notify-send "Error" "The theme $THEME_NAME doesn't exist."
  fi
  echo "Error: The theme '$THEME_NAME' does not exist in $HOME/.config/hypr/themes"
  exit 1
fi

# --- Universal symlinks (macOS & Linux)
STARSHIP_CONF="$HOME/.config/starship.toml"
TMUX_THEME="$HOME/.config/tmux/theme.tmux"
FASTFETCH_CONF="$HOME/.config/fastfetch/config.jsonc"

[ -f "$THEME_DIR/starship.toml" ] && ln -sf "$THEME_DIR/starship.toml" "$STARSHIP_CONF"
[ -f "$THEME_DIR/theme.tmux" ] && ln -sf "$THEME_DIR/theme.tmux" "$TMUX_THEME"
if [ -f "$THEME_DIR/fastfetch.jsonc" ]; then
  mkdir -p "$HOME/.config/fastfetch"
  ln -sf "$THEME_DIR/fastfetch.jsonc" "$FASTFETCH_CONF"
fi

# --- Linux / Hyprland specific
if command -v hyprctl &>/dev/null; then
  HYPRLAND_THEME="$HOME/.config/hypr/hyprland/theme.lua"
  QUICKSHELL_CONF="$HOME/shell/modules/Config.qml"

  [ -f "$THEME_DIR/theme.lua" ] && ln -sf "$THEME_DIR/theme.lua" "$HYPRLAND_THEME"
  [ -f "$THEME_DIR/ShellConfig.qml" ] && ln -sf "$THEME_DIR/ShellConfig.qml" "$QUICKSHELL_CONF"

  hyprctl reload &>/dev/null
  killall quickshell 2>/dev/null
  [ -f "$HOME/shell/run.sh" ] && "$HOME/shell/run.sh" &>/dev/null &
fi

# --- Reload Tmux if running
if tmux info &>/dev/null; then
  tmux source-file ~/.config/tmux/tmux.conf &>/dev/null
fi

mkdir -p "$HOME/.cache"
echo "$THEME_NAME" > "$HOME/.cache/current_theme"

# --- Notifications
if command -v notify-send &>/dev/null; then
  notify-send "Theme applied" "Style : $THEME_NAME" -a MyShell
elif [[ "$OSTYPE" == darwin* ]]; then
  osascript -e 'display notification "Style : '$THEME_NAME'" with title "Theme applied"' 2>/dev/null
fi

echo "Theme applied: $THEME_NAME"
