#!/usr/bin/env bash

# Renvoyer une valeur par défaut si une option Tmux n'est pas configurée par l'utilisateur
get_tmux_option() {
  local option="$1"
  local default_value="$2"
  local option_value
  option_value=$(tmux show-option -gqv "$option")
  if [ -z "$option_value" ]; then
    echo "$default_value"
  else
    echo "$option_value"
  fi
}

main() {
  # Colors
  local transparent=default   # Transparent
  local bg1="#c8814a"         # Orange
  local bg2="#252018"         # Beige
  local bg3="#3a2c1c"         # Marron (numéro onglets inactifs)
  local bg4="#1e1812"         # Marron foncé (onglets inactifs)
  local bg5="#5b4c38"         # Marron très clair (numéro onglet actif)
  local bg6="#443521"         # Marron clair (onglet actif)
  local fg1="#16120e"         # Texte sur le orange
  local fg2="#e0d0ba"         # Texte sur le beige
  local fg3="#c8b89a"         # Texte sur le transparent

  # Separators
  local sep_right=""
  local sep_left=""
  # local sub_sep=""

  # Global config
  tmux set-option -g status-style "bg=${transparent},fg=${transparent}"

  # --- Left
  local status_left="#[bg=${bg1},fg=${fg1},bold]  TMUX #[bg=${bg1},fg=${bg2}]${sep_left}"
  status_left="${status_left}#[bg=${bg2},fg=${fg2}] 󰆍 #S #[bg=${transparent},fg=${bg2}]${sep_right} "

  tmux set-option -g status-left-length 100
  tmux set-option -g status-left "${status_left}"

  # --- Middle
  # Active tab
  local active_tab="#[bg=${transparent},fg=${bg5}]${sep_left}#[fg=${fg2},bg=${bg5},bold] #I #[bg=${bg5},fg=${bg6}]${sep_left}"
  active_tab="${active_tab}#[fg=${fg2},bg=${bg6},bold] #W #[bg=${transparent},fg=${bg6}]${sep_right}"
  tmux set-option -g window-status-current-format "$active_tab"

  # Inactive tab
  local inactive_tab="#[bg=${transparent},fg=${bg3}]${sep_left}#[fg=${fg3},bg=${bg3},bold] #I #[bg=${bg3},fg=${bg4}]${sep_left}"
  inactive_tab="${inactive_tab}#[fg=${fg3},bg=${bg4}] #W #[bg=${transparent},fg=${bg4}]${sep_right}"
  tmux set-option -g window-status-format "$inactive_tab"

  # --- Right
  local status_right="#[fg=${fg3},bg=${transparent}] #{pane_current_command} #[bg=${transparent},fg=${bg2}]${sep_left}"
  status_right="${status_right}#[bg=${bg2},fg=${fg2}] 󱘲 #(uptime -p | sed 's/up //; s/ week\?,/w/; s/ days\?,/d/; s/ hours\?,/h/; s/ minutes\?/m/') "
  status_right="${status_right}#[bg=${bg2},fg=${bg1}]${sep_left}#[fg=${fg1},bg=${bg1},bold] 󱑒 %H:%M "

  tmux set-option -g status-right-length 100
  tmux set-option -g status-right "${status_right}"
}

main "$@"
