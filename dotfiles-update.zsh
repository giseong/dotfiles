#!/usr/bin/env zsh

pushd .

cd $HOME

if [[ `uname` == "Darwin" ]]; then
  brew update
  brew upgrade
  brew cleanup --force
  gem update --system
  gem update
  gem cleanup
fi

cd $HOME/dotfiles
git pull --recurse-submodules
git submodule update --recursive

antigen-update
vundle-update

popd

