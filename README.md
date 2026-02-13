# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

- Supported platforms: macOS (Apple Silicon) and Arch Linux (CachyOS)
- Stow mode: `.stowrc` enables `--dotfiles`, so `dot-*` files are linked as hidden files in `~/`

## Quick Start

```bash
git clone https://github.com/<username>/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

## Before `init`

Before running your first OpenCode `init` flow, run `./install.sh` once so Superpowers is installed and linked:

- Plugin: `~/.config/opencode/plugins/superpowers.js`
- Skills: `~/.config/opencode/skills/superpowers`

## What `install.sh` Does

The bootstrap script runs this flow:

1. Detect OS (`macos` or Arch-based Linux with `pacman`)
2. Install core packages from manifests
3. Install OpenCode (if available for the platform)
4. Offer optional `oh-my-opencode` installation when OpenCode config exists
5. Ensure Zinit is installed
6. Apply Stow packages
7. Prompt for profile overlays:
   - Git: `git-work` or `git-personal`
   - OpenCode: `opencode-work` or `opencode-personal`
8. Install or update Superpowers and refresh plugin/skills symlinks
9. Set `zsh` as the default shell
10. Prompt for optional package groups: CLI, GUI, dev, work, media

## Repository Layout

Top-level Stow packages:

| Package | Scope |
|---|---|
| `zsh`, `tmux`, `nvim`, `git`, `editorconfig`, `bin`, `fabric` | Cross-platform |
| `ghostty-macos`, `ghostty-linux` | OS-specific overlays |
| `git-work`, `git-personal` | `~/.gitconfig-local` profile overlay |
| `opencode-work`, `opencode-personal` | `~/.config/opencode/` profile overlay |

Manifest layout:

- macOS: `manifests/macos/*.brewfile`
- Arch: `manifests/arch/*.pacman` and `manifests/arch/*.aur`

## Manual Stow Usage

```bash
# apply one package
stow <package>

# remove one package
stow -D <package>
```

Common profile packages:

- Ghostty: `ghostty-macos` or `ghostty-linux`
- Git profile: `git-work` or `git-personal`
- OpenCode profile: `opencode-work` or `opencode-personal`

## Manifest Groups Used by `install.sh`

Always installed:

- macOS: `manifests/macos/core.brewfile`
- Arch: `manifests/arch/core.pacman`, `manifests/arch/core.aur`

Optional prompted groups:

- CLI extras: `manifests/macos/cli.brewfile` or `manifests/arch/cli.*`
- Default GUI apps: `manifests/macos/gui.brewfile` or `manifests/arch/gui.*`
- Dev tools: `manifests/macos/dev.brewfile` or `manifests/arch/dev.*`
- Work apps: `manifests/macos/work.brewfile` or `manifests/arch/work.*`
- Media/design apps: `manifests/macos/media.brewfile` or `manifests/arch/media.*`

## Verification

There is no centralized CI for this repo. Verify per changed scope:

```bash
# re-apply touched package
stow <modified-package>

# installer syntax check
bash -n install.sh

# package updater syntax check
bash -n bin/dot-local/bin/update_packages

# run updater
./bin/dot-local/bin/update_packages

# optional: inspect Homebrew core manifest
brew bundle list --file=manifests/macos/core.brewfile
```

## Theme

Catppuccin is used across tools:

- Dark: Mocha
- Light: Latte
