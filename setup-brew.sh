#!/usr/bin/env bash

echo "---------- installing brew stuff ----------"

if ! which brew > /dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

IFS=$'\n' # split on newline
apps=($(cat brew/brew-list))

for app in "${apps[@]}"; do
    echo "> brew install $app"
    brew install "$app"
done

IFS=$'\n' # split on newline
caskapps=($(cat brew/cask-list))

for app in "${caskapps[@]}"; do
    echo "brew cask install $app"
    brew cask install "$app"
done
