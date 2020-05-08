#!/usr/bin/env bash


if ! type git > /dev/null; then
  git submodule update --init --recursive
else
  echo "unable to setup git submodules"
fi

unlink ~/.zshrc 2>/dev/null || echo "."
unlink ~/.zshrc_work 2>/dev/null || echo "."
unlink ~/.vimrc 2>/dev/null || echo "."
unlink ~/.vim 2>/dev/null || echo "."
unlink ~/.bashrc 2>/dev/null || echo "."
unlink ~/.oh-my-zsh 2>/dev/null || echo "."
unlink ~/.gitconfig 2>/dev/null || echo "."

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -s $DIR/.bashrc ~/.bashrc
ln -s $DIR/.zshrc ~/.zshrc
ln -s $DIR/.zshrc_work ~/.zshrc_work
ln -s $DIR/.vimrc ~/.vimrc
ln -s $DIR/.vim ~/.vim
ln -s $DIR/.oh-my-zsh ~/.oh-my-zsh
ln -s $DIR/.gitconfig ~/.gitconfig
