#!/bin/bash

# Nom du shader (blue-light-filter est inclus par défaut avec hyprshade)
SHADER="blue-light-filter"

# Si l'argument est "status", on renvoie juste le JSON pour Waybar
if [ "$1" == "status" ]; then
  CURRENT=$(hyprshade current)
  if [ "$CURRENT" == "$SHADER" ]; then
    echo "{\"text\": \"<span color='#F87C63'></span> On\", \"class\": \"on\"}"
  else
    echo "{\"text\": \"<span color='#F87C63'></span> Off\", \"class\": \"off\"}"
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
