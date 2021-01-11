# Check if we have it already
if [[ $(fc-list | grep -i "Powerline.ttf") ]]; then
    echo "Font already installed"
    exit
fi

# clone
git clone https://github.com/powerline/fonts.git --depth=1
# install
cd fonts
./install.sh
# clean-up a bit
cd ..
rm -rf fonts
