# AGENTS.md

This repository is a personal dotfiles setup managed with GNU Stow.
It targets macOS (Apple Silicon) and Arch Linux (CachyOS).

If you are an agent working here, keep changes minimal and consistent with
existing patterns. Prefer editing within existing Stow packages rather than
adding new top-level folders.

## Quick Facts

- Stow packages live at the repo root (e.g., `zsh/`, `tmux/`, `nvim/`).
- Files named `dot-*` map to `.*` when stowed (configured by `.stowrc`).
- Theme: Catppuccin (Mocha dark, Latte light) across tools.
- Neovim is LazyVim-based and uses `lazy.nvim`.

## Commands (Build / Lint / Test)

This repo does not define a conventional build/test/lint pipeline.
No `package.json`, `Makefile`, `Taskfile`, or CI configs were found.

Use these operational commands instead:

- Install/bootstrap all dotfiles:
  - `./install.sh`
- Apply a single Stow package:
  - `stow <package>`
  - Example: `stow zsh`
- Remove a package:
  - `stow -D <package>`

Optional maintenance scripts:

- System and tool updates:
  - `./bin/dot-local/bin/update_packages`

### Running a Single Test

No test runner is configured in this repository.
If you add tests in the future, document the single-test command here.

## Code Style and Conventions

### EditorConfig (Global Formatting)

File: `editorconfig/dot-editorconfig`

- Default: spaces, 4-space indentation
- Trim trailing whitespace, insert final newline
- Line endings: LF, charset: UTF-8

Overrides:

- Markdown: 2-space indentation, do not trim trailing whitespace
- JSON/YAML/JS/TS/HTML/CSS: 2-space indentation
- Python: 4-space indentation
- Makefile: tabs
- C/C++: tabs (tab width 4)
- Git config: tabs

### Lua (Neovim, WezTerm)

File: `nvim/dot-config/nvim/stylua.toml`

- Indentation: 2 spaces
- Max column width: 120
- Use `stylua` if formatting is needed

### Shell Scripts (bash)

Files: `install.sh`, `bin/dot-local/bin/update_packages`

- Use `#!/usr/bin/env bash`
- Start with `set -euo pipefail`
- Prefer small helper functions for logging
- For non-critical commands, guard with `|| true` or explicit logging
- Keep OS detection explicit and centralized

### Zsh Configuration

Files: `zsh/dot-zprofile`, `zsh/dot-zshrc`

- Sections are clearly numbered and separated by comment banners
- Preserve section ordering (system detection, paths, plugins, aliases, etc.)
- Prefer explicit conditionals for OS-specific behavior

### Tmux Configuration

File: `tmux/dot-tmux.conf`

- Structured in numbered sections with banner comments
- Keep plugin list together and near the end

### Python Scripts

File: `bin/dot-local/bin/extract_wisdom_kr`

- Standard library only (sys, subprocess, re)
- Use `subprocess.run(..., check=True, capture_output=True, text=True)`
- Handle exceptions with clear user-facing messages

### Git Configuration

File: `git/dot-gitconfig`

- Uses tabs per `.editorconfig`
- Avoid reformatting without need

## Naming Conventions

- Stow packages: lower-case directory names (e.g., `nvim`, `tmux`)
- Dotfiles within packages: `dot-*` prefix
- Scripts: snake_case (e.g., `update_packages`, `extract_wisdom_kr`)
- Lua modules: use `require("...")` at top when needed

## Error Handling Guidelines

- Bash: fail fast with `set -euo pipefail`, log errors with context
- Bash: use `|| true` only when failure is acceptable and logged
- Python: catch `subprocess.CalledProcessError` and print stderr

## Imports and Dependencies

- Prefer standard library in scripts unless a new dependency is required
- Avoid adding new dependencies unless clearly necessary

## Notes on External Rules

- No `.cursor/rules/`, `.cursorrules`, or `.github/copilot-instructions.md` files
  were found in this repository.
- If you add such files later, update this document accordingly.

## Suggested Verification

Since there is no test suite, verify changes by:

- Running `./install.sh` in a safe environment when editing install logic
- Running `stow <package>` for the modified package
- Running affected scripts manually and checking output
