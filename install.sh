#!/bin/sh
sudo ehco "start install base tools..."
sudo apt-get install ssh
sudo apt-get install vim
sudo apt-get install gcc
sudo apt-get install make
sudo apt-get install clang
sudo apt-get install p7zip-full
sudo apt-get install lzop
sudo apt-get install lib32z1
#sudo apt-get install lib32ncurses5(ubuntu20应该是libncurses6)
sudo apt-get install ctags
sudo apt-get install cscope
sudo apt-get install ripgrep
sudo apt-get install global
sudo apt-get install git
git config --global core.editor “vim”
sudo ln -fs bash  /usr/bin/sh

mkdir ~/.vimplus
git clone https://github.com/xiaoken2openwrt/vimplus.git ~/.vimplus
~/.vimplus/install.sh

#manual install by augus
cp ./downloads/DoxygenToolkit.vim    ~/.vim/plugged/
