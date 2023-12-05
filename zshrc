# Fig pre block. Keep at the top of this file.
[[ -f "$HOME/.fig/shell/zshrc.pre.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.pre.zsh"
# Environment Variables
export SHELL=`which zsh`
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export DOTFILES_PATH=$HOME/.dotfiles

# Antigen
#if [[ "$OSTYPE" == "darwin"* ]]; then
#  export ZSH_TMUX_ITERM2=true
#fi
#if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
#  export ZSH_TMUX_AUTOSTART=true
#fi
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
alias ls='colorls'

# Editors
export EDITOR=`which nvim`
alias vim=$EDITOR
alias vi=$EDITOR
alias e=$EDITOR

#export PAGER=`which vimpager`
#alias less=$PAGER
#alias zless=$PAGER

# Path
[[ -d /usr/local/sbin ]] && PATH=$PATH:/usr/local/sbin
[[ -d /snap/bin ]] && PATH=$PATH:/snap/bin
[[ -d $HOME/bin ]] && PATH=$PATH:$HOME/bin
[[ -d $HOME/.local/bin ]] && PATH=$PATH:$HOME/.local/bin
[[ -d $HOME/.SpaceVim/bin ]] && PATH=$PATH:$HOME/.SpaceVim/bin
[[ -d $HOME/Library/Android/sdk/platform-tools ]] &&  PATH=$PATH:$HOME/Library/Android/sdk/platform-tools

export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export ANDROID_PATH=~/Library/Android
export ANDROID_SDK_ROOT=$ANDROID_PATH/sdk

# Misc
export GTAGSLABEL=pygments

# More Configuration
[[ -s ~/.zshrc_local ]] && . ~/.zshrc_local


# Prompt
eval "$(starship init zsh)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Remove duplicated paths
PATH=$(echo $PATH|tr ":" "\n"|gawk '!($0 in a) { a[$0];print}'|paste -sd: - )

# Fig post block. Keep at the bottom of this file.
[[ -f "$HOME/.fig/shell/zshrc.post.zsh" ]] && builtin source "$HOME/.fig/shell/zshrc.post.zsh"
