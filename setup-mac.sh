# allow key presses to releat on hold in sublime
defaults write -g ApplePressAndHoldEnabled -bool false

defaults write -g InitialKeyRepeat -int 25 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 2 # normal minimum is 2 (30 ms)