#!/bin/bash

COLOR=$("$HOME/.local/bin/get-color")

# SHADER="blue-light-filter"
SHADER="sweet-amber"

# Vérification de l'état actuel
# On utilise grep pour voir si le shader est présent dans la sortie de 'current'
IS_ON=$(hyprshade current | grep -q "$SHADER" && echo "true" || echo "false")

if [ "$1" == "status" ]; then
  if [ "$IS_ON" == "true" ]; then
    # On peut même changer l'icône (ex: une lune quand c'est ON)
    echo "{\"text\": \"<span size='112%' color='$COLOR'>󰛨</span> ON\", \"class\": \"on\", \"tooltip\": \"Filtre actif\"}"
  else
    echo "{\"text\": \"<span size='112%' color='$COLOR'>󰛩</span> OFF\", \"class\": \"off\", \"tooltip\": \"Filtre inactif\"}"
  fi
  exit 0
fi

# Logique de bascule (Toggle)
if [ "$IS_ON" == "true" ]; then
  hyprshade off
else
  hyprshade on "$SHADER"
fi

# Signal pour rafraîchir Waybar (RTMIN+8 correspond à ton signal: 8 dans la config)
pkill -RTMIN+8 waybar
