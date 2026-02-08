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
- Install core formulae (Homebrew or pacman/AUR)
- On macOS: install cask apps (Ghostty, fonts, VS Code, 1Password, Chrome, Alfred, Alt-Tab, Obsidian)
- Install OpenCode and optionally oh-my-opencode
- Apply stow packages and prompt for Git / OpenCode profile selection
- Set `zsh` as the default shell
- Prompt for optional package groups (dev tools, work apps, media & design)

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

Core formulae (both platforms):
- `git`, `git-delta`, `stow`, `zsh`, `tmux`, `neovim`
- `fzf`, `zoxide`, `eza`, `bat`, `thefuck`
- `fd`, `ripgrep`, `git-lfs`, `htop`, `wget`, `tree`
- `oh-my-posh`, `zinit`

macOS extras (formulae): `gh`, `lazygit`, `tlrc`, `mas`, `gnu-sed`, `editorconfig`

macOS casks (always):
- `ghostty`, `visual-studio-code`, `1password`, `google-chrome`
- `alfred`, `alt-tab`, `obsidian`
- Fonts: `JetBrainsMono Nerd Font`, `Noto Sans/Serif CJK KR`

macOS optional groups (prompted):
- Dev tools: `go`, `rust`, `node`, `yarn`, `pyenv`, `rbenv`
- Work apps: Slack, Docker Desktop, Microsoft Office, Microsoft Teams
- Media & design: IINA, Telegram, Postman, Figma

Additional behavior:
- Installs `opencode` when available
- Offers optional `oh-my-opencode` installer when OpenCode config exists

## Theme

Catppuccin is used across tools:
- Dark: Mocha
- Light: Latte
