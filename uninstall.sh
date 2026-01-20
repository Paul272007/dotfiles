#!/bin/bash

echo "Deleting symbolic links..."
cd "$HOME/dotfiles" && stow -D .
echo "Finished"
echo "The configuration files still exist in the directory ~/dotfiles. You can delete them all by running rm -rf ~/dotfiles"
