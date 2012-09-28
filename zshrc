# oh-my-zsh configuration.
DOTFILES_PATH=$HOME/dotfiles
ANTIGEN=$DOTFILES_PATH/antigen

source $ANTIGEN/antigen.zsh

# Load the oh-my-zsh's library.
antigen-lib

# Bundles
if [[ `uname` == "Darwin" ]]; then
  antigen-bundle osx
  antigen-bundle sublime
  antigen-bundle brew
  antigen-bundle rbenv
fi
antigen-bundle git
antigen-bundle gnu-utils
antigen-bundle vi-mode
antigen-bundle vundle
antigen-bundle extract
antigen-bundle autojump
antigen-bundle dircycle
antigen-bundle dirpersist
antigen-bundle zsh-users/zsh-history-substring-search

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor root)
antigen-bundle zsh-users/zsh-syntax-highlighting

# Load the theme.
antigen-theme mortalscumbag

# Tell antigen that you're done.
antigen-apply

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
BASE16_SHELL=$DOTFILES_PATH/base16-shell
source $BASE16_SHELL/base16-default.dark.sh

# Editors
export EDITOR='vim'

if [[ `uname` == "Darwin" ]]; then
  export PAGER=vimpager

  # Rbenv
  if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
fi

# Path
if [ -d $HOME/bin ]; then
  PATH=$PATH:$HOME/bin
fi

# Remove duplicated paths
PATH=$(echo $PATH|tr ":" "\n"|gawk '!($0 in a) { a[$0];print}'|paste -sd: - )

# Alias
alias dotfiles-update="source $DOTFILES_PATH/dotfiles-update.zsh"
alias e=$EDITOR

