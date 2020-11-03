" vim:foldmethod=marker:foldlevel=0

" vim-plug {{{
call plug#begin(stdpath('data') . '/plugged')

" Syle
Plug 'morhetz/gruvbox'
"Plug 'jiangmiao/auto-pairs'
Plug 'preservim/nerdcommenter'

Plug 'vim-utils/vim-man'
" Plug 'dkprice/vim-easygrep'

Plug 'powerline/fonts'
Plug 'ryanoasis/vim-devicons'

" better statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

" navigation/search file
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'rking/ag.vim'
" Plug 'mileszs/ack.vim'

Plug 'dense-analysis/ale'

" git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

Plug 'tiagofumo/vim-nerdtree-syntax-highlight'

" markdown
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Terraform
Plug 'hashivim/vim-terraform'

call plug#end()
" }}} vim-plug

" colors {{{
filetype plugin indent on
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
syntax on " Syntax highlighting

autocmd BufWritePre * :%s/\s\+$//e
autocmd BufWritePre * :retab
" }}} colors

" spaces & tabs {{{
set showmatch " Shows matching brackets

set smarttab " Autotabs for certain code

" show existing tab with 3 spaces width
set tabstop=3

set list listchars=tab:\ \ ,trail:·

" when indenting with '>', use 3 spaces width
set shiftwidth=3

" on pressing tab, insert 3 spaces
set expandtab

set autoindent

" copy indent from the previous line
set copyindent
" }}} spaces & tabs

" clipboard {{{
set clipboard+=unnamedplus
" }}} clipboard

" ui config {{{
set wrap
set backspace=indent,eol,start
set noerrorbells
set hidden
set number                   " show line number
set showcmd                  " show command in bottom bar
set cursorline               " highlight current line
set wildmenu                 " visual autocomplete for command menu
set showmatch                " highlight matching brace
set laststatus=2             " window will always have a status line
set cmdheight=2
set nowritebackup
set noswapfile
set nobackup
set undodir=~/.config/nvim/undodir
set undofile
set updatetime=300
set shortmess+=c
set guioptions-=T
set autoread
set path+=**

set encoding=utf8
set spellfile=~/.config/nvim/en.utf-8.add

autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType tf setlocal shiftwidth=2 softtabstop=2 expandtab

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

" disable highlight
nmap <leader>n :noh<cr>
" Uncomment the following to have Vim jump to the last position when
" reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" " Always show the signcolumn, otherwise it would shift the text each time
" " diagnostics appear/become resolved.
" if has("patch-8.1.1564")
"   " Recently vim can merge signcolumn and number column into one
"   set signcolumn=number
" else
"   set signcolumn=yes
" endif

set colorcolumn=120
" }}} ui config

" Search {{{
set incsearch       " search as characters are entered
set hlsearch        " highlight matche
set ignorecase      " ignore case when searching
set smartcase       " ignore case if search pattern is lower case
                    " case-sensitive otherwise
"nmap <space> /
" }}} Search

" Folding {{{
set nofoldenable
set foldlevelstart=10  " default folding level when buffer is opened
set foldnestmax=10     " maximum nested fold
set foldmethod=indent  " fold based on indentation
" }}} Folding

" Leader & Mappings {{{
let mapleader=","   " leader is comma

" fast save and close
nmap <leader>w :w<CR>
nmap <leader>x :x<CR>
nmap <leader>q :q<CR>

" insert blank line before current line without leaving insert mode
imap <leader>o <c-o><s-o>

