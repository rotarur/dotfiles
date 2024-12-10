local opt = vim.opt
local o = vim.o
local g = vim.g

-------------------------------------- options ------------------------------------------

o.showmode = false
o.laststatus = 3

opt.guicursor = ''

o.mouse = 'a'

opt.nu = true
opt.relativenumber = true

o.clipboard = 'unnamed'
o.cursorline = true
o.cursorlineopt = "number"

-- Indentation
o.tabstop = 2
o.softtabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.smartindent = true
o.autoindent = true

-- Numbers
o.number = true
o.numberwidth = 2
o.ruler = false

-- disable nvim intro
opt.shortmess:append "sI"

opt.wrap = true

opt.completeopt = 'menu,menuone,noinsert,noselect,preview'

opt.swapfile = false
opt.backup = false
o.undofile = true
o.undodir = os.getenv("HOME") .. '/.config/nvim/undodir'

opt.hlsearch = false
opt.incsearch = true

o.ignorecase = true
o.smartcase = true

opt.termguicolors = true

o.signcolumn = 'yes'
o.splitbelow = true
o.splitright = true
o.timeoutlen = 400

opt.scrolloff = 8
opt.isfname:append("@-@")

-- interval for writing swap file to disk, also used by gitsigns
o.updatetime = 250

opt.wildmenu = true
opt.wildmode = 'longest:full,full'
-- opt.colorcolumn = "80"
g.vimspector_enable_mappings = 'HUMAN'
o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

g.tmux_navigator_no_wrap = 1

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

-- disable some default providers
g.loaded_node_provider = 0
g.loaded_python3_provider = 0
g.loaded_perl_provider = 0
g.loaded_ruby_provider = 0
