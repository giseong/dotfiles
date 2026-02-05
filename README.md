# Dotfiles

Personal dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). Supports macOS (Apple Silicon) and Arch Linux (CachyOS).

## Quick Start

```bash
# Clone the repository
git clone https://github.com/<username>/dotfiles.git ~/.dotfiles

# Run the install script
cd ~/.dotfiles
./install.sh
```

The install script will:
- Detect your OS (macOS or Arch Linux only)
- Install required packages via Homebrew or pacman/yay
- Apply dotfiles using stow
- Set zsh as the default shell
- Optionally install development tools (pyenv, nvm)

## Manual Installation

```bash
# Install a single package
stow <package>

# Remove a package
stow -D <package>
```

The `.stowrc` file enables `--dotfiles` mode, which converts `dot-` prefixes to `.` when creating symlinks.

OS-specific Ghostty packages:
- macOS: `stow ghostty-macos`
- Arch Linux: `stow ghostty-linux`

Git profile selection:
- Work email: `stow git-work`
- Personal email: `stow git-personal`
- These packages populate `~/.gitconfig-local`

OpenCode profile selection:
- Work: `stow opencode-work`
- Personal: `stow opencode-personal`
- These packages populate `~/.config/opencode/`

## Packages

| Package | Description |
|---------|-------------|
| `zsh` | Zsh config with Zinit, Oh-my-Posh prompt |
| `tmux` | Tmux with TPM, Catppuccin theme, Ctrl-A prefix |
| `nvim` | LazyVim-based Neovim setup |
| `git` | Git config with delta pager, aliases |
| `ghostty-macos` | Ghostty terminal config (macOS) |
| `ghostty-linux` | Ghostty terminal config (Linux) |
| `wezterm` | WezTerm terminal config (Lua) |
| `opencode-personal` | OpenCode config (personal) |
| `opencode-work` | OpenCode config (work) |
| `bin` | Custom scripts |
| `fabric` | Fabric AI patterns |
| `editorconfig` | Cross-editor formatting rules |

## Requirements

Installed automatically by `install.sh`:

- git, stow, zsh, tmux, neovim
- fzf, zoxide, eza, bat, thefuck
- oh-my-posh, zinit
- opencode

## Theme

Catppuccin is used across all tools:
- **Dark mode**: Catppuccin Mocha
- **Light mode**: Catppuccin Latte

Theme follows system appearance automatically.
