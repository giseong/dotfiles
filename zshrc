# oh-my-zsh configuration.
DOTFILES_PATH=$HOME/dotfiles
ZSH=$DOTFILES_PATH/oh-my-zsh
BASE16_SHELL=$DOTFILES_PATH/base16-shell

ZSH_THEME="mortalscumbag"
DISABLE_AUTO_UPDATE="true"
COMPLETION_WAITING_DOTS="true"

if [[ `uname` == "Darwin" ]]; then
  plugins=(gnu-utils git vi-mode vundle extract history-substring-search autojump dircycle dirpersist osx sublime brew rbenv)
elif [[ `uname` == "Linux" ]]; then
  plugins=(gnu-utils git vi-mode vundle extract history-substring-search autojump dircycle dirpersist)
fi

source $ZSH/oh-my-zsh.sh

# env
export SHELL=`which zsh`
export LANG="en_US.UTF-8"

# Colors
export CLICOLOR=1
if [[ `uname` == "Darwin" ]]; then
  export LSCOLORS=Exfxcxdxbxegedabagacad
elif [[ `uname` == "Linux" ]]; then
  export LS_COLORS='di=01;34;49:ln=35;49:so=32;49:pi=33;49:ex=31;49:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
fi
source $BASE16_SHELL/base16-default.dark.sh

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

