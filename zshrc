# oh-my-zsh configuration.
DOTFILES_PATH=$HOME/dotfiles
ANTIGEN=$DOTFILES_PATH/antigen

source $ANTIGEN/antigen.zsh

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"
# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"
# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"
# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles
if [[ `uname` == "Darwin" ]]; then
  antigen bundle osx
  antigen bundle brew
fi

if [[ `uname` == "Linux" ]]; then
  # antigen bundle debian
  antigen bundle command-not-found

  export TERM="xterm-256color"
  ZSH_TMUX_AUTOSTART=true
  antigen bundle tmux
fi

antigen bundle git
antigen bundle vi-mode
antigen bundle vundle
antigen bundle colored-man
antigen bundle autojump

antigen bundle zsh-users/zsh-completions src

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern cursor)
antigen bundle zsh-users/zsh-syntax-highlighting

# zsh-history-substring-search
antigen bundle zsh-users/zsh-history-substring-search

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

# Load the theme.
antigen theme mortalscumbag

# Tell antigen that you're done.
antigen apply

# env
export SHELL=`which zsh`
export LANG="en_US.UTF-8"
alias dotfiles-update="source $DOTFILES_PATH/dotfiles-update.zsh"

# Colors
export CLICOLOR=1
if [[ `uname` == "Darwin" ]]; then
  export LSCOLORS=Exfxcxdxbxegedabagacad
else
  export LS_COLORS='di=01;34;49:ln=35;49:so=32;49:pi=33;49:ex=31;49:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
fi
# Base16 Shell
BASE16_SCHEME="default"
BASE16_BG="dark"
BASE16_SHELL="$DOTFILES_PATH/base16-shell/base16-$BASE16_SCHEME.$BASE16_BG.sh"
[[ -s $BASE16_SHELL ]] && . $BASE16_SHELL

# Editors
if [[ `uname` == "Darwin" ]]; then
  #export EDITOR='subl -n -w'
  # export EDITOR='mvim -f --nomru -c "au VimLeave * !open -a iTerm"'
  export EDITOR='vim'
else
  # export EDITOR='gvim -f'
  export EDITOR='vim'
fi

# More Aliases
[[ -s ~/.zsh_aliases ]] && . ~/.zsh_aliases

# Misc
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

# Path
if [[ -d $HOME/bin ]]; then
  PATH=$PATH:$HOME/bin
fi

if [[ -d $HOME/.local/bin ]]; then
  PATH=$PATH:$HOME/.local/bin
fi

# golang
if [[ -d $HOME/gocode ]]; then
  export GOPATH=$HOME/gocode
  PATH=$PATH:$GOPATH/bin
fi

# android-sdk
if [[ -d $HOME/tools/android/sdk/platform-tools ]]; then
  PATH=$PATH:$HOME/tools/android/sdk/platform-tools
fi

# Remove duplicated paths
PATH=$(echo $PATH|tr ":" "\n"|gawk '!($0 in a) { a[$0];print}'|paste -sd: - )
