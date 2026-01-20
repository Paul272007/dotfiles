#!/bin/bash

# Stop on error
set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo "Warning: this installation will delete all existing configuration for tools that are used by the configuration. Back up important data before proceeding."
read -pr "Do you want to proceed with the installation ? [Y/n] " CONTINUE_CHOICE

if [[ "$CONTINUE_CHOICE" != "Y" ]]; then
  echo "Abort installation."
  exit 1
fi

echo -e "${BLUE}===== Configuration Installation =====${NC}"
echo ""

OS=$(uname -s)
DISTRO=""
DE=""
DOTFILES_DIR="$HOME/.dotfiles"

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

install_pkg() {
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

echo -e "${BLUE}[0/5] Choosing shell environment...${NC}"
while true; do
  echo "Which shell do you want to use ?"
  echo "1: zsh"
  echo "2: bash"
  read -pr "[1/2] : " SHELL_CHOICE

  # Convert to lowercase
  SHELL_CHOICE=$(echo "$SHELL_CHOICE" | tr '[:upper:]' '[:lower:]')

  case "$SHELL_CHOICE" in
  1)
    if [ "$SHELL" != /bin/zsh ]; then
      echo "Changing shell to zsh..."
      chsh -s /bin/zsh "$USER"
    fi
    if ! command -v zsh &>/dev/null; then
      install_pkg zsh
    fi
    break
    ;;
  2)
    if [ "$SHELL" != /bin/bash ]; then
      echo "Changing shell to bash..."
      chsh -s /bin/bash "$USER"
    fi
    break
    ;;
  *)
    echo "Invalid option. Please type 1 or 2."
    ;;
  esac
done

# Detect system and install dependencies
# stow, git, curl
echo -e "${BLUE}[1/5] Installing dependencies...${NC}"

PACKAGES="git stow curl"

if ! command -v nvim &>/dev/null; then
  PACKAGES="$PACKAGES neovim"
fi

install_pkg "$PACKAGES"

echo -e "${BLUE}[2/5] Installing shell tools...${NC}"

# Github CLI

if ! command -v gh &>/dev/null; then
  echo "Installing Github CLI..."
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
else
  echo "Github CLI is already installed"
fi

# Ghostty

install_ghostty() {
  if [[ "$OS" == "Darwin" ]]; then
    brew install --cask ghostty || echo "Ghostty is already installed or brew had an error."

  elif [[ "$DISTRO" == "arch" ]]; then
    sudo pacman -S --noconfirm ghostty

  else
    # Debian/Ubuntu/Fedora
    if command -v brew &>/dev/null; then
      echo "Installation via Linuxbrew (recommended for Debian/Fedora)..."
      brew install ghostty
    else
      echo -e "${YELLOW}Warning : Ghostty is not in the official repos of $DISTRO.${NC}"
      echo -e "Please install Homebrew for Linux or compile it manually."
      echo -e "Link : https://ghostty.org/docs/install"
    fi
  fi
}

if ! command -v ghostty &>/dev/null; then
  echo "Installing Ghostty..."
  install_ghostty
else
  echo "Ghostty is already installed."
fi

# Starship
if ! command -v starship &>/dev/null; then
  echo "Installing Starship..."
  curl -sS https://starship.rs/install.sh | sh
else
  echo "Starship is already installed"
fi

# Zoxide
if ! command -v zoxide &>/dev/null; then
  echo "Installing Zoxide..."
  curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
else
  echo "Zoxide is already installed"
fi

# Try
if ! command -v try &>/dev/null; then
  echo "Installing Try..."
  curl -sSf https://raw.githubusercontent.com/dariuszparys/try-rs/main/install.sh | sh
else
  echo "Try is already installed"
fi

# NVM
if [ ! -d "$HOME/.nvm" ]; then
  echo "Installing NVM..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
  # \. "$HOME/.nvm/nvm.sh"
else
  echo "NVM is already installed"
fi

# ZSH Plugins
ZSH_PLUGINS="$HOME/.config/zsh/plugins"
mkdir -p "$ZSH_PLUGINS"
echo "Installing some vital ZSH plugins..."

if [ ! -d "$ZSH_PLUGINS/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "$ZSH_PLUGINS/zsh-syntax-highlighting"
fi

if [ ! -d "$ZSH_PLUGINS/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_PLUGINS/zsh-autosuggestions"
fi

echo -e "${BLUE}[3/5] Cleaning existing configuration files...${NC}"

echo "This is why backup was necessary..."

# Clean necessary configuration directories
rm -rf ~/.config/ghostty
rm -rf ~/.config/custom
rm -rf ~/.config/nvim

# Clean necessary configuration files
rm -f ~/.bashrc ~/.zshrc ~/.clang-format ~/.gitconfig ~/.local/bin/mk ~/.config/starship.toml

echo -e "${BLUE}[4/5] Installing the configuration...${NC}"

if [ ! -d "$DOTFILES_DIR" ]; then
  echo "Creating dotfiles directory and copying files..."
  mkdir -p "$DOTFILES_DIR"
  cp -r . "$DOTFILES_DIR"

  # remove non configuration files
  rm -f "$DOTFILES_DIR/"{README.md,LICENSE,install.sh,uninstall.sh}
fi

# Then stow it
cd "$DOTFILES_DIR"
stow .

echo -e "${BLUE}[5/5] Changing desktop background image...${NC}"
if [[ "$OS" == "Darwin" ]]; then
  set_wallpaper "/Users/$USER/.config/rc/background.png"
elif [[ "$OS" == "Linux" ]]; then
  set_wallpaper "$HOME/.config/rc/background.png"
else
  exit 1
fi

echo -e "${GREEN}===== Configuration installed successfully! =====${NC}"
echo "Reload your terminal or your shell to see the changes."
exit 0
