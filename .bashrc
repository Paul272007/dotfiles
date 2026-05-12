# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# History
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000

shopt -s histappend   # append to the history file, don't overwrite it
shopt -s checkwinsize # check the window size after each command and update the values of LINES and COLUMNS.
shopt -s globstar     # pattern "**" used in a pathname expansion context will match all files and zero or more directories and subdirectories.

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

source_if_exists() {
  if [ -f "$1" ]; then
    source "$1"
  else
    echo "Error: file $1 does not exist"
  fi
}

# Load customized configuration
source_if_exists "$HOME/.config/rc/rc"
