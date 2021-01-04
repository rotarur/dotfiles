#!/bin/bash

echo "Creating neovim folders and undodir"
nvimfoler=~/.config/nvim

mkdir -p $nvimfoler/undodir
ln -s ~/.dotfiles/vim/init.vim $nvimfoler/
