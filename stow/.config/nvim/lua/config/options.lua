-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
local opt = vim.opt
-- local g = vim.g
local filetype = vim.filetype

-- Save more info in viminfo/shada file
opt.shada = "'1000,<50,s10,h" -- Remember more files, lines, etc.
opt.undolevels = 1000
opt.undoreload = 10000
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.clipboard = "unnamedplus"
-- opt.ligatures = false
-- g.filetype = "on"
