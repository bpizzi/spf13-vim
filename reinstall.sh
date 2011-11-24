#!/bin/env sh
endpath="$HOME/.spf13-vim-3"

# Backup existing .vim stuff
echo "backing up current vim config\n"
today=`date +%Y%m%d`
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc; do [ -e $i ] && mv $i $i.$today; done

echo "Making links \n"
mkdir -p $endpath/.vim/bundle
ln -s $endpath/.vimrc $HOME/.vimrc
ln -s $endpath/.vim $HOME/.vim

echo "Installing Vundle"
git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle

echo "installing plugins using Vundle"
vim +BundleInstall! +BundleClean +q

# Build command-t for your system
echo "building command-t executable\n"
echo "command-t depends on ruby and rake to be present\n"
cd $HOME/.vim/bundle/Command-T
(rake make) || warn "Ruby compilation failed. Ruby, GCC or rake not installed?"

