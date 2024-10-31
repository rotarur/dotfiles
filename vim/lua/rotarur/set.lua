vim.opt.guicursor = ''

vim.opt.mouse = 'a'

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.clipboard = 'unnamed'

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.wrap = true

vim.opt.completeopt = 'menu,menuone,noinsert,noselect,preview'

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. '/.config/nvim/undodir'

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = 'yes'
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.wildmenu = true
vim.opt.wildmode = 'longest:full,full'
-- vim.opt.colorcolumn = "80"
vim.g.vimspector_enable_mappings = 'HUMAN'
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

vim.g.tmux_navigator_no_wrap = 1
