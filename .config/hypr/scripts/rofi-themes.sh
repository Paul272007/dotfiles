#!/bin/bash

THEME_DIR="$HOME/.config/hypr/themes"

# 1. Lister les dossiers dans le répertoire des thèmes
# On ignore les fichiers et on ne garde que les noms des dossiers
options=$(ls -d "$THEME_DIR"/*/ | xargs -n 1 basename)

# 2. Afficher Rofi (en utilisant tes couleurs déjà configurées)
selection=$(echo -e "$options" | rofi -dmenu -i -p "󱄅  Thèmes" -theme ~/.config/rofi/power.rasi)

# 3. Si une sélection est faite, appeler ton script de switch
if [ -n "$selection" ]; then
  ~/.config/hypr/scripts/themeswitch.sh "$selection"
fi
