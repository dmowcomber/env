#!/bin/bash
unlink ~/.zshrc || true
unlink ~/.bashrc || true
unlink ~/.oh-my-zsh || true
unlink ~/.gitconfig || true
unlink /usr/local/bin/subl || true

ln -s ~/env/.bashrc ~/.bashrc
ln -s ~/env/.zshrc ~/.zshrc
ln -s ~/env/.oh-my-zsh ~/.oh-my-zsh
ln -s ~/env/.gitconfig ~/.gitconfig
ln -s /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl
