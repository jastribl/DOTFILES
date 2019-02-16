# todo: add checks so these only run sometimes
# todo: add some default versions of some files (latex, gitignore, clang-format, etc.)
# todo: add script to deploy dotfiles (saving previous preferences)

# vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +PlugUpdate +PlugClean! +qall

# directory cleaning
rm -f ~/Desktop/.DS_Store
NUM_FILES=$(find ~/Desktop/ -depth 1 | wc -l)
if [ ! $NUM_FILES = 0 ]; then
    echo "Warning: Clean up your Desktop directory!"
fi

rm -f ~/Github/.DS_Store
NUM_FILES=$(find ~/GitHub/ -depth 1 -type f | wc -l)
if [ ! $NUM_FILES = 0 ]; then
    echo "Warning: Clean up your GitHub directory!"
fi

./brew-dep-analysis.py
