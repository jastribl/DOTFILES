# !/bin/bash

echo "---------- setting default shell to bash 4 ----------"
if ! grep -q '/usr/local/bin/bash' /etc/shells; then
    sudo bash -c 'echo /usr/local/bin/bash >> /etc/shells';
fi
chsh -s /usr/local/bin/bash
