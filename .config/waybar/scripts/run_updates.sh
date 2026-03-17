#!/bin/bash

# Remplace 'ghostty' par 'kitty' si besoin
kitty -e sh -c "yay -Syu; echo 'Mise à jour terminée. Appuyez sur une touche pour quitter.'; read -n 1"

# On envoie un signal à Waybar pour rafraîchir le module après la mise à jour
pkill -RTMIN+9 waybar
