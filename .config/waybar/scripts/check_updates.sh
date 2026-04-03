#!/bin/bash

# Compte les mises à jour Pacman et AUR
updates_arch=$(checkupdates 2>/dev/null | wc -l)
updates_aur=$(yay -Qum 2>/dev/null | wc -l)

updates=$((updates_arch + updates_aur))

THEME=$(cat ~/.cache/current_theme)

if [ "$THEME" == "hyprland" ]; then
  COLOR="#89b4fa"
elif [[ "$THEME" == "mountain" ]]; then
  COLOR="#F87C63"
else
  COLOR="#ffffff"
fi

if [ "$updates" -gt 0 ]; then
  echo "{\"text\": \"<span color='$COLOR' size='120%'>󰚰</span> $updates\", \"tooltip\": \"$updates mises à jour disponibles\", \"class\": \"pending\"}"
else
  echo "{\"text\": \"<span color='$COLOR' size='120%'>󰚰</span> OK\", \"tooltip\": \"Système à jour\", \"class\": \"updated\"}"
fi
