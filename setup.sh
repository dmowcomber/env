#!/usr/bin/env bash

main() {
  if type git > /dev/null; then
    git submodule update --init --recursive
  else
    echo "git is not installed. skipping git submodules"
  fi

  echo "linking dot files"
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

  echo "done linking dot files"
  echo "bash: $(which bash 2>/dev/null)"
  echo "zsh: $(which zsh 2>/dev/null)"
  echo "git: $(which git 2>/dev/null)"
  echo "go: $(which go 2>/dev/null)"
  echo "powerline-go: $(which powerline-go 2>/dev/null)"
  echo "brew: $(which brew 2>/dev/null)"

  if uname -a |grep -q steamdeck; then
    echo "SteamDeck: skipping remaining steps"
  else 
    case `uname` in
      Darwin)
        setupMacOS
      ;;
      Linux)
        setupLinux
      ;;
    esac
  fi

  if type go > /dev/null && [ ! -f $GOPATH/bin/powerline-go ]; then
    go install github.com/dmowcomber/powerline-go@latest
  else
    echo "golang is not installed. skipping install of powerline-go"
  fi
}

setupMacOS() {
  echo "setting up Mac"
  if ! type brew > /dev/null; then
    echo "Skipping install of 'coreutils' because brew is not installed"
    return
  fi

  if ! type gdate > /dev/null; then
    echo "installing coreutils to get gnu binaries (like gdate)"
    brew install coreutils
  fi

  if ! type fzf > /dev/null; then
    echo "installing fzf"
    brew install fzf
    $(brew --prefix)/opt/fzf/install
  fi

  if ! type kubectl > /dev/null; then
    echo "installing kubectl"
    brew install kubernetes-cli
  fi

  if ! type ktx > /dev/null; then
    echo "installing ktx"
    brew tap blendle/blendle
    brew install kns
  fi
}

setupLinux() {
  sudo apt install -y fonts-powerline
  sudo apt install -y zsh
  sudo apt install -y vim
  sudo chsh `whoami` -s `which zsh`
  ./linux/install-go.sh
}

main
