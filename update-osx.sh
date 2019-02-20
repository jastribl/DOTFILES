#!/usr/bin/env bash

if [[ `uname -s` != "Darwin" ]]; then
    echo "Not on OSX, moving on"
    exit 0
fi

./update-bash.sh

# allow key presses to releat on hold in sublime
defaults write -g ApplePressAndHoldEnabled -bool false

defaults write -g InitialKeyRepeat -int 20 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1         # normal minimum is 2 (30 ms)

if ! which brew > /dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

./brew-dep-analysis.py

rm -rf "/Users/$(whoami)/Library/Application Support/Sublime Text 3/Packages/User"
ln -f -s $PWD/Sublime/User "/Users/$(whoami)/Library/Application Support/Sublime Text 3/Packages/User"
