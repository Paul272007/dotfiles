#!/bin/bash

# Options avec des icônes Nerd Fonts
lock="  Verrouiller"
suspend="󰒲  Mettre en veille"
logout="󰍃  Se déconnecter"
reboot="󰜉  Redémarrer"
shutdown="⏻  Éteindre"

# Concaténer les options et les envoyer à Rofi
options="$lock\n$suspend\n$logout\n$reboot\n$shutdown"

# Rofi va afficher ces options et retourner celle cliquée
choix=$(echo -e "$options" | rofi -dmenu -i -p "Système " -theme ~/.config/rofi/power.rasi)

# Exécuter l'action correspondante
case $choix in
"$lock")
  hyprlock
  ;;
"$suspend")
  systemctl suspend
  ;;
"$logout")
  hyprctl dispatch exit
  ;;
"$reboot")
  systemctl reboot
  ;;
"$shutdown")
  systemctl poweroff
  ;;
esac
