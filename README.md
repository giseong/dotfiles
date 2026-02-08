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
- Install core packages from manifests (`manifests/macos/core.brewfile` on macOS, `manifests/arch/core.*` on Arch)
- Install OpenCode and optionally oh-my-opencode
- Apply stow packages and prompt for Git / OpenCode profile selection
- Set `zsh` as the default shell
- Prompt for optional package groups on both platforms (CLI, GUI, dev, work, media)

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
| `opencode-work` | Work OpenCode profile |
| `opencode-personal` | Personal OpenCode profile |
| `fabric` | Fabric AI patterns |
| `editorconfig` | Cross-editor formatting rules |
| `bin` | User scripts (`~/.local/bin`) |

## Installed by `install.sh`

macOS (Homebrew manifests):

Core formulae (both platforms):
- `git`, `git-delta`, `stow`, `zsh`, `tmux`, `neovim`
- `fzf`, `zoxide`, `eza`, `bat`, `thefuck`, `gh`
- `fd`, `ripgrep`
- `oh-my-posh`, `zinit`

macOS optional CLI extras (formulae): maintained in `manifests/macos/cli.brewfile`

macOS optional bootstrap essentials (formulae): maintained in `manifests/macos/cli.brewfile`

macOS optional default GUI casks:
- maintained in `manifests/macos/gui.brewfile`

macOS optional groups (prompted):
- Dev tools group (`manifests/macos/dev.brewfile`)
- Work apps group (`manifests/macos/work.brewfile`)
- Media and design apps group (`manifests/macos/media.brewfile`)

macOS manifests used by `install.sh`:
- `manifests/macos/core.brewfile` (always-installed core packages)
- `manifests/macos/cli.brewfile`, `manifests/macos/gui.brewfile`, `manifests/macos/dev.brewfile`, `manifests/macos/work.brewfile`, `manifests/macos/media.brewfile` (optional prompted groups)

Arch manifests used by `install.sh`:
- `manifests/arch/core.pacman`, `manifests/arch/core.aur` (always-installed core packages)
- `manifests/arch/cli.pacman`, `manifests/arch/cli.aur` (optional CLI extras group)
- `manifests/arch/gui.pacman`, `manifests/arch/gui.aur` (optional default GUI apps group)
- `manifests/arch/dev.pacman`, `manifests/arch/dev.aur` (optional dev tools group)
- `manifests/arch/work.pacman`, `manifests/arch/work.aur` (optional work apps group)
- `manifests/arch/media.pacman`, `manifests/arch/media.aur` (optional media and design apps group)

Additional behavior:
- Installs `opencode` when available
- Offers optional `oh-my-opencode` installer when OpenCode config exists

## Theme

Catppuccin is used across tools:
- Dark: Mocha
- Light: Latte
