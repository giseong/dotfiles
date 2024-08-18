# Environment Variables
export SHELL=`which zsh`
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export DOTFILES_PATH=$HOME/.dotfiles

if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Soure/Load zinit
source /usr/local/opt/zinit/zinit.zsh

# Add oh-my-posh
if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config $(brew --prefix oh-my-posh)/themes/catppuccin_mocha.omp.json)"
fi

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found
zinit snippet OMZP::vi-mode
zinit snippet OMZP::fzf
zinit snippet OMZP::pyenv
zinit snippet OMZP::rbenv
zinit snippet OMZP::nvm
zinit snippet OMZP::zoxide
zinit snippet OMZP::eza

# Load completions
autoload -Uz compinit && compinit

zinit cdreplay -q

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

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Editor
export EDITOR=`which nvim`
alias vim=$EDITOR
alias vi=$EDITOR
alias e=$EDITOR

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

# Integrations
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# Misc
export GTAGSLABEL=pygments

