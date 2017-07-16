# !/bin/bash

echo "---------- installing brew stuff ----------"

if ! which brew > /dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

apps=(
    gcc
    git
    htop
    pandoc
    python
    ssh-copy-id
    the_silver_searcher
    "vim --override-system-vi"
    wget
    zsh
    zsh-completions
    tmux
    cask
    node
    mongodb
    reattach-to-user-namespace
    diff-so-fancy
)

for app in "${apps[@]}"; do
    echo "> brew install $app"
    brew install $app
done

caskapps=(
    sublime-text
    ccleaner
    flux
    puush
    iterm2
    google-chrome
    google-drive
    skim
    slack
    spectacle
    java
    intellij-idea
    clion
    xquartz
    virtualbox
    isyncr-desktop
    4k-youtube-to-mp3
    android-file-transfer
    messenger
    postman
    sourcetree
    dash
    mactex
    microsoft-office
    disk-inventory-x
    phpstorm
)

for app in "${caskapps[@]}"; do
    echo "brew cask install $app"
    brew cask install $app
done

# some specific settings for the things installed above

# allow key presses to releat on hold in sublime
defaults write -g ApplePressAndHoldEnabled -bool false
