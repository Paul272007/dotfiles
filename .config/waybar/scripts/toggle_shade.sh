#!/bin/bash

THEME=$(cat ~/.cache/current_theme)

if [ "$THEME" == "hyprland" ]; then
  COLOR="#89b4fa"
elif [[ "$THEME" == "mountain" ]]; then
  COLOR="#F87C63"
else
  COLOR="#ffffff"
fi

# Nom du shader (blue-light-filter est inclus par défaut avec hyprshade)
SHADER="blue-light-filter"

# Si l'argument est "status", on renvoie juste le JSON pour Waybar
if [ "$1" == "status" ]; then
  CURRENT=$(hyprshade current)
  if [ "$CURRENT" == "$SHADER" ]; then
    echo "{\"text\": \"<span color='$COLOR'></span> On\", \"class\": \"on\"}"
  else
    echo "{\"text\": \"<span color='$COLOR'></span> Off\", \"class\": \"off\"}"
  fi
  exit 0
fi

# Sinon, on bascule le filtre
if [ "$(hyprshade current)" == "$SHADER" ]; then
  hyprshade off
else
  hyprshade on "$SHADER"
fi

# On force Waybar à se mettre à jour (envoie un signal au module)
pkill -RTMIN+8 waybar
