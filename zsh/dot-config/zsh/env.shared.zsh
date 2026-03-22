# ---------------------------------------------------------------------
# SHARED ENVIRONMENT (Login + Non-login Interactive)
# ---------------------------------------------------------------------
# Both `.zprofile` and `.zshrc` source this file. Guard against double-loading
# in the same shell process while still allowing both entrypoints to share it.
if [[ "${DOTFILES_ENV_SHARED_LOADED_PID:-}" == "$$" ]]; then
  return
fi
typeset -g DOTFILES_ENV_SHARED_LOADED_PID="$$"

# Ensure SHELL variable is set to zsh.
[[ -z "${SHELL:-}" ]] && export SHELL="$(command -v zsh)"

# ---------------------------------------------------------------------
# 1. LOCALE & SHARED ENVIRONMENT
# ---------------------------------------------------------------------
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
# Intentionally avoid global LC_ALL to prevent overriding tool-specific locale behavior.

export GOPATH="$HOME/go"
export PYENV_ROOT="$HOME/.pyenv"

# ---------------------------------------------------------------------
# 2. PATH CONFIGURATION
# ---------------------------------------------------------------------
typeset -gU path PATH

prepend_path_entries() {
  local entry
  local -a new_entries=()

  for entry in "$@"; do
    [[ -d "$entry" ]] || continue
    new_entries+=("$entry")
  done

  (( ${#new_entries[@]} == 0 )) && return
  path=("${new_entries[@]}" "${path[@]}")
}

prepend_path_entries \
  "$PYENV_ROOT/bin" \
  "$GOPATH/bin" \
  "$HOME/.local/bin" \
  "$HOME/.npm-global/bin" \
  "/usr/local/sbin"

# ---------------------------------------------------------------------
# 3. MISC
# ---------------------------------------------------------------------
export NODE_USE_SYSTEM_CA=1
