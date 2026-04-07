#!/bin/bash

USAGE="Usage: set-default-theme <theme>"

if [ "$#" -ne 1 ]; then
    echo "$USAGE"
    exit 1
fi

if [ "$1" = "--help" ]; then
    echo "$USAGE"
    exit 0
fi

DEFAULT_THEME_PATH="$HOME/.config/hypr/themes/Default"
THEME_PATH="$HOME/.config/hypr/themes/$1"

if [ ! -d "$THEME_PATH" ] || [ "$1" = "Default" ]; then
    echo "Error: theme $1 does not exist"
    exit 1
fi

# -n to treat link as a file even if it points to a directory
ln -sfn "$THEME_PATH" "$DEFAULT_THEME_PATH" && echo "Default theme changed succesfully !" || exit 1