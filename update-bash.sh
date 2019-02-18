#!/usr/bin/env bash

if ! grep -q '/usr/local/bin/bash' /etc/shells; then
    sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells';
fi

if [[ "$SHELL" != /usr/local/bin/bash ]]; then
    echo "---------- setting default shell to bash 4 ----------"
    chsh -s /usr/local/bin/bash
fi
