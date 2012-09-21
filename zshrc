# oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="mortalscumbag"

if [[ `uname` == "Darwin" ]]; then
  plugins=(gnu-utils git vi-mode vundle extract history-substring-search autojump osx sublime brew)
elif [[ `uname` == "Linux" ]]; then
  plugins=(gnu-utils git vi-mode vundle extract history-substring-search autojump command-not-found)
fi

source $ZSH/oh-my-zsh.sh

# env
export SHELL=`which zsh`
export LANG="en_US.UTF-8"

# Colors
export TERM=xterm-256color
export CLICOLOR=1

# Editors
export EDITOR='vim'
alias e=$EDITOR

if [[ `uname` == "Darwin" ]]; then
  export PAGER=vimpager
  alias less=$PAGER
  alias zless=$PAGER

  # Rbenv
  if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
fi

# Path
if [ -d $HOME/bin ]; then
  export PATH=$PATH:$HOME/bin
fi

# Remove duplicated paths
PATH=$(echo $PATH|tr ":" "\n"|gawk '!($0 in a) { a[$0];print}'|paste -sd: - )

