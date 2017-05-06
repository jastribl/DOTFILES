# !/bin/bash

echo "---------- installing dotfiles ----------"

files="bashrc vimrc zshrc gitconfig gitignore_global tmux.conf"

dotfileDir="$PWD/dotfiles"
backupDir="$PWD/dotfiles_old/backup_$(date +%Y-%m-%d:%H:%M:%S)"

mkdir -p $backupDir

cd $dotfileDir

for file in $files; do
    echo "> mv ~/.$file $backupDir/"
    mv ~/.$file $backupDir/
    echo "> ln -s $dotfileDir/$file ~/.$file"
    ln -s $dotfileDir/$file ~/.$file
done

touch ~/.hushlogin
