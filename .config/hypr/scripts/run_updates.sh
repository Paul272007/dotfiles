#!/bin/bash

# Replace 'kitty' with 'ghostty' if preferred
kitty -e sh -c "yay -Syu; echo 'Update complete. Press any key to exit.'; read -n 1"

# Signal Waybar to refresh the updates module after updating
pkill -RTMIN+9 waybar
