#!/bin/bash

which -s brew
if [[ $? != 0 ]] ; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

brew install gcc
brew install git
brew install htop
brew install pandoc
brew install python
brew install ssh-copy-id
brew install the_silver_searcher
brew install valgrind
brew install vim --override-system-vi --with-client-server --force
brew install wget
brew install zsh
brew install zsh-completions
