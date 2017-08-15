#!/bin/bash

git submodule update --init --recursive

unlink ~/.zshrc
unlink ~/.vimrc
unlink ~/.vim
unlink ~/.bashrc
unlink ~/.oh-my-zsh
unlink ~/.gitconfig
unlink /usr/local/bin/subl

ln -s ~/env/.bashrc ~/.bashrc
ln -s ~/env/.zshrc ~/.zshrc
ln -s ~/env/.vimrc ~/.vimrc
ln -s ~/env/.vim ~/.vim
ln -s ~/env/.oh-my-zsh ~/.oh-my-zsh
ln -s ~/env/.gitconfig ~/.gitconfig
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl
