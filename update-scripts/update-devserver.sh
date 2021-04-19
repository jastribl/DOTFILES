#!/usr/bin/env bash


# Hacky check to see if we're on a fb machine
if ! which fbclone > /dev/null; then
    echo "Not on FB machine, moving on"
    exit 0
fi

if [[ $(uname -s) == "Darwin" ]]; then
    echo "On OSX, moving on"
    exit 0
fi

sudo --list | grep '(ALL) NOPASSWD: ALL' &> /dev/null
if [ $? != 0 ]; then
    echo "Unable to install/update things on devserver; moving on"
    exit 0
fi

apps=(
    the_silver_searcher
    fb-vim
    cmake
)

if which yum > /dev/null; then
    pk_man='yum'
else
    pk_man='dnf'
fi

echo "a is"
echo $a
for app in "${apps[@]}"; do
    if $pk_man list installed "$app" >/dev/null 2>&1; then
        sudo $pk_man upgrade $app
    else
        sudo $pk_man install -y $app
    fi
done
