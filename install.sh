#!/bin/bash

# Stop on error
set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m'

OS=$(uname -s)
DISTRO=""
DE=""
CONFIG_SHELL=""

# Detect os, distribution and DE if Linux
echo "Detecting OS..."
if [[ "$OS" == "Darwin" ]]; then
  echo "MacOS system detected."

elif [[ "$OS" == "Linux" ]]; then
  echo "Linux system detected."
  DE="${XDG_CURRENT_DESKTOP^^}"

  if [ -f /etc/debian_version ]; then
    echo "Debian-based system detected."
    sudo apt-get update -qq
    DISTRO="Debian"

  elif [ -f /etc/redhat-release ] || [ -f /etc/fedora-release ]; then
    echo "Red Hat-based system detected."
    DISTRO="Red-Hat"

  elif [ -f /etc/arch-release ]; then
    echo "Arch-based system detected."
    DISTRO="Arch"

  elif [ -f /etc/os-release ] && grep -q "suse" /etc/os-release; then
    echo "OpenSUSE-based system detected."
    DISTRO="OpenSUSE"

  else
    echo -e "${RED}Error: Unsupported operating system.${NC}"
    exit 1
  fi

else
  echo -e "${RED}Error: Unsupported operating system.${NC}"
  exit 1
fi

# Function to change background image
set_wallpaper() {
  local IMAGE_PATH="$1"

  # If OS is macOS
  if [[ "$OS" == "Darwin" ]]; then
    osascript -e "tell application \"System Events\" to tell every desktop to set picture to \"$IMAGE_PATH\""

  # If OS is Linux
  elif [[ "$OS" == "Linux" ]]; then

    case "$DE" in
    *GNOME*)
      echo "Installation du fond d'écran pour Gnome..."
      gsettings set org.gnome.desktop.background picture-uri "file://$IMAGE_PATH"
      gsettings set org.gnome.desktop.background picture-uri-dark "file://$IMAGE_PATH"
      ;;
    *KDE*)
      echo "Installation du fond d'écran pour KDE Plasma..."
      dbus-send --session --dest=org.kde.plasmashell --type=method_call /PlasmaShell org.kde.PlasmaShell.evaluateScript "string:
            var allDesktops = desktops();
            for (var i = 0; i < allDesktops.length; i++) {
                var d = allDesktops[i];
                d.wallpaperPlugin = 'org.kde.image';
                d.currentConfigGroup = Array('Wallpaper', 'org.kde.image', 'General');
                d.writeConfig('Image', 'file://$IMAGE_PATH');
            }"
      ;;
    *XFCE*)
      echo "Installation du fond d'écran pour XFCE..."
      # XFCE nécessite souvent de boucler sur les écrans/workspaces
      xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitor0/workspace0/last-image -s "$IMAGE_PATH"
      ;;
    *)
      echo "DE Linux non supporté pour l'installation du fond d'écran."
      ;;
    esac
  fi

}

install_depending_on_os() {
  if [[ "$OS" == "Darwin" ]]; then
    brew install "$@"
  elif [[ "$DISTRO" == "Debian" ]]; then
    sudo apt-get install -y "$@"
  elif [[ "$DISTRO" == "Red-Hat" ]]; then
    sudo dnf install -y "$@"
  elif [[ "$DISTRO" == "OpenSUSE" ]]; then
    sudo zypper install -y "$@"
  fi

}

echo "Warning: this installation will delete all existing configuration for tools that are used by the configuration. Back up important data before proceeding."
read -pr "Do you want to proceed with the installation ? [Y/n] " CONTINUE_CHOICE

if [[ "$CONTINUE_CHOICE" != "Y" ]]; then
  echo "Abort installation."
  exit 1
fi

echo -e "${BLUE}===== Configuration Installation =====${NC}"
echo ""

echo -e "${BLUE}[1/5] Choosing shell environment...${NC}"
while true; do
  echo "Which shell do you want to use ?"
  echo "1: zsh"
  echo "2: bash"
  read -pr "[1/2] : " SHELL_CHOICE

  # Convert to lowercase
  SHELL_CHOICE=$(echo "$SHELL_CHOICE" | tr '[:upper:]' '[:lower:]')

  case "$SHELL_CHOICE" in
  1)
    chsh -s /bin/zsh "$USER"
    install_depending_on_os zsh
    break
    ;;
  2)
    chsh -s /bin/bash "$USER"
    install_depending_on_os bash
    break
    ;;
  *)
    echo "Invalid option. Please type 1 or 2."
    ;;
  esac
done

# Detect system and install dependencies
# stow, git, curl, gh
echo -e "${BLUE}[2/5] Installing dependencies...${NC}"

install_depending_on_os git stow curl

if [[ "$OS" == "Darwin" ]]; then
  brew install git gh stow curl

elif [[ "$DISTRO" == "Debian" ]]; then

  (type -p wget >/dev/null || (sudo apt update && sudo apt install wget -y)) &&
    sudo mkdir -p -m 755 /etc/apt/keyrings &&
    wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null &&
    sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg &&
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
    sudo apt update &&
    sudo apt install gh -y

elif [[ "$DISTRO" == "Red-Hat" ]]; then

  sudo dnf install 'dnf-command(config-manager)'
  sudo dnf config-manager --add-repo https://cli.github.com/packages/rpm/gh-cli.repo
  sudo dnf install gh --repo gh-cli

elif [[ "$DISTRO" == "Arch" ]]; then

  sudo pacman -Syu --noconfirm github-cli

elif [[ "$DISTRO" == "OpenSUSE" ]]; then

  sudo zypper addrepo https://cli.github.com/packages/rpm/gh-cli.repo
  sudo zypper ref
  sudo zypper install gh
fi

# Starship
curl -sS https://starship.rs/install.sh | sh

# Try
curl -sSf https://raw.githubusercontent.com/dariuszparys/try-rs/main/install.sh | sh

echo -e "${BLUE}[3/5] Cleaning existing configuration files...${NC}"

# Clean necessary configuration directories
rm -rf ~/.config/ghostty
rm -rf ~/.config/custom
rm -rf ~/.config/nvim

# Clean necessary configuration files
rm -f ~/.config/starship.toml

# Clean other configuration files or files that could break my config
rm -f ~/.bashrc
rm -f ~/.zshrc
rm -f ~/.clang-format
rm -f ~/.gitconfig
rm -f ~/.local/bin/mk

echo -e "${BLUE}[4/5] Installing the configuration...${NC}"
# Install configuration
cp -r . ~ # repo root (dotfiles) => ~/dotfiles

# remove non configuration files
rm -f ~/dotfiles/{README.md,LICENSE,install.sh,uninstall.sh}

# Then stow it
stow .

echo -e "${BLUE}[5/5] Changing desktop background image...${NC}"
if [[ "$OS" == "Darwin" ]]; then
  set_wallpaper "/Users/$USER/.config/custom/background.png"
elif [[ "$OS" == "Linux" ]]; then
  set_wallpaper "$HOME/.config/custom/background.png"
else
  exit 1
fi

echo -e "${GREEN}===== Configuration installed successfully! =====${NC}"
exit 0
