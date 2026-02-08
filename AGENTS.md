# AGENTS.md

Personal dotfiles managed with GNU Stow.
Targets macOS (Apple Silicon) and Arch Linux (CachyOS).

**Ground rules**: Keep changes minimal. Edit within existing Stow packages.
Do not add new top-level directories without explicit approval.

## Repository Layout

Stow packages live at the repo root. `.stowrc` enables `--dotfiles` so
files named `dot-*` are symlinked as `.*` under `~/`.

| Package | Targets |
|---------|---------|
| `zsh`, `tmux`, `nvim`, `git`, `editorconfig`, `bin`, `wezterm`, `fabric` | All platforms |
| `ghostty-macos`, `ghostty-linux` | OS-specific |
| `git-work`, `git-personal` | Profile overlay (`~/.gitconfig-local`) |
| `opencode-work`, `opencode-personal` | Profile overlay (`~/.config/opencode/`) |

Package directory pattern: `<pkg>/dot-config/<tool>/...` for XDG configs,
or `<pkg>/dot-<filename>` for home-directory dotfiles.

Theme: **Catppuccin** everywhere (Mocha = dark, Latte = light).
Neovim: LazyVim-based (`lazy.nvim`). Formatter: `stylua`.

## Commands

No build/test/lint pipeline. No CI.

```bash
./install.sh                           # Full bootstrap (detects OS, installs pkgs, stows)
stow <package>                         # Apply one package
stow -D <package>                      # Remove one package
./bin/dot-local/bin/update_packages    # Update system + dev tools
```

Profile-specific stowing:
```bash
stow ghostty-macos   # or ghostty-linux
stow git-work        # or git-personal
stow opencode-work   # or opencode-personal
```

### Running a Single Test

No test runner. Verify changes by:
1. `stow <modified-package>` — confirm no stow conflicts
2. Run affected scripts manually and check output
3. For `install.sh` edits — test in a safe/disposable environment

## Code Style

### EditorConfig (`editorconfig/dot-editorconfig`)

| Scope | Style | Size |
|-------|-------|------|
| Default | Spaces | 4 |
| Shell (`.sh`, `.bash`, `.zsh`) | Spaces | 2 |
| Web/JSON/YAML/Lua/Markdown | Spaces | 2 |
| Python | Spaces | 4 |
| Go / C / C++ / Makefile / Git config | Tabs | 4 |

All files: LF line endings, UTF-8, trim trailing whitespace, final newline.
Exception: Markdown does not trim trailing whitespace.

### Lua (Neovim, WezTerm)

Config: `nvim/dot-config/nvim/stylua.toml` — 2-space indent, 120 col width.

- Use `require("...")` at top of file
- Follow LazyVim plugin spec conventions in `lua/plugins/*.lua`
- WezTerm config uses `wezterm.config_builder()` pattern

### Shell Scripts (Bash)

Files: `install.sh`, `bin/dot-local/bin/update_packages`

- Shebang: `#!/usr/bin/env bash`
- Always start with `set -euo pipefail`
- Define colored log helpers: `log_info`, `log_success`, `log_warn`, `log_error`
- Use `=====` banner comments to separate numbered sections
- OS detection via `uname -s` with case statement
- Guard non-critical commands with `|| true` or explicit logging
- 2-space indentation (per editorconfig)

### Zsh Configuration

Files: `zsh/dot-zprofile`, `zsh/dot-zshrc`

- Numbered sections separated by `# ---` banner comments
- `dot-zprofile`: OS detection, PATH, runtime setup (pyenv, nvm, Go, Android)
- `dot-zshrc`: appearance detection, tmux, Zinit plugins, prompt, aliases, history
- Preserve section ordering — do not rearrange
- OS-specific behavior via explicit `[[ "$IS_MAC" == true ]]` conditionals

### Tmux Configuration (`tmux/dot-tmux.conf`)

- Numbered sections with `# =====` banner comments
- Prefix: `Ctrl-a`, vi mode keys
- Catppuccin theme loads before status line customization
- Plugin list (TPM) grouped together at end

### Ghostty Configuration

- macOS config has `macos-*` specific options; Linux config does not
- Shared pattern: term, theme, font, window, cursor, shell-integration
- Key-value format, no quoting needed except font family

### Python Scripts

File: `bin/dot-local/bin/extract_wisdom_kr`

- Standard library only (`sys`, `subprocess`, `re`)
- `subprocess.run(..., shell=True, check=True, capture_output=True, text=True)`
- Catch `subprocess.CalledProcessError`, print `e.stderr`
- 4-space indentation (per editorconfig)

### Git Configuration (`git/dot-gitconfig`)

- Tab indentation (per editorconfig)
- Uses delta as pager with side-by-side diffs
- Includes `~/.gitconfig-local` for profile-specific identity
- Pull default: rebase. Push default: simple.
- Do not reformat without reason

## Naming Conventions

- Stow package dirs: lowercase (e.g., `nvim`, `tmux`, `ghostty-macos`)
- Dotfiles inside packages: `dot-*` prefix (stowed as `.*`)
- Scripts: `snake_case` (e.g., `update_packages`, `extract_wisdom_kr`)
- Lua modules: `require("...")` imports at top

## Error Handling

- Bash: fail fast via `set -euo pipefail`; use `|| true` only for non-critical ops
- Python: catch `subprocess.CalledProcessError` and surface stderr

## Dependencies

- Prefer standard library in all scripts
- Do not add new external dependencies without clear justification

## External Rules

No `.cursor/rules/`, `.cursorrules`, or `.github/copilot-instructions.md` exist.
Update this section if any are added.
