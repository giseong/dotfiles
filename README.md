# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).
Supported platforms: macOS (Apple Silicon) and Arch Linux (CachyOS).

## Quick Start

```bash
git clone https://github.com/<username>/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

`install.sh` will:
- Detect OS (macOS or Arch-based Linux)
- Install core packages (Homebrew or pacman/AUR)
- Attempt OpenCode installation
- Apply stow packages
- Prompt for Git and OpenCode profile package selection
- Set `zsh` as the default shell
- Optionally install `pyenv` and `nvm`

## Manual Stow Usage

```bash
# apply one package
stow <package>

# remove one package
stow -D <package>
```

`.stowrc` enables `--dotfiles`, so files named `dot-*` are linked as `.*`.

Common profile-specific packages:
- Ghostty: `ghostty-macos` or `ghostty-linux`
- Git profile: `git-work` or `git-personal` (writes `~/.gitconfig-local`)
- OpenCode profile: `opencode-work` or `opencode-personal` (writes `~/.config/opencode/`)

## Packages

| Package | Description |
|---------|-------------|
| `zsh` | Zsh config (Zinit, aliases, OS-specific setup) |
| `tmux` | Tmux config and plugins |
| `nvim` | LazyVim-based Neovim config |
| `git` | Shared Git config |
| `git-work` | Work Git identity/profile overlay |
| `git-personal` | Personal Git identity/profile overlay |
| `ghostty-macos` | Ghostty config for macOS |
| `ghostty-linux` | Ghostty config for Linux |
| `wezterm` | WezTerm config |
| `opencode-work` | Work OpenCode profile |
| `opencode-personal` | Personal OpenCode profile |
| `fabric` | Fabric AI patterns |
| `editorconfig` | Cross-editor formatting rules |
| `bin` | User scripts (`~/.local/bin`) |

## Installed by `install.sh`

Core packages:
- `git`, `stow`, `zsh`, `tmux`, `neovim`
- `fzf`, `zoxide`, `eza`, `bat`, `thefuck`
- `delta`/`git-delta`, `oh-my-posh`, `zinit`

Additional behavior:
- Installs `opencode` when available
- Offers optional `oh-my-opencode` installer when OpenCode config exists

## Theme

Catppuccin is used across tools:
- Dark: Mocha
- Light: Latte
