export SHELL=`which zsh`
export LANG="en_US.UTF-8"
export DOTFILES_PATH=$HOME/.dotfiles
#PYTHON_VER=3.4
#if [[ -d /usr/local/lib/python$PYTHON_VER/dist-packages/powerline ]]; then
#    export POWERLINE_PATH=/usr/local/lib/python$PYTHON_VER/dist-packages/powerline
#    powerline-daemon -q
#fi

# Antigen
export ZSH_TMUX_AUTOSTART=true
# export ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
source $HOME/.antigen/antigen.zsh
antigen init $HOME/.antigenrc

# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

# bind P and N for EMACS mode
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

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
export EDITOR='nvim'

# Pager
export PAGER=/usr/local/bin/vimpager

# alias
alias dotfiles-update="source $DOTFILES_PATH/dotfiles-update.zsh"
alias less=$PAGER
alias zless=$PAGER

# Powerline Prompt
#[[ -d $POWERLINE_PATH ]] && . $POWERLINE_PATH/bindings/zsh/powerline.zsh

# Path
[[ -d $HOME/bin ]] && PATH=$PATH:$HOME/bin
[[ -d $HOME/.local/bin ]] && PATH=$PATH:$HOME/.local/bin
[[ -d $HOME/.SpaceVim/bin ]] && PATH=$PATH:$HOME/.SpaceVim/bin

# More Configuration
[[ -s ~/.zshrc_local ]] && . ~/.zshrc_local

# Remove duplicated paths
PATH=$(echo $PATH|tr ":" "\n"|gawk '!($0 in a) { a[$0];print}'|paste -sd: - )
