#!/usr/bin/env zsh

if [ -z "$PS1" ]; then
  echo -e "${COLOR_RED}You should source this, not run it${COLOR_NC}"
else

  link (){
    rm -rf $2
    ln -s $1 $2
  }

  DOTFILES_PATH=~/dotfiles

  # zsh
  rm -rf ~/.oh-my-zsh
  curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh
  link $DOTFILES_PATH/zshrc ~/.zshrc

  # git
  link $DOTFILES_PATH/gitconfig ~/.gitconfig
  link $DOTFILES_PATH/gitignore ~/.gitignore
  link $DOTFILES_PATH/gitattributes ~/.gitattributes

  # vim
  link $DOTFILES_PATH/vim ~/.vim
  link $DOTFILES_PATH/vimrc ~/.vimrc

  # tmux
  link $DOTFILES_PATH/tmux.conf ~/.tmux.conf
  link $DOTFILES_PATH/tmux ~/.tmux

  # pandoc
  #rm -rf ~/.csl
  #git clone git://github.com/citation-style-language/styles.git ~/.csl
  #link $DOTFILES_PATH/pandoc ~/.pandoc

  # ruby
  link $DOTFILES_PATH/rvmrc ~/.rvmrc
  link $DOTFILES_PATH/pryrc ~/.pryrc
  link $DOTFILES_PATH/aprc ~/.aprc

  # heskell
  rm -rf ~/.cabal
  mkdir ~/.cabal
  link $DOTFILES_PATH/cabal/config ~/.cabal/config

  # Misc
  link $DOTFILES_PATH/ackrc ~/.ackrc
  link $DOTFILES_PATH/latexmkrc ~/.latexmkrc
  link $DOTFILES_PATH/inputrc ~/.inputrc
  link $DOTFILES_PATH/editrc ~/.editrc
  #link $DOTFILES_PATH/Xresources ~/.Xresources

  # usr bin
  rm -rf ~/bin
  link $DOTFILES_PATH/bin ~/bin
fi
