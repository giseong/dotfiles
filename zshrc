export SHELL=`which zsh`
export LANG="en_US.UTF-8"
export DOTFILES_PATH=$HOME/.dotfiles
export POWERLINE_PATH=/usr/local/lib/python3.6/dist-packages/powerline

[[ -d $POWERLINE_PATH ]] && powerline-daemon -q

# Antigen
source $DOTFILES_PATH/antigen/antigen.zsh
antigen init .antigenrc

# Colors
export CLICOLOR=1
if [[ `uname` == "Darwin" ]]; then
    export LSCOLORS=Exfxcxdxbxegedabagacad
else
    export LS_COLORS='di=01;34;49:ln=35;49:so=32;49:pi=33;49:ex=31;49:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
fi

# Base16 Shell
BASE16_SHELL=$DOTFILES_PATH/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# Editors
export EDITOR='vim'

# Pager
export PAGER=/usr/bin/vimpager

# alias
alias dotfiles-update="source $DOTFILES_PATH/dotfiles-update.zsh"
alias less=$PAGER
alias zless=$PAGER

# Powerline Prompt
[[ -d $POWERLINE_PATH ]] && . $POWERLINE_PATH/bindings/zsh/powerline.zsh

# Path
[[ -d $HOME/bin ]] && PATH=$PATH:$HOME/bin
[[ -d $HOME/.local/bin ]] && PATH=$PATH:$HOME/.local/bin

# More Configuration
[[ -s ~/.zshrc_local ]] && . ~/.zshrc_local

# Remove duplicated paths
PATH=$(echo $PATH|tr ":" "\n"|gawk '!($0 in a) { a[$0];print}'|paste -sd: - )
