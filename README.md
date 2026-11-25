# Dotfiles

Centralized personal configuration managed with [GNU Stow](https://www.gnu.org/software/stow/), supporting both **Linux (Arch / Hyprland)** and **macOS**.

## Prerequisites

- **Core**: `git`, `stow`, `zsh` (or `bash`), `curl`
- **Terminal & Shell**: `ghostty` / `kitty` / `foot`, `starship`, `zoxide`, `fzf`, `eza`, `bat`, `television`, `tmux`
- **Editor**: `neovim`, `zed`
- **File Manager & System Info**: `yazi`, `fastfetch`
- **Linux / Hyprland**: `hyprland`, `hyprlock`, `hypridle`, `hyprshade`, `quickshell`, `rofi`, `wl-clipboard`, `cliphist`, `pacman-contrib`, `yay`
- **Optional**: `homebrew` (macOS), `nvm` + `node`, `clang` / `clangd`, `gh`, `delta`, `gitleaks`

## Installation

Because [`.stowrc`](.stowrc) configures `--target=~` and `--no-folding`, you can clone this repository anywhere (for example `~/Projects/dotfiles`) and run Stow without extra flags:

```bash
git clone https://github.com/Paul272007/dotfiles ~/Projects/dotfiles
cd ~/Projects/dotfiles
stow .
```

`--no-folding` keeps `~/.config` and its subdirectories as real directories so applications never write runtime state, caches, or credentials inside the repository.

### Useful Stow Commands

```bash
stow .      # Create symlinks in ~
stow -R .   # Restow (prune stale symlinks and link new files)
stow -D .   # Unstow (remove all managed symlinks from ~)
```

## Private & Machine-Specific Overrides

Never commit tokens, credentials, or host-specific settings:

- **Shell**: create `~/.config/rc/local` (automatically sourced if present, ignored by Git).
- **Git**: create `~/.gitconfig.local` (included automatically via `[include]` in `.gitconfig`).

## Local Git Hooks (CI & Auto-Restow)

Enable the versioned Git hooks once after cloning:

```bash
git config core.hooksPath .githooks
```

- `pre-commit`: runs `gitleaks` on staged changes, verifies `stow` cleanly links/unlinks in a temporary directory, and checks `zsh` / `bash` syntax.
- `post-commit`, `post-merge`, `post-checkout`: automatically runs `stow -R .` to keep `~` symlinks up to date.

## Structure

- `.config/` — Application configurations (`ghostty`, `kitty`, `foot`, `nvim`, `zed`, `tmux`, `hypr`, `rc`, `television`, `yazi`, `cava`, `clangd`, `rsync`)
- `.local/bin/` — Helper scripts (`themeswitch`, `set-default-theme`, `get-color`)
- `.githooks/` — Local Git hooks (ignored by Stow)
- `.github/workflows/` — CI checks (ignored by Stow)
- `.bashrc`, `.zshrc`, `.gitconfig`, `.clang-format`, `.gdbinit`, `.ideavimrc`, `.ignore`
- `.stowrc`, `.stow-local-ignore` — Stow behavior and ignore rules

## Helper Commands

- `themeswitch <theme>` — Switch active theme (`Mountain`, `Forest`, `Hyprland`) across Starship, Tmux, Fastfetch, and Hyprland/Quickshell
- `set-default-theme <theme>` — Set the default Hyprland theme symlink
- `get-color` — Print the current theme's accent hex color
