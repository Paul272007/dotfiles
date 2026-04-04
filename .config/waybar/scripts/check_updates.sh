#!/bin/bash

# Compte les mises à jour Pacman et AUR
updates_arch=$(checkupdates 2>/dev/null | wc -l)
updates_aur=$(yay -Qum 2>/dev/null | wc -l)

updates=$((updates_arch + updates_aur))

COLOR=$("$HOME/.local/bin/get-color")

if [ "$updates" -gt 0 ]; then
  echo "{\"text\": \"<span color='$COLOR' size='120%'>󰚰</span> $updates\", \"tooltip\": \"$updates mises à jour disponibles\", \"class\": \"pending\"}"
else
  echo "{\"text\": \"<span color='$COLOR' size='120%'>󰚰</span> OK\", \"tooltip\": \"Système à jour\", \"class\": \"updated\"}"
fi
