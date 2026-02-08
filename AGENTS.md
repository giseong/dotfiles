# AGENTS.md

Personal dotfiles managed with GNU Stow.
Targets: macOS (Apple Silicon) and Arch Linux (CachyOS).

Keep changes minimal and local to existing Stow packages.
Do not add new top-level directories unless explicitly requested.

## Repository Layout

Stow packages live at repo root. `.stowrc` uses `--dotfiles`, so `dot-*` files
symlink as hidden files under `~/`.

| Package | Scope |
|---|---|
| `zsh`, `tmux`, `nvim`, `git`, `editorconfig`, `bin`, `fabric` | Cross-platform |
| `ghostty-macos`, `ghostty-linux` | OS-specific overlays |
| `git-work`, `git-personal` | `~/.gitconfig-local` profile overlay |
| `opencode-work`, `opencode-personal` | `~/.config/opencode/` profile overlay |

Manifest layout (package installation inputs):
- `manifests/macos/*.brewfile`
- `manifests/arch/*.pacman`
- `manifests/arch/*.aur`

Package directory pattern:
- XDG config: `<package>/dot-config/<tool>/...`
- Home dotfiles: `<package>/dot-<name>`

Theme direction: Catppuccin everywhere (Mocha = dark, Latte = light).

## Build, Lint, Test, Verify

No CI and no centralized test runner.
Verification is command-based and manual for changed scope.

Core commands:
```bash
./install.sh
stow <package>
stow -D <package>
./bin/dot-local/bin/update_packages
```

### Single-change verification (closest thing to single test)

1. Re-apply only the touched package: `stow <modified-package>`
2. Run the affected command/tool manually (script, shell startup, app config)
3. For installer edits, run syntax check and safe-environment dry validation

Useful checks:
```bash
bash -n install.sh
bash -n bin/dot-local/bin/update_packages
brew bundle list --file=manifests/macos/core.brewfile
```

Arch manifest sanity (format check by inspection):
- One package per line
- `#` for comments
- No commas/quotes

## Code Style

Source of truth: `editorconfig/dot-editorconfig`.

Global defaults:
- UTF-8, LF, final newline
- Trim trailing whitespace (except Markdown)

Indentation rules:
- Default: 4 spaces
- Shell/Lua/JSON/YAML/Markdown: 2 spaces
- Go/C/C++/Makefile/Git config: tabs (width 4)

### Bash (`install.sh`, `bin/dot-local/bin/update_packages`)

- Shebang: `#!/usr/bin/env bash`
- Start with `set -euo pipefail`
- Keep colored logger helpers (`log_info`, `log_success`, `log_warn`, `log_error`)
- Keep numbered/bannered sections intact
- Prefer explicit OS branching with `case "$(uname -s)"`
- Use `|| true` only for intentionally non-critical paths
- Keep prompts group-based (avoid hardcoded app-name prompts)

### Zsh (`zsh/dot-zprofile`, `zsh/dot-zshrc`)

- Preserve existing section order and banner comments
- `dot-zprofile`: OS detection, PATH/runtime setup (pyenv, nvm, Go, Android)
- `dot-zshrc`: appearance/theme detection, tmux, zinit plugins, prompt, aliases
- Keep OS branches explicit (`IS_MAC` checks)

### Lua / Neovim

Neovim is LazyVim-based with Lazy.nvim.

Formatting config: `nvim/dot-config/nvim/stylua.toml`
- 2-space indent
- 120 column width

Conventions:
- Keep `require("...")` style imports at top when practical
- Follow plugin spec structure in `nvim/dot-config/nvim/lua/plugins/*.lua`
- Keep config modular (`lua/config/*.lua`, `lua/plugins/*.lua`)

### Tmux (`tmux/dot-tmux.conf`)

- Keep section banners
- Prefix remains `Ctrl-a`
- Vi-mode key behavior stays enabled
- Catppuccin theme settings load before status customization
- TPM plugin block remains grouped near end

### Ghostty (`ghostty-macos`, `ghostty-linux`)

- Key-value config format (`key = value`)
- Keep shared structure consistent across OS variants
- macOS-only `macos-*` options must stay macOS-only

### Python (`bin/dot-local/bin/extract_wisdom_kr`)

- Standard library style is preferred
- Use explicit subprocess error handling
- Surface stderr on failure (`subprocess.CalledProcessError`)
- 4-space indentation per EditorConfig

### Git config (`git/dot-gitconfig`)

- Preserve tab indentation
- Keep include layering via `~/.gitconfig-local`
- Preserve delta pager setup and existing aliases/defaults
- Avoid broad reformatting of git config blocks

## Naming Conventions

- Stow package directories: lowercase kebab-like names (`ghostty-macos`)
- Dotfiles in packages: `dot-*`
- Scripts: `snake_case`
- Manifest groups: `core`, `cli`, `gui`, `dev`, `work`, `media`
- macOS manifests: `<group>.brewfile`
- Arch manifests: `<group>.pacman` and `<group>.aur`

## Error Handling Expectations

- Bash: fail fast by default; no silent failures except intentional `|| true`
- Installer functions should validate input files before running package managers
- Python scripts should catch and report command execution failures clearly

## Dependency Policy

- Prefer existing tools already in manifests
- Avoid adding dependencies without clear need
- Keep package-manager-specific entries in the proper manifest type

## External Agent Rules

No Cursor or Copilot instruction files are present:
- `.cursor/rules/` (not found)
- `.cursorrules` (not found)
- `.github/copilot-instructions.md` (not found)

If any of these are added later, update this file and treat them as higher-priority guidance.
