# !/bin/bash

echo "---------- installing brew stuff ----------"

if ! which brew > /dev/null; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
    brew update
fi

apps=(gcc
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
)

for app in "${apps[@]}"; do
    echo "> brew install $app"
    brew install $app
done

echo "---------- getting oh my zsh ----------"
curl -L https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | sh

echo "---------- setting default shell ----------"
chsh -s $(which zsh)
