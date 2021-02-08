#!/bin/bash

echo "Creating neovim folders and undodir"
nvimfoler=~/.config/nvim

mkdir -p $nvimfoler/undodir
ln -s ~/.dotfiles/vim/init.vim $nvimfoler/

vim +PluginInstall +qall
vim +'CocInstall coc-json coc-tsserver coc-pairs coc-yaml coc-docker coc-go coc-python'
