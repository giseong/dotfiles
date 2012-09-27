#!/usr/bin/env zsh

pushd .

cd $HOME

if [[ `uname` == "Darwin" ]]; then
  brew update
  #gem update --system
  gem update
fi

cd $HOME/dotfiles
git pull
git submodule update

popd

