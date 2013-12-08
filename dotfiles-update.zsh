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
git pull
git submodule foreach git pull origin master

antigen-update
vundle-update

popd

