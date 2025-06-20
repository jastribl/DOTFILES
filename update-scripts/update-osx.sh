#!/usr/bin/env bash

if [[ $(uname -s) != "Darwin" ]]; then
    echo "Not on OSX, moving on"
    exit 0
fi

# Keyboard customization
defaults write -g ApplePressAndHoldEnabled -bool false             # Allow key presses to repeat on hold in sublime
defaults write -g InitialKeyRepeat -int 20                         # Normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1                                 # Normal minimum is 2 (30 ms)
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false # Turn off double space period

# Dock customization
defaults write com.apple.dock autohide -bool true                 # Autohide dock
defaults write com.apple.dock tilesize -int 30                    # Adjust dock icon size
defaults write com.apple.dock show-recents -bool false            # Disable recent apps showing
defaults write com.apple.dock minimize-to-application -bool false # Don't minimize to application
defaults write com.apple.dock persistent-apps -array              # Remove persistent apps
defaults write com.apple.dock persistent-others -array            # Remove persistent others
defaults write com.apple.dock recent-apps -array                  # Remove recent apps

# General customization
defaults write -g  AppleInterfaceStyle -string 'Dark' # Dark theme

# Trackpad Customization
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true        # Tap to click
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0 # Light click
defaults write -g com.apple.trackpad.scaling 1.5                            # Trackpad speed
defaults write -g com.apple.swipescrolldirection -bool false                # Real scrolling :)

# Save come preferences for personal machine
if ! which fbclone > /dev/null; then
    defaults read /Library/Preferences/com.apple.TimeMachine.plist SkipPaths > random-settings/time-machine-excludes.txt
    defaults read com.piriform.ccleaner CookiesToKeep > random-settings/cookies-to-keep.txt
fi

if ! which brew > /dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

./update-scripts/brew-dep-analysis.py

if ! command -v python3 &>/dev/null; then
    brew install python3
fi

# set bash to the correct version
if ! grep -q "$(brew --prefix)/bin/bash" /etc/shells; then
    sudo bash -c "echo $(brew --prefix)/bin/bash >> /etc/shells";
fi

if [[ "$SHELL" != $(brew --prefix)/bin/bash ]]; then
    chsh -s $(brew --prefix)/bin/bash
fi

# Link Sublime settings
sublime_dest_dir="$HOME/Library/Application Support/Sublime Text 3/Packages/User"
if [[ $(uname -m) == 'arm64' ]]; then
    sublime_dest_dir="$HOME/Library/Application Support/Sublime Text/Packages/User"
fi
rm -rf "$sublime_dest_dir"
ln -f -s $PWD/Sublime/User "$sublime_dest_dir"

# Link Spectacle settings
spectable_dest_file="$HOME/Library/Application Support/Spectacle/Shortcuts.json"
rm "$spectable_dest_file"
ln -f -s $PWD/random-settings/spectacle-shortcuts.json "$spectable_dest_file"

# Link Rectangle settings (after converting it to readable)
plutil -convert xml1 $HOME/Library/Preferences/com.knollsoft.Rectangle.plist
cp $HOME/Library/Preferences/com.knollsoft.Rectangle.plist $PWD/random-settings/com.knollsoft.Rectangle.plist

# Backup list of VS Code extensions
if which fbclone > /dev/null; then
    code-fb --list-extensions --extensions-dir ~/.vscode-fb-mkt/extensions/ > dotfiles/vs-code/fb-extensions.txt
else
    code --list-extensions > dotfiles/vs-code-personal/extensions.txt
fi

defaults read com.google.Chrome NSUserKeyEquivalents > ./random-settings/chrome-keyboard-shortcuts.json
