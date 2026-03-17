#!/bin/bash

# Compte les mises à jour Pacman et AUR
updates_arch=$(checkupdates 2>/dev/null | wc -l)
updates_aur=$(yay -Qum 2>/dev/null | wc -l)

updates=$((updates_arch + updates_aur))

if [ "$updates" -gt 0 ]; then
  echo "{\"text\": \"<span color='#F87C63' size='120%'>󰚰</span> $updates\", \"tooltip\": \"$updates mises à jour disponibles\", \"class\": \"pending\"}"
else
  echo "{\"text\": \"<span color='#9ece6a' size='120%'>󰚰</span>\", \"tooltip\": \"Système à jour\", \"class\": \"updated\"}"
fi
