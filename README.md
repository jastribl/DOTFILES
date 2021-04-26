# DOTFILES
A collection of my DOTFILES and other development settings

## Quick Setup
```
cd ~ && mkdir -p Github && cd Github && env $(fwdproxy-config --format=sh curl) wget -O dotfiles.zip "https://github.com/jastribl/DOTFILES/archive/refs/heads/master.zip" && unzip dotfiles.zip && mv DOTFILES-master DOTFILES && rm dotfiles.zip && cd DOTFILES && ./update.sh
 ```
