#!/bin/sh
sudo ehco "start install base tools..."
sudo apt-get install python2.7-dev       #(ubuntu22.04 or higher version  default no python2,so must manual install it)
sudo apt-get install pkg-config
sudo apt-get install ssh
sudo apt-get install vim
sudo apt-get install curl
sudo apt-get install dos2unix
sudo apt-get install gcc
sudo apt-get install make
sudo apt-get install uuid-dev
sudo apt-get install mtd-utils
sudo apt-get install u-boot-tools
sudo apt-get install clang
sudo apt-get install p7zip-full
sudo apt-get install lzop
sudo apt-get install libreadline-dev #
sudo apt install libarchive-zip-perl #include crc32 tools
sudo apt-get install lib32z1
#sudo apt-get install lib32ncurses5(ubuntu20应该是libncurses6)
sudo apt-get install libncursesw5
sudo apt-get install clang-format-10 #(ubuntu22.04 or higher version must compile install it)
sudo ln -s /usr/bin/clang-format-10 /usr/bin/clang-format
sudo apt-get install ctags
sudo apt-get install cscope
sudo apt-get install doxygen
sudo apt-get install ripgrep
sudo apt-get install global
sudo apt-get install flex
sudo apt-get install bison
sudo apt-get install git
sudo apt-get install manpages-posix manpages-posix-dev
git config --global core.editor “vim”
sudo ln -fs bash  /usr/bin/sh

mkdir ~/.vimplus
git clone https://github.com/xiaoken2openwrt/vimplus.git ~/.vimplus
pushd ~/.vimplus/
./install.sh
popd

#manual install by augus
cp ./downloads/DoxygenToolkit.vim    ~/.vim/plugged/
mkdir  ~/.vim/syntax
cp ./downloads/c.vim    ~/.vim/syntax
