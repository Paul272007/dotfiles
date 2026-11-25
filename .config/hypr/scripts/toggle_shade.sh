#!/bin/bash

COLOR=$("$HOME/.local/bin/get-color")

# SHADER="blue-light-filter"
SHADER="sweet-amber"

# Check current shader state
# Use grep to see if the shader appears in 'current' output
IS_ON=$(hyprshade current | grep -q "$SHADER" && echo "true" || echo "false")

if [ "$1" == "status" ]; then
  if [ "$IS_ON" == "true" ]; then
    # Icon can be customized (e.g., moon icon when active)
    echo "{\"text\": \"<span size='112%' color='$COLOR'>󰛨</span> ON\", \"class\": \"on\", \"tooltip\": \"Filter active\"}"
  else
    echo "{\"text\": \"<span size='112%' color='$COLOR'>󰛩</span> OFF\", \"class\": \"off\", \"tooltip\": \"Filter inactive\"}"
  fi
  exit 0
fi

# Toggle logic
if [ "$IS_ON" == "true" ]; then
  hyprshade off
else
  hyprshade on "$SHADER"
fi

# Signal Waybar to refresh (RTMIN+8 matches signal: 8 in Waybar config)
pkill -RTMIN+8 waybar
