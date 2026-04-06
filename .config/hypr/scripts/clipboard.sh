#!/bin/bash

cliphist list | rofi -dmenu -i -p " Cliphist" | cliphist decode | wl-copy
