# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managed with GNU Stow. It contains configuration files for shell, terminal emulators, Neovim, tmux, and various development tools. The setup supports both macOS (Apple Silicon) and Linux (CachyOS).

## Installation Commands

```bash
# Install a package (creates symlinks to ~/)
stow <package>

# Example: install zsh configuration
stow zsh

# Uninstall a package
stow -D <package>
```

The `.stowrc` file configures Stow to use `--dotfiles` mode, which converts `dot-` prefixes to `.` when creating symlinks.

## Package Structure

Each directory at the root is a Stow package. Files named `dot-*` become `.*` when symlinked:
- `dot-zshrc` → `~/.zshrc`
- `dot-config/nvim/` → `~/.config/nvim/`

### Key Packages

| Package | Description |
|---------|-------------|
| `zsh/` | Zsh configuration with Zinit plugins, Oh-my-Posh prompt |
| `tmux/` | Tmux config with TPM, Catppuccin theme, Ctrl-A prefix |
| `nvim/` | LazyVim-based Neovim setup with lazy.nvim |
| `git/` | Git config with delta pager, extensive aliases |
| `ghostty/` | Ghostty terminal emulator config |
| `wezterm/` | WezTerm terminal emulator config (Lua) |
| `bin/` | Custom scripts (extract_wisdom_kr, update_packages) |
| `fabric/` | Fabric AI patterns for content extraction |
| `editorconfig/` | Cross-editor formatting rules |

## Architecture Notes

### Theme System
Catppuccin theme is used consistently across all tools:
- **Dark mode**: Catppuccin Mocha
- **Light mode**: Catppuccin Latte
- Theme selection follows system appearance (detected via `defaults read` on macOS)

### Cross-Platform Handling
The Zsh configuration (`dot-zprofile`, `dot-zshrc`) handles OS differences:
- Homebrew paths differ between macOS (`/opt/homebrew`) and Linux (`/home/linuxbrew`)
- Package managers: Pyenv, NVM are loaded conditionally
- Tmux autostart excludes certain environments (VSCode, JetBrains IDEs, SSH)

### Plugin Managers
- **Zsh**: Zinit (with turbo mode for fast startup)
- **Tmux**: TPM (auto-installs if missing)
- **Neovim**: lazy.nvim (LazyVim distribution)

### Neovim Configuration
Located in `nvim/dot-config/nvim/`:
- `init.lua` - Bootstrap lazy.nvim
- `lua/config/` - Core configuration
- `lua/plugins/` - Plugin specifications (colorscheme, lualine, obsidian, trouble, etc.)
- Includes Claude Code integration via `claude-code.nvim`

## Git Aliases (from dot-gitconfig)

Common aliases: `st` (status), `ci` (commit), `co` (checkout), `br` (branch), `lg` (pretty log), `amend` (commit --amend)
