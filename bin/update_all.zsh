#!/usr/bin/env zsh

pushd .

cd $HOME

if [[ `uname` == "Darwin" ]]; then
  brew update
  #gem update --system
  gem update
elif [[ `uname` == "Linux" ]]; then
  sudo aptitude update
  sudo aptitude upgrade
fi

cd $HOME/dotfiles
git pull
git submodule update

popd

