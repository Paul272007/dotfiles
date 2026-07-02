#!/usr/bin/bash

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
  local teal="#7aaa90"        # Mode commande
  local yellow="#d4a85a"      # Mode copy

  local bg1="#8faa74"         # Vert
  local bg2="#344034"         # Vert plus foncé
  local bg3="#3b423c"         # Vert-Gris (numéro onglets inactifs)
  local bg4="#1a1c1a"         # Marron foncé (onglets inactifs)
  local bg5="#4b524c"         # Marron très clair (numéro onglet actif)
  local bg6="#2a2c2a"         # Marron clair (onglet actif)

  local fg1="#16120e"         # Texte sur le orange
  local fg2="#e0d0ba"         # Texte sur le marron
  local fg3="#c8b89a"         # Texte sur le transparent / marron foncé

  # Separators
  local sep_right=""
  local sep_left=""
  # local sub_sep=""

  # --- Global config
  tmux set-environment -g FZF_DEFAULT_OPTS "--color=pointer:${bg1},marker:${bg1},bg+:${bg2},fg+:${fg2},prompt:${bg1},info:${fg3}"
  tmux set-option -g status-style "bg=${transparent},fg=${transparent}"
  tmux set-option -g mode-style "bg=${bg1},fg=${fg1}"
  tmux set-option -g message-style "bg=${bg1},fg=${fg1}"
  tmux set-option -g message-format "#[bg=${bg1},fg=${fg1}]  #{message} #[bg=${transparent},fg=${bg1}]${sep_right}"

  tmux set-option -g copy-mode-match-style "bg=${bg2},fg=${fg2}"
  tmux set-option -g copy-mode-current-match-style "bg=${bg1},fg=${fg1},bold"

  tmux set-option -g window-status-separator " "
  tmux set-option -g status-justify absolute-centre
  tmux set-option -g clock-mode-colour "${bg1}"

  # --- Borders
  tmux set-option -g pane-border-style "fg=${fg3}"
  tmux set-option -g pane-active-border-style "fg=${fg3}"
  tmux set-option -g popup-border-style "fg=${fg3}"

  # --- Left
  local mode_bg="#{?client_prefix,${teal},#{?pane_in_mode,${yellow},${bg1}}}"
  local mode_text="#{?client_prefix,WAIT,#{?pane_in_mode,COPY,TMUX}}"

  local status_left="#[bg=${mode_bg},fg=${fg1},bold]  ${mode_text} #[bg=${mode_bg},fg=${bg2}]${sep_left}"
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
  status_right="${status_right}#[bg=${bg2},fg=${mode_bg}]${sep_left}#[fg=${fg1},bg=${mode_bg},bold] 󱑒 %H:%M "

  tmux set-option -g status-right-length 100
  tmux set-option -g status-right "${status_right}"
}

main "$@"
