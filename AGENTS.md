# AGENTS.md
Repository: personal dotfiles managed with GNU Stow.
Platforms: macOS (Apple Silicon) and Arch Linux (CachyOS).
Audience: agentic coding tools operating in `/home/gsb/.dotfiles`.
Rule of thumb: make minimal, local edits; do not add top-level directories unless requested.

## Repository Layout
- Stow packages are top-level directories.
- `.stowrc` enables `--dotfiles`, so `dot-*` maps to hidden files in `~/`.
- Package path conventions:
  - XDG config: `<pkg>/dot-config/<tool>/...`
  - Home dotfile: `<pkg>/dot-<name>`

Primary package groups:
| Package | Purpose |
| --- | --- |
| `zsh`, `tmux`, `nvim`, `git`, `editorconfig`, `fabric` | Cross-platform base configs/scripts |
| `ghostty-macos`, `ghostty-linux` | OS-specific terminal overlays |
| `git-work`, `git-personal` | Writes `~/.gitconfig-local` overlay |
| `opencode-work`, `opencode-personal` | Writes `~/.config/opencode/` overlay |

## Build, Lint, Test, Verify
There is no centralized CI and no formal unit-test suite.
Verification is scoped to changed files/packages.

Core commands:
```bash
./install.sh
stow <package>
stow -D <package>
./update_packages.sh
```

Syntax/lint-style checks:
```bash
bash -n install.sh
bash -n update_packages.sh
stow -n -v <package>
brew bundle list --file=manifests/macos/core.brewfile
```

### Single test equivalent (most important)
Use this as the closest "single test" workflow:
1. Re-apply only the changed package: `stow <modified-package>`
2. Run file-level checks for changed artifacts (for scripts, `bash -n <file>`)
3. Reload/start the target tool and confirm no runtime errors

Quick verification map:
- `install.sh` -> `bash -n install.sh`
- `update_packages.sh` -> `bash -n update_packages.sh`
- `zsh/*` -> open a new shell and verify clean startup
- `tmux/dot-tmux.conf` -> reload config using `prefix + r`
- `nvim/*` -> start Neovim and verify plugins/config load
- macOS manifest -> `brew bundle list --file=<brewfile>`
- Arch manifest -> manual format check (one package per line, `#` comments)

## Code Style Source of Truth
Formatting baseline: `editorconfig/dot-editorconfig`.

Global defaults:
- UTF-8
- LF line endings
- final newline required
- trim trailing whitespace (except Markdown)

Indentation:
- Default: 4 spaces
- 2 spaces: shell, lua, markdown, JSON/YAML, web files
- Tabs (width 4): `Makefile`, `*.go`, `*.c`, `*.cpp`, `*.h`, `*.hpp`, `*.gitconfig`

## Language-Specific Conventions
### Bash (`install.sh`, `update_packages.sh`)
- Shebang: `#!/usr/bin/env bash`
- Start scripts with `set -euo pipefail`
- Use `snake_case` for functions and variables
- Keep logger helpers (`log_info`, `log_success`, `log_warn`, `log_error`)
- Use `|| true` only for intentional non-critical cleanup/fallback

### Zsh (`zsh/dot-zprofile`, `zsh/dot-zshrc`, `zsh/dot-config/zsh/env.shared.zsh`)
- Preserve section structure and existing comments
- Keep shared env sourcing via `env.shared.zsh`
- Preserve PID guard: `DOTFILES_ENV_SHARED_LOADED_PID`
- Avoid bash-only syntax that is incompatible with zsh

### Lua / Neovim (`nvim/dot-config/nvim/lua/**`)
- Stylua config is in `nvim/dot-config/nvim/stylua.toml`
- Use 2-space indentation and 120 column width
- Use `require("...")` module imports
- Keep modular layout (`lua/config/*`, `lua/plugins/*`)
- Preserve existing Lua annotations (e.g. `---@type ...`)

### Tmux (`tmux/dot-tmux.conf`)
- Keep prefix `Ctrl-a` unless explicitly asked to change
- Preserve grouped sections (global, bindings, theme, TPM)
- Keep Catppuccin setup before status-line customization

### Git config (`git/dot-gitconfig`)
- Preserve tab indentation
- Keep include layering via `~/.gitconfig-local`
- Avoid reordering unrelated alias/section blocks

## Imports, Types, Naming, Error Handling
Imports:
- None (no Python modules currently tracked in this repository)

Typing:
- Shell: rely on strict mode and runtime checks, not type annotations
- Lua: preserve existing EmmyLua annotations

Naming:
- package dirs: lowercase-hyphenated (e.g. `ghostty-macos`)
- dotfile entries: `dot-*`
- shell functions/scripts: `snake_case`
- manifest groups: `core`, `cli`, `gui`, `dev`, `work`, `media`

Error handling expectations:
- fail fast by default in shell (`set -euo pipefail`)
- validate prerequisites (`command -v`, file/path checks)
- emit clear logs for failures and skip paths
- avoid silent ignores and empty error handlers

## Dependency and Change Policy
- Prefer existing tools already declared in manifests
- Keep package-manager-specific changes in the correct manifest files
- Do not silently migrate formats/tooling
- For bug fixes, prefer minimal edits over opportunistic refactors

## External Instruction Files
Checked in this repository:
- `.cursor/rules/` not found
- `.cursorrules` not found
- `.github/copilot-instructions.md` not found

If these appear later, treat them as higher-priority instructions and update this file.
