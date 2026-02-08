# ---------------------------------------------------------------------
# SHARED ENVIRONMENT (Login + Non-login Interactive)
# ---------------------------------------------------------------------
# Guard against double-loading in the same shell process (.zprofile + .zshrc)
if [[ "${DOTFILES_ENV_SHARED_LOADED_PID:-}" == "$$" ]]; then
  return
fi
typeset -g DOTFILES_ENV_SHARED_LOADED_PID="$$"

# ---------------------------------------------------------------------
# 1. OS & PLATFORM DETECTION
# ---------------------------------------------------------------------
export OS_TYPE="$(uname -s)"
[[ "$OS_TYPE" == "Darwin" ]] && export IS_MAC=true || export IS_MAC=false

# Ensure SHELL variable is set to zsh
[[ -z "${SHELL:-}" ]] && export SHELL="$(command -v zsh)"

# ---------------------------------------------------------------------
# 2. LOCALE & LANGUAGE SETTINGS
# ---------------------------------------------------------------------
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# ---------------------------------------------------------------------
# 3. PACKAGE MANAGER & RUNTIME INITIALIZATION
# ---------------------------------------------------------------------
if [[ -o login && "$IS_MAC" == true && -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

if [[ -d "$HOME/.pyenv" ]]; then
  export PYENV_ROOT="$HOME/.pyenv"
  case ":$PATH:" in
    *":$PYENV_ROOT/bin:"*) ;;
    *) export PATH="$PYENV_ROOT/bin:$PATH" ;;
  esac
  [[ ! -o interactive ]] && export PYENV_DISABLE_AUTOREHASH=1
  if [[ -o login ]] && command -v pyenv &>/dev/null; then
    eval "$(pyenv init --path)"
  fi
fi

export NVM_DIR="$HOME/.nvm"

if [[ "$IS_MAC" == true ]]; then
  export ANDROID_SDK_ROOT="$HOME/Library/Android/sdk"
else
  export ANDROID_SDK_ROOT="$HOME/Android/Sdk"
fi

export GOPATH="$HOME/go"

# ---------------------------------------------------------------------
# 4. PATH CONFIGURATION
# ---------------------------------------------------------------------
for path_entry in \
  "/usr/local/sbin" \
  "$ANDROID_SDK_ROOT/platform-tools" \
  "$GOPATH/bin" \
  "$HOME/.npm-global/bin" \
  "$HOME/.local/bin"
do
  [[ -d "$path_entry" ]] || continue
  case ":$PATH:" in
    *":$path_entry:"*) ;;
    *) export PATH="$path_entry:$PATH" ;;
  esac
done

# ---------------------------------------------------------------------
# 5. MISC
# ---------------------------------------------------------------------
export NODE_USE_SYSTEM_CA=1
