#!/usr/bin/env zsh

pushd .

cd $HOME

if [[ `uname` == "Darwin" ]]; then
    brew update
    brew upgrade
    brew cleanup --force
elif [[ `uname` == "Linux" ]]; then
    sudo apt update
    sudo apt -y dist-upgrade
fi

cd $HOME/.dotfiles
git pull
git submodule foreach git pull origin master

antigen update
vundle-update

popd

