# Dotfiles

Personal macOS dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/).

- Supported platform: macOS (Apple Silicon)
- Stow mode: `.stowrc` enables `--dotfiles`, so `dot-*` files are linked as hidden files in `~/`

## Quick Start

```bash
git clone https://github.com/<username>/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

## What `install.sh` Does

The bootstrap script runs this flow:

1. Verify the host is macOS
2. Install Homebrew if needed
3. Install core packages from `manifests/macos/core.brewfile`
4. Ensure Zinit is installed
5. Apply Stow packages
6. Prompt for profile overlays:
   - Git: `git-work` or `git-personal`
7. Set `zsh` as the default shell
8. Prompt for optional Homebrew package groups: CLI, GUI, dev, work, media

## Repository Layout

Top-level Stow packages:

| Package | Scope |
| --- | --- |
| `zsh`, `tmux`, `nvim`, `git`, `editorconfig` | Base shell, editor, and Git configuration |
| `ghostty` | Ghostty terminal configuration |
| `git-work`, `git-personal` | `~/.gitconfig-local` profile overlay |

Supporting directories:

- `manifests/macos/`: Homebrew Bundle manifests grouped by `core`, `cli`, `gui`, `dev`, `work`, `media`

## Manual Stow Usage

```bash
# apply one package
stow <package>

# remove one package
stow -D <package>
```

Common profile packages:

- Ghostty: `ghostty`
- Git profile: `git-work` or `git-personal`

## Manifest Groups Used by `install.sh`

Always installed:

- `manifests/macos/core.brewfile`

Optional prompted groups:

- `manifests/macos/cli.brewfile`
- `manifests/macos/gui.brewfile`
- `manifests/macos/dev.brewfile`
- `manifests/macos/work.brewfile`
- `manifests/macos/media.brewfile`

## Verification

There is no centralized CI for this repo. Verify per changed scope:

```bash
# re-apply touched package
stow <modified-package>

# installer syntax check
bash -n install.sh

# package updater syntax check
bash -n update_packages.sh

# dry-run core packages
stow -n -v ghostty
stow -n -v zsh
stow -n -v git

# inspect Homebrew manifests
brew bundle list --file=manifests/macos/core.brewfile

# run updater
./update_packages.sh
```

## Theme

Catppuccin is used across tools:

- Dark: Mocha
- Light: Latte
