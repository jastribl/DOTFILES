#!/usr/bin/env bash

echo "---------- installing brew stuff ----------"

if [[ `uname -s` != "Darwin" ]]; then
    echo "Not on OSX, moving on"
    exit 0
fi

if ! which brew > /dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

apps=($(IFS=$'\n' cat brew/brew-list))

for app in "${apps[@]}"; do
    echo "> brew install $app"
    brew install "$app"
done

caskapps=($(IFS=$'\n' cat brew/cask-list))

for app in "${caskapps[@]}"; do
    echo "> brew cask install $app"
    brew cask install "$app"
done
