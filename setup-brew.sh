#!/bin/bash

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
    "vim --with-override-system-vi"
    wget
    zsh
    zsh-completions
    tmux
    cask
    node
    reattach-to-user-namespace
    diff-so-fancy
    watch
    "go --cross-compile-common"
    python3
    composer
    php56
    ctop
    z
    fpp
    bash
    bash-completion@2
    cmake
)

for app in "${apps[@]}"; do
    echo "> brew install $app"
    brew install "$app"
done

caskapps=(
    sublime-text
    ccleaner
    flux
    puush
    iterm2
    google-chrome
    google-backup-and-sync
    skim
    slack
    spectacle
    java8
    intellij-idea
    clion
    xquartz
    virtualbox
    isyncr-desktop
    4k-youtube-to-mp3
    android-file-transfer
    messenger
    postman
    dash
    mactex
    microsoft-office
    disk-inventory-x
    phpstorm
    goland
    skype
    android-studio
    vagrant
    discord
    soundcloud-downloader
    psequel
    osxfuse
)

for app in "${caskapps[@]}"; do
    echo "brew cask install $app"
    brew cask install "$app"
done