" fix indentation
nnoremap <leader>i mzgg=G`z<CR>

" turn off search highlights
nnoremap <leader><space> :nohlsearch<CR>

" buffers
nnoremap <tab> :bn<CR>
nnoremap <s-tab> :bp<CR>
nnoremap <leader>bd :bd<CR>

" fast header source switch
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" switch between tabs
"nnoremap <s-pageup>

" }}}

" iamcco/markdown-preview.nvim {{{

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" specify browser to open preview page
" default: ''
let g:mkdp_browser = 'firefox'

let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false
    \ }

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" }}} iamcco/markdown-preview.nvim

" fzf {{{

" Empty value to disable preview window altogether
let g:fzf_preview_window = ''

" Always enable preview window on the right with 60% width
let g:fzf_preview_window = 'right:60%'

" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

" [Commands] --expect expression for directly executing the command
let g:fzf_commands_expect = 'alt-enter,ctrl-x'

" fzf
nnoremap <c-p> :GFiles<CR>

let g:fzf_action = {
  \ 'return': 'tab split',
  \ 'ctrl-j': 'split',
  \ 'ctrl-k': 'vsplit' }
" }}} fzf

" scrooloose/nerdtree {{{

" mapping
map <C-n> :NERDTreeToggle<CR>

let NERDTreeHijackNetrw=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

let NERDTreeAutoDeleteBuffer = 1

ret NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.pyc$', '__pycache__']

let g:nerdtree_tabs_open_on_gui_startup = 0

" prevent opening the same file
set switchbuf=useopen,usetab

" Close vim if only nerdtree opened
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" " Open nerdtree when vim starts up on opening a directory
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" " If no file specified open nerdtree
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" dont open nerdtree on opening saved sessions
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | endif

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

" Close on open
let NERDTreeQuitOnOpen=1

" open in tab
let NERDTreeCustomOpenArgs={'file':{'where': 't'}}
" }}} scrooloose/nerdtree

" Functions {{{
" trailing whitespace
match ErrorMsg '\s\+$'
function! TrimWhiteSpace()
   %s/\s\+$//e
endfunction
autocmd BufWritePre * :call TrimWhiteSpace()

augroup BWCCreateDir
   autocmd!
   autocmd BufWritePre * if expand("<afile>")!~#'^\w\+:/'
      \ && !isdirectory(expand("%:h"))
      \ | execute "silent! !mkdir -p ".shellescape(expand('%:h'), 1)
      \ | redraw! | endif
augroup END

" close all [No Name] files
function! CleanNoNameEmptyBuffers()
   let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val) < 0 && (getbufline(v:val, 1, "$") == [""])')
   if !empty(buffers)
      exe 'bd '.join(buffers, ' ')
   else
      echo 'No buffer deleted'
   endif
endfunction

nnoremap <silent> ,C :call CleanNoNameEmptyBuffers()<CR>

" Xuyuanp/nerdtree-git-plugin {{{
let g:NERDTreeGitStatusShowIgnored = 1

" cmap git Git
" }}} Xuyuanp/nerdtree-git-plugin

" morhetz/gruvbox {{{
colorscheme gruvbox

augroup spellcheck_colors
  autocmd!
  autocmd ColorScheme gruvbox hi SpellBad cterm=underline ctermfg=red
augroup END
" }}} morhetz/gruvbox

" neoclide/coc.nvim {{{
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)

" Remap for do codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)

" Remap for do action format
nnoremap <silent> F :call CocAction('format')<CR>

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" }}} neoclide/coc.nvim

" rking/ag.vim {{{

" let g:ag_working_path_mode="r"

" "  search while typing
" command! -bang -nargs=* Ag
"   \ call fzf#vim#ag(<q-args>,
"   \                 <bang>0 ? fzf#vim#with_preview('up:60%')
"   \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
"   \                 <bang>0)

" set Ag as the grep command
" if executable('ag')
"     " Note we extract the column as well as the file and line number
"     set grepprg=Ag\ --nogroup\ --nocolor\ --column
"     set grepformat=%f:%l:%c%m
"
"     " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
"   let g:ctrlp_user_command = 'Ag %s -l --nocolor -g ""'
"
"   " ag is fast enough that CtrlP doesn't need to cache
"   let g:ctrlp_use_caching = 0
" endif

" cmap ag Ag
" }}} rking/ag.vim

" preservim/nerdcommenter {{{
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1
" }}}

" airline_powerline_fonts {{{
let g:airline_powerline_fonts = 1
let g:ale_completion_enabled = 1
let g:ale_linters_explicit = 1
let g:ale_linters = {
            \ 'go': ["golint"],
            \ 'php': ['phpstan']
            \ }
let g:ale_fixers = {
            \ 'go': ["gofmt", "goimports"]
            \ }
let g:indentLine_showFirstIndentLevel = 0
let g:indentLine_setColors = 0
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" }}}

" if (exists('+colorcolumn'))
"     set colorcolumn=120
"     highlight ColorColumn ctermbg=237
" endif

" Terraform {{{
let g:terraform_align=1
let g:terraform_fmt_on_save=1
" }}}
