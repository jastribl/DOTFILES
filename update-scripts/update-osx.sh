#!/usr/bin/env bash

if [[ `uname -s` != "Darwin" ]]; then
    echo "Not on OSX, moving on"
    exit 0
fi

# allow key presses to releat on hold in sublime
defaults write -g ApplePressAndHoldEnabled -bool false

defaults write -g InitialKeyRepeat -int 20 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1         # normal minimum is 2 (30 ms)

if ! which brew > /dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

./update-scripts/brew-dep-analysis.py

# set bash to the correct version
if ! grep -q '/usr/local/bin/bash' /etc/shells; then
    sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells';
fi

if [[ "$SHELL" != /usr/local/bin/bash ]]; then
    echo "---------- setting default shell to bash 4 ----------"
    chsh -s /usr/local/bin/bash
fi

rm -rf "/Users/$(whoami)/Library/Application Support/Sublime Text 3/Packages/User"
ln -f -s $PWD/Sublime/User "/Users/$(whoami)/Library/Application Support/Sublime Text 3/Packages/User"
