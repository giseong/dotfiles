#!/usr/bin/env zsh

pushd .

cd $HOME

if [[ `uname` == "Darwin" ]]; then
  brew update
  brew upgrade
  brew cleanup --force
  #gem update --system
  gem update
fi

cd $HOME/dotfiles
git pull
git submodule update

antigen-update
vundle-update

popd

