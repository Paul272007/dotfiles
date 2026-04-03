# Dotfiles - la configuration centralisée

## Prérequis

- `Git`
- `Curl`
- `Stow`
- `Ghostty`
- `Starship`
- `Zoxide`
- `Neovim`
- `ZSH`
- `Yazi`
- `Fastfetch`
- `Hyprland`
- `Waybar`
- `Rofi`
- `Awww`
- `Hyprlock`
- `Batcat`
- `Fastfetch`
- `zsh-autosuggestions`
- `zsh-syntax-highlighting`
- `Apple` cursor style

## Optionnel

- `Homebrew`
- `NVM` + `NPM` + `Node`
- `Clang`
- `GitHub-CLI`

## Structure des fichiers de configuration

`dotfiles`

- `.config/` = la configuration de chaque application.
  - `ghostty/` = configuration de `ghostty`.
    - `config`
  - `nvim/` = configuration de `neovim`.
    - `...`
  - `rc/` = configuration de shell personnalisée.
    - `aliases` = définition des alias de commandes.
    - `envs` = définition des variables d'environnement.
    - `functions` = définition de fonctions supplémentaires pour le shell.
    - `init` = initialise et lance tous les services du shell.
    - `rc` = source tous les fichiers précédents.
  - `zsh/` = contient des configuration supplémentaires pour `zsh`.
    - `plugins/` = plugins `zsh`.
  - `starship.toml` = configuration de `starship`.
- `.git/` = pour le dépôt git. Ignoré par `stow`.
  - `...`
- `.bashrc` = configuration de `bash`.
- `.clang-format` = configuration du formatage `clang` pour tous les éditeurs de code.
- `.gdbinit` = configuration de `GDB`.
- `.gitconfig` = configuration de `git`.
- `.gitignore` = pour le dépôt git. Ignoré par `stow`.
- `.stow-local-ignore` = contient tous les fichiers ignorés par `stow`.
- `.zshrc` = configuration de `zsh`.
- `README.md` = README du dépôt. Ignoré par `stow`.
