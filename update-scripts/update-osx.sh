#!/usr/bin/env bash

if [[ $(uname -s) != "Darwin" ]]; then
    echo "Not on OSX, moving on"
    exit 0
fi

# Keyboard customization
defaults write -g ApplePressAndHoldEnabled -bool false # Allow key presses to repeat on hold in sublime
defaults write -g InitialKeyRepeat -int 20             # Normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1                     # Normal minimum is 2 (30 ms)

# Dock customization
defaults write com.apple.dock autohide -bool true                 # Autohide dock
defaults write com.apple.dock tilesize -int 30                    # Adjust dock icon size
defaults write com.apple.dock show-recents -bool false            # Disable recent apps showing
defaults write com.apple.dock minimize-to-application -bool false # Don't minimize to application
defaults write com.apple.dock persistent-apps -array              # Remove persistent apps
defaults write com.apple.dock persistent-others -array            # Remove persistent others
defaults write com.apple.dock recent-apps -array                  # Remove recent apps
killall Dock

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
    chsh -s /usr/local/bin/bash
fi

sublime_dest_dir="$HOME/Library/Application Support/Sublime Text 3/Packages/User"
rm -rf "$sublime_dest_dir"
ln -f -s $PWD/Sublime/User "$sublime_dest_dir"
