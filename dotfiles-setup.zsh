#!/usr/bin/env zsh

if [ -z "$PS1" ]; then
  echo -e "${COLOR_RED}You should source this, not run it${COLOR_NC}"
else

  link (){
    rm -rf $2
    ln -s $1 $2
  }

  DOTFILES_PATH=~/dotfiles
  cd $DOTFILES_PATH
  git submodule update --init
  cd $HOME

  # zsh
  rm -rf ~/.oh-my-zsh
  link $DOTFILES_PATH/zshrc ~/.zshrc

  # git
  if [[ `uname` == "Darwin" ]]; then
    link $DOTFILES_PATH/gitconfig_osx ~/.gitconfig
  elif [[ `uname` == "Linux" ]]; then
    link $DOTFILES_PATH/gitconfig_linux ~/.gitconfig
  fi
  link $DOTFILES_PATH/gitignore ~/.gitignore
  link $DOTFILES_PATH/gitattributes ~/.gitattributes
  link $DOTFILES_PATH/tigrc ~/.tigrc

  # vim
  link $DOTFILES_PATH/vim ~/.vim
  link $DOTFILES_PATH/vimrc ~/.vimrc

  # tmux
  if [[ `uname` == "Darwin" ]]; then
    link $DOTFILES_PATH/tmux_osx.conf ~/.tmux.conf
  elif [[ `uname` == "Linux" ]]; then
    link $DOTFILES_PATH/tmux_linux.conf ~/.tmux.conf
  fi
  link $DOTFILES_PATH/tmux_shared.conf ~/.tmux_shared.conf
  link $DOTFILES_PATH/tmux ~/.tmux

  # pandoc
  link $DOTFILES_PATH/pandoc ~/.pandoc

  # Misc
  link $DOTFILES_PATH/ackrc ~/.ackrc
  link $DOTFILES_PATH/ctags ~/.ctags
  link $DOTFILES_PATH/latexmkrc ~/.latexmkrc
  link $DOTFILES_PATH/inputrc ~/.inputrc
  link $DOTFILES_PATH/editrc ~/.editrc

fi
