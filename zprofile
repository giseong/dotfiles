# Environment Variables
export SHELL=`which zsh`
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export DOTFILES_PATH=$HOME/.dotfiles

if [ -f /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export PYENV_ROOT=$(brew --prefix pyenv)
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
