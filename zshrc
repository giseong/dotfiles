# Environment Variables
export SHELL=`which zsh`
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export DOTFILES_PATH=$HOME/.dotfiles

# Antigen
# export ZSH_TMUX_AUTOSTART=true
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

# Base16 Shell
BASE16_SHELL=$DOTFILES_PATH/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"

# colorls
source $(dirname $(gem which colorls))/tab_complete.sh
alias lc='colorls -lA --sd'

# Editors
export PAGER=`which vimpager`
export EDITOR=`which vim`
alias e=$EDITOR
alias less=$PAGER
alias zless=$PAGER

# Path
[[ -d /snap/bin ]] && PATH=$PATH:/snap/bin
[[ -d $HOME/bin ]] && PATH=$PATH:$HOME/bin
[[ -d $HOME/.local/bin ]] && PATH=$PATH:$HOME/.local/bin
[[ -d $HOME/.SpaceVim/bin ]] && PATH=$PATH:$HOME/.SpaceVim/bin

# Misc
export GTAGSLABEL=pygments

# More Configuration
[[ -s ~/.zshrc_local ]] && . ~/.zshrc_local

# Remove duplicated paths
PATH=$(echo $PATH|tr ":" "\n"|gawk '!($0 in a) { a[$0];print}'|paste -sd: - )
