#!/bin/bash

echo "Creating neovim folders and undodir"
nvimfolder=~/.config/nvim

mkdir -p $nvimfolder/undodir
ln -s ~/.dotfiles/vim/init.vim $nvimfolder/

vim +PluginInstall +qall
