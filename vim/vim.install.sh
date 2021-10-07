#!/bin/bash

echo "Creating neovim folders and undodir"
nvimfolder=~/.config/nvim

mkdir -p $nvimfolder/undodir
ln -s ~/.dotfiles/vim/init.vim $nvimfolder/

nvim -es -u init.vim -i NONE -c "PlugInstall" -c "qa"
