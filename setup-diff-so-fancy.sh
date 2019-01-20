# !/bin/bash

echo "---------- installing diff-so-fancy stuff ----------"

if [[ -e ~/diff-so-fancy ]]; then
    rm -rf ~/diff-so-fancy;
fi

mkdir ~/diff-so-fancy
wget -O ~/diff-so-fancy/diff-so-fancy https://raw.githubusercontent.com/so-fancy/diff-so-fancy/master/third_party/build_fatpack/diff-so-fancy
chmod +x ~/diff-so-fancy/diff-so-fancy
