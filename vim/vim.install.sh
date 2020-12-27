#!/bin/bash

echo "Creating neovim folders and undodir"
nvimfoler=~/.config/nvim

mkdir -p $nvimfoler/undodir
cp vim/init.vim $nvimfoler/
