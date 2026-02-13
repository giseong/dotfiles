# AGENTS.md
Repository: personal dotfiles managed with GNU Stow.
Platforms: macOS (Apple Silicon) and Arch Linux (CachyOS).
Audience: agentic coding tools working in `/home/gsb/.dotfiles`.
Keep edits minimal and local. Do not add new top-level directories unless requested.

## Repository Layout
- Stow packages are top-level directories.
- `.stowrc` uses `--dotfiles`, so `dot-*` maps to hidden files in `~/`.
- Package path conventions:
  - XDG config: `<pkg>/dot-config/<tool>/...`
  - Home dotfile: `<pkg>/dot-<name>`

Primary package groups:
| Package | Purpose |
| --- | --- |
| `zsh`, `tmux`, `nvim`, `git`, `editorconfig`, `bin`, `fabric` | Cross-platform base configs/scripts |
| `ghostty-macos`, `ghostty-linux` | OS-specific terminal overlays |
| `git-work`, `git-personal` | Writes `~/.gitconfig-local` overlay |
| `opencode-work`, `opencode-personal` | Writes `~/.config/opencode/` overlay |

Manifest files:
- macOS: `manifests/macos/*.brewfile`
- Arch: `manifests/arch/*.pacman` and `manifests/arch/*.aur`
Theme direction: Catppuccin (Mocha dark / Latte light).

## Build, Lint, Test, Verify
There is no centralized CI and no formal unit-test suite.
Verification is scoped to changed files/packages.

Core commands:
```bash
./install.sh
stow <package>
stow -D <package>
./bin/dot-local/bin/update_packages
```

Syntax/lint-style checks:
```bash
bash -n install.sh
bash -n bin/dot-local/bin/update_packages
stow -n -v <package>
brew bundle list --file=manifests/macos/core.brewfile
```

### Single test equivalent (most important)
Use this as the closest "single test" flow:
1. Re-apply only the changed package: `stow <modified-package>`
2. Run file-level check for the changed artifact (for scripts, `bash -n <file>`)
3. Start/reload the target tool and confirm no runtime errors

Quick verification map:
- `install.sh` -> `bash -n install.sh`
- `bin/dot-local/bin/update_packages` -> `bash -n bin/dot-local/bin/update_packages`
- `zsh/*` -> open a new shell and verify clean startup
- `tmux/dot-tmux.conf` -> reload config (`prefix + r` binding)
- `nvim/*` -> start Neovim and verify plugin/config load
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
- 2 spaces: shell, lua, markdown, json/yaml, web files
- Tabs (width 4): `Makefile`, `*.go`, `*.c`, `*.cpp`, `*.h`, `*.hpp`, `*.gitconfig`

## Language-Specific Conventions
### Bash (`install.sh`, `bin/dot-local/bin/*`)
- Shebang: `#!/usr/bin/env bash`
- Start scripts with `set -euo pipefail`
- Use `snake_case` for functions/variables
- Prefer `local` inside functions
- Use explicit OS branching with `case`
- Keep logger helpers (`log_info`, `log_success`, `log_warn`, `log_error`)
- Use `|| true` only for intentional non-critical fallback/cleanup

### Zsh (`zsh/dot-zprofile`, `zsh/dot-zshrc`, `zsh/dot-config/zsh/env.shared.zsh`)
- Preserve section structure and comments
- Keep shared env sourcing from `env.shared.zsh`
- Preserve PID guard: `DOTFILES_ENV_SHARED_LOADED_PID`
- Keep explicit exported environment variables for runtime paths
- Avoid bash-specific syntax that is not zsh-compatible

### Lua / Neovim (`nvim/dot-config/nvim/lua/**`)
- Stylua config: `nvim/dot-config/nvim/stylua.toml`
- 2-space indent, 120 column width
- Use `require("...")` module imports
- Keep modular layout: `lua/config/*` and `lua/plugins/*`
- Preserve plugin spec table-return style
- Keep Lua annotations when present (example: `---@type opencode.Opts`)

### Python (`bin/dot-local/bin/extract_wisdom_kr`)
- 4-space indentation
- `snake_case` names
- stdlib imports at top
- explicit subprocess error handling (`subprocess.CalledProcessError`)
- print actionable stderr on failures

### Tmux (`tmux/dot-tmux.conf`)
- Keep prefix `Ctrl-a` unless explicitly asked to change
- Preserve grouped sections (global, bindings, theme, TPM)
- Keep Catppuccin setup before status line customization

### Git config (`git/dot-gitconfig`)
- Preserve tab indentation
- Keep include layering via `~/.gitconfig-local`
- Avoid reordering unrelated alias/section blocks

## Imports, Types, Naming, Error Handling
Imports:
- Lua: `require("module")` style used in existing Neovim config
- Python: keep imports simple and standard-library-first

Typing:
- Shell: rely on strict mode and checks, not type annotations
- Lua: preserve existing EmmyLua annotations
- Python: if adding hints, keep minimal and consistent with file style

Naming:
- Package dirs: lowercase hyphenated (`ghostty-macos`)
- Dotfile entries: `dot-*`
- Scripts/functions: `snake_case`
- Manifest groups: `core`, `cli`, `gui`, `dev`, `work`, `media`

Error handling expectations:
- Fail fast by default in shell (`set -euo pipefail`)
- Validate prerequisites (`command -v`, file existence checks)
- Emit clear logs for failure and skip paths
- Avoid empty catch/silent ignore patterns

## Dependency and Change Policy
- Prefer existing tools already declared in manifests
- Keep package-manager-specific entries in correct manifest files
- Do not silently migrate formats/tooling
- For bug fixes, use minimal edits and avoid opportunistic refactors

## External Instruction Files
Checked in this repository:
- `.cursor/rules/` not found
- `.cursorrules` not found
- `.github/copilot-instructions.md` not found
If these appear later, treat them as higher-priority instructions and update this file.
