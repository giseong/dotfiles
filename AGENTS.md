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
| `git-work`, `git-personal`, `git-work-ci` | Writes `~/.gitconfig-local` overlay |
| `opencode-work`, `opencode-personal` | Writes `~/.config/opencode/` overlay |

## Build, Lint, Test, Verify
There is no centralized CI and no formal unit-test suite.
Verification is scoped to changed files/packages.

Core commands:
```bash
./install.sh              # Full system bootstrap
stow <package>            # Apply package
cd <package> && stow .    # Apply from inside package
stow -D <package>         # Remove package
./update_packages.sh      # Update system packages and dev tools
```

Syntax/lint-style checks:
```bash
bash -n install.sh
bash -n update_packages.sh
stow -n -v <package>      # Dry-run stow (check for conflicts)
brew bundle list --file=manifests/macos/core.brewfile
```

### Single test equivalent (most important)
Use this as the closest "single test" workflow:
1. Re-apply only the changed package: `stow <modified-package>`
2. Run file-level checks for changed artifacts (for scripts, `bash -n <file>`)
3. Reload/start the target tool and confirm no runtime errors

Quick verification map:
| File/Package | Verification Command |
| --- | --- |
| `install.sh` | `bash -n install.sh` |
| `update_packages.sh` | `bash -n update_packages.sh` |
| `zsh/*` | Open new shell, verify clean startup |
| `tmux/dot-tmux.conf` | `prefix + r` (reload) |
| `nvim/*` | Start Neovim, verify plugins load |
| `*.lua` | `stylua --check <file>` (if stylua installed) |
| macOS manifest | `brew bundle list --file=<brewfile>` |
| Arch manifest | Manual format check (one package per line, `#` comments) |

## Code Style Source of Truth
Formatting baseline: `editorconfig/dot-editorconfig`.

Global defaults:
- UTF-8
- LF line endings
- Final newline required
- Trim trailing whitespace (except Markdown)

Indentation:
| Language | Indent |
| --- | --- |
| Default | 4 spaces |
| Shell, Lua, Markdown, JSON/YAML, web files | 2 spaces |
| Make, Go, C/C++, Git config | Tabs (width 4) |

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
- Run `stylua <file>` to auto-format

### Tmux (`tmux/dot-tmux.conf`)
- Keep prefix `Ctrl-a` unless explicitly asked to change
- Preserve grouped sections (global, bindings, theme, TPM)
- Keep Catppuccin setup before status-line customization

### Git config (`git/dot-gitconfig`)
- Preserve tab indentation
- Keep include layering via `~/.gitconfig-local`
- Avoid reordering unrelated alias/section blocks

### Package Manifests
- macOS: `manifests/macos/<group>.brewfile` (Homebrew Bundle format)
- Arch: `manifests/arch/<group>.pacman` (one package per line)
- Arch AUR: `manifests/arch/<group>.aur` (one package per line)
- Groups: `core`, `cli`, `gui`, `dev`, `work`, `media`

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
- Fail fast by default in shell (`set -euo pipefail`)
- Validate prerequisites (`command -v`, file/path checks)
- Emit clear logs for failures and skip paths
- Avoid silent ignores and empty error handlers

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
