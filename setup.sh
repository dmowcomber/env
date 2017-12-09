#!/usr/bin/env bash

git submodule update --init --recursive

unlink ~/.zshrc
unlink ~/.vimrc
unlink ~/.vim
unlink ~/.bashrc
unlink ~/.oh-my-zsh
unlink ~/.gitconfig
unlink /usr/local/bin/subl

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -s $DIR/bashrc ~/.bashrc
ln -s $DIR/.zshrc ~/.zshrc
ln -s $DIR/.vimrc ~/.vimrc
ln -s $DIR/.vim ~/.vim
ln -s $DIR/.oh-my-zsh ~/.oh-my-zsh
ln -s $DIR/.gitconfig ~/.gitconfig
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl
