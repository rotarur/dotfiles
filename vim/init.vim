" vim:set foldmethod=marker foldlevel=0
" LEGEND ------------------------------------------------ {{{
" <s-tab> = Shift + Tab
" <c-p> = Control + p
" <leader>n - enable nohighlight
" jj - in edit mode works like Escape
" Folding:
" zo - open a single fold under the cursor
" zc - close the fold under the cursor
" zR - open all folds
" zM - close all folds
" }}}

" autoinstall vim-plug ---------------------------------- {{{
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
   silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
" }}}

" vim-plug ---------------------------------------------- {{{
call plug#begin(stdpath('data') . '/plugged')

" colors ------------------------------------------------ {{{
filetype plugin indent on
" let $NVIM_TUI_ENABLE_TRUE_COLOR=1
syntax on " Syntax highlighting
" }}}

" remove trailing spaces and null lines on write -------- {{{
autocmd BufWritePre * :%s/\s\+$//e
autocmd BufWritePre * :retab
" }}}

" ENCODING ---------------------------------------------- {{{
set encoding=utf-8  " The encoding displayed.
set fileencoding=utf-8  " The encoding written to file
" }}}

" SPACES ------------------------------------------------ {{{
" Autotabs for certain code
set smarttab
" show existing tab with 3 spaces width
set tabstop=3
set list
set listchars=tab:\ \ ,trail:·
" when indenting with '>', use 3 spaces width
set shiftwidth=3
" on pressing tab, insert 3 spaces
set expandtab
" copy indent from the previous line
set copyindent
" round indent to a multiple of 'shiftwidth'
set shiftround
" }}}

" TABS -------------------------------------------------- {{{
" use Shift H or Shift L to change tabs
nnoremap H gT
nnoremap L gt
" auto indent between brackets
inoremap ( ()<Esc>:let leavechar=")"<CR>i
inoremap { {}<Esc>:let leavechar="}"<CR>i
inoremap [ []<Esc>:let leavechar="]"<CR>i
imap <C-j> <Esc>:exec "normal f" . leavechar<CR>a

nnoremap tt :tabnew<CR>
" }}}

set backspace=indent,eol,start " make backspace behave in a sane manner

" CLIPBOARD --------------------------------------------- {{{
set clipboard+=unnamedplus
" }}}

" UI CONFIG --------------------------------------------- {{{
set wrap
set wrapmargin=8 " wrap lines when coming within n characters from side
set linebreak " set soft wrapping
set showbreak=↪
set autoindent " automatically set indent of new line
set noerrorbells
set visualbell
set diffopt+=vertical,iwhite,internal,algorithm:patience,hiddenoff
set hidden                   " current buffer can be put into background
set number                   " show line number
set showcmd                  " show command in bottom bar
set cursorline               " highlight current line
set so=7                     " set 7 lines to the cursors - when moving vertical
set wildmenu                 " visual autocomplete for command menu
set wildmode=list:longest    " complete files like a shell
set shell=$SHELL
set showmatch                " highlight matching brace
set laststatus=2             " window will always have a status line
set cmdheight=1
set title                    " set terminal title
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
set inccommand=nosplit
set relativenumber
set rnu
set colorcolumn=120
" set signcolumn=number         " merge sign columns and number column into one
" }}}

" SEARCH ------------------------------------------------ {{{
set incsearch  " search as characters are entered
set nohlsearch
set smartcase  " ignore case if search pattern is lower case
" case-sensitive otherwise
set magic      " set magic on, for regex
"nmap <space> /
" }}}

" unmap <A-3>

" FILETYPE CONFIGURATIONS ------------------------------- {{{
autocmd FileType yaml setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType go setlocal shiftwidth=3 softtabstop=3 noexpandtab
autocmd FileType yml setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType tf setlocal shiftwidth=2 softtabstop=2 expandtab
autocmd FileType json setlocal shiftwidth=3 softtabstop=3 expandtab
autocmd FileType dockerfile setlocal shiftwidth=1 softtabstop=1 expandtab
" }}}

" SPLIT ------------------------------------------------- {{{
" Use ctrl-[hjkl] to select the active split
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>
" You can split the window in Vim by typing :split or :vsplit.

" You can split a window into sections by typing `:split` or `:vsplit`.
" Display cursorline and cursorcolumn ONLY in active window.
augroup cursor_off
   autocmd!
   autocmd WinLeave * set nocursorline nocursorcolumn
   autocmd WinEnter * set cursorline cursorcolumn
augroup END
" }}}

" disable highlight ------------------------------------- {{{
nmap <leader>n :noh<cr>
" }}}

" Uncomment the following to have Vim jump to the last position when
" reopening a file
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Leader & Mappings {{{
let mapleader=","   " leader is comma

" insert blank line before current line without leaving insert mode
imap <leader>o <c-o><s-o>

" fix indentation
nnoremap <leader>i mzgg=G`z<CR>
" }}}

" buffers
noremap <tab> :bn<CR>
nnoremap <s-tab> :bp<CR>
nnoremap <leader>bd :bd<CR>
map <leader>l :let @*=expand("%")<CR>

" EDIT MODE --------------------------------------------- {{{
" shortcut to save
nmap <leader>, :w<cr>
nmap <leader>w :w<CR>
nmap <leader>x :x<CR>
nmap <leader>q :q<CR>

inoremap jj <esc>
" unmap J
" }}}

" NORMAL MODE ------------------------------------------- {{{
" Press \\ to jump back to the last cursor position.
nnoremap <leader>\ ``
" Press the space bar to type the : character in command mode.
nnoremap <space> :
" }}}

" edit ~/.config/nvim/init.vim
map <leader>ev :e! ~/.config/nvim/init.vim<cr>

" edit gitconfig
map <leader>eg :e! ~/.gitconfig<cr>

" fast header source switch
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>

" gruvbox ----------------------------------------------- {{{
Plug 'morhetz/gruvbox'

autocmd vimenter * ++nested colorscheme gruvbox

let g:gruvbox_italic=1

" enable 24 bit color support if supported
if (has("termguicolors"))
   if (!(has("nvim")))
      let $NVIM_TUI_ENABLE_TRUE_COLOR=1
   endif
   set termguicolors
endif

augroup spellcheck_colors
   autocmd!
   autocmd ColorScheme gruvbox hi SpellBad cterm=underline ctermfg=red
augroup END
" }}}

" nerdcommenter ----------------------------------------- {{{
Plug 'preservim/nerdcommenter'

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

map <leader>d <Plug>NERDCommenterToggle
" }}}

" airline ----------------------------------------------- {{{
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

let g:airline_theme='simple'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#ale#enabled = 1

let g:airline_powerline_fonts = 1
let g:indentLine_showFirstIndentLevel = 0
let g:indentLine_setColors = 0
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
" }}}

" UltiSnips --------------------------------------------- {{{
Plug 'SirVer/ultisnips' " Snippets plugin
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'

let g:UltiSnipsExpandTrigger="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
" }}}

" tpope/vim-pathogen ------------------------------------ {{{
" Plug 'tpope/vim-pathogen'
" disable all linters as that is taken care of by coc.nvim
" let g:go_diagnostics_enabled = 0
" let g:go_metalinter_enabled = []
"
" " don't jump to errors after metalinter is invoked
" let g:go_jump_to_error = 0
"
" " automatically highlight variable your cursor is on
" let g:go_auto_sameids = 0
"
" let g:go_fmt_autosave=1
" " let g:go_asmfmt_autosave=0
" let g:go_fmt_command = "goimports"
" let g:go_auto_type_info = 1
"
" " syntax highlight
" let g:go_highlight_types = 1
" let g:go_highlight_fields = 1
" let g:go_highlight_functions = 1
" let g:go_highlight_function_calls = 1
" let g:go_highlight_operators = 1
" let g:go_highlight_extra_types = 1
" let g:go_highlight_build_constraints = 1
" let g:go_highlight_generate_tags = 1
" }}}

" coc --------------------------------------------------- {{{
Plug 'neoclide/coc.nvim', {'branch': 'release'}

let g:coc_global_extensions = [
         \ 'coc-css',
         \ 'coc-json',
         \ 'coc-tsserver',
         \ 'coc-eslint',
         \ 'coc-tslint-plugin',
         \ 'coc-pairs',
         \ 'coc-git',
         \ 'coc-sh',
         \ 'coc-vimlsp',
         \ 'coc-emmet',
         \ 'coc-ultisnips',
         \ 'coc-diagnostic',
         \ 'coc-yaml',
         \ 'coc-docker',
         \ 'coc-go',
         \ 'coc-python',
         \ 'coc-markdown-preview-enhanced',
         \ 'coc-webview',
         \ 'coc-rls'
         \ ]

autocmd FileType go nmap gtj :CocCommand go.tags.add json<cr>
autocmd FileType go nmap gty :CocCommand go.tags.add yaml<cr>
autocmd FileType go nmap gtx :CocCommand go.tags.clear<cr>
" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gr <Plug>(coc-references)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <silent>gh <Plug>(coc-doHover)

" Remap for do codeAction of current line
nmap <leader>ac <Plug>(coc-codeaction)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for do action format
nnoremap <silent> F :call CocAction('format')<CR>
" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR :silent call CocAction('runCommand', 'editor.action.organizeImport')

" Organize imports on save
autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

" Remap <C-f> and <C-b> for scroll float windows/popups.
" nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
" nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
" inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
" vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
" vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

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
   elseif (coc#rpc#ready())
      call CocActionAsync('doHover')
   else
      execute '!' . &keywordprg . " " . expand('<cword>')
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
" }}}

" Plug 'norcalli/nvim-colorizer.lua'

" PRODUCTIVITY ------------------------------------------ {{{
" Plug 'wakatime/vim-wakatime'
" Plug 'github/copilot.vim'
" }}}

" nerdtree ---------------------------------------------- {{{
Plug 'preservim/nerdtree'

" mapping
map <C-n> :NERDTreeToggle<CR>

nnoremap <leader>n :NERDTreeFocus<CR>

let NERDTreeHijackNetrw=1
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

let NERDTreeAutoDeleteBuffer = 1

let NERDTreeShowHidden=1
let NERDTreeIgnore = ['\.pyc$', '__pycache__']

let g:nerdtree_tabs_open_on_gui_startup = 1
let g:nerdtree_tabs_autofind = 1

" custom highlight colors
let s:git_orange = 'F54D27'

let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange " sets the color for .gitignore files

" Close on open
" let NERDTreeQuitOnOpen=1

" open in tab
let NERDTreeCustomOpenArgs={'file':{'where': 't'}}

" prevent opening the same file
set switchbuf=useopen,usetab

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" " Open nerdtree when vim starts up on opening a directory
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
         \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" " If no file specified open nerdtree
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" dont open nerdtree on opening saved sessions
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") && v:this_session == "" | NERDTree | endif

" NERDTress File highlighting
" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd FileType nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd FileType nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
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
call NERDTreeHighlightFile('tf', '30', 'none', '255', '#151515')
call NERDTreeHighlightFile('go', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('gitignore', 'Gray', 'none', '#686868', '#151515')
" }}}

"nerdtree-git-plugin ------------------------------------ {{{
Plug 'Xuyuanp/nerdtree-git-plugin'
let g:NERDTreeGitStatusShowIgnored = 1
let g:NERDTreeGitStatusUseNerdFonts = 1
" cmap git Git
" }}}

" coc-markdown-preview-enhanced ------------------------- {{{
cabbrev markdownpreview 'CocCommand markdown-preview-enhanced.openPreview'
" }}}

" fzf --------------------------------------------------- {{{
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

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

nnoremap <c-p> :Files<CR>
nnoremap <leader>f :Ag<CR>

let g:fzf_action = {
         \ 'return': 'tab split',
         \ 'ctrl-j': 'split',
         \ 'ctrl-k': 'vsplit' }
" }}}

" Plug 'rking/ag.vim'
" Plug 'mileszs/ack.vim'

" git --------------------------------------------------- {{{
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

nmap <silent> <leader>gs :Git status<cr>
nmap <leader>gp :Git push<cr>
nmap <leader>gh :Git rebase<cr>
nmap <leader>gi :Git rebase -i<cr>
nmap <leader>ge :Git edit<cr>
nmap <silent><leader>gr :Git read<cr>
nmap <silent><leader>gb :Git blame<cr>
nmap <silent><leader>g :Git<cr>
" }}}

" " markdown {{{
" Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
"
" " set to 1, nvim will open the preview window after entering the markdown buffer
" " default: 0
" let g:mkdp_auto_start = 0
"
" " set to 1, the nvim will auto close current preview window when change
" " from markdown buffer to another buffer
" " default: 1
" let g:mkdp_auto_close = 0
"
" " set to 1, the vim will refresh markdown when save the buffer or
" " leave from insert mode, default 0 is auto refresh markdown as you edit or
" " move the cursor
" " default: 0
" let g:mkdp_refresh_slow = 0
"
" " set to 1, the MarkdownPreview command can be use for all files,
" " by default it can be use in markdown file
" " default: 0
" let g:mkdp_command_for_global = 0
"
" " specify browser to open preview page
" " default: 'Google Chrome'
" " let g:mkdp_browser = ''
"
" " let g:mkdp_browser = "/Applications/Google\\ Chrome.app/Contents/MacOS/Google\\ Chrome"
"
" let g:mkdp_preview_options = {
"     \ 'mkit': {},
"     \ 'katex': {},
"     \ 'uml': {},
"     \ 'maid': {},
"     \ 'disable_sync_scroll': 0,
"     \ 'sync_scroll_type': 'middle',
"     \ 'hide_yaml_meta': 1,
"     \ 'sequence_diagrams': {},
"     \ 'flowchart_diagrams': {},
"     \ 'content_editable': v:false
"     \ }
"
" " preview page title
" " ${name} will be replace with the file name
" let g:mkdp_page_title = '「${name}」'
" " }}}

" Terraform --------------------------------------------- {{{
Plug 'hashivim/vim-terraform'
let g:terraform_align=1
let g:terraform_fmt_on_save=1
" }}}

" dense-analysis/ale ------------------------------------ {{{
Plug 'dense-analysis/ale'

let g:ale_completion_enabled = 1
let g:ale_linters_explicit = 1
" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 1
let g:ale_linters = {
         \ 'go': ["golint"],
         \ 'php': ['phpstan'],
         \ 'javascript': ['eslint']
         \ }
let g:ale_fixers = {
         \ 'go': ["gofmt", "goimports"],
         \ 'javascript': ['prettier', 'eslint'],
         \ '*': ['remove_trailing_lines', 'trim_whitespace'],
         \ }
" }}}

Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1
Plug 'powerline/fonts'

" ryanoasis/vim-devicons ------------------------------- {{{
Plug 'ryanoasis/vim-devicons'

let g:WebDevIconsUnicodeDecorateFileNodesDefaultSymbol='x'
" autocmd BufNewFile,BufRead *.v,*.vs set syntax=verilog
"get rid of [  ] around icons in NerdTree
syntax enable
if exists("g:loaded_webdevicons")
   call webdevicons#refresh()
endif
" }}}

Plug 'vim-utils/vim-man'
" Plug 'tpope/vim-surround'
" Plug 'dkprice/vim-easygrep'

" highlight conflicts
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'

" function! TrimWhiteSpace()
"    %s/\s\+$//e
" endfunction
" autocmd BufWritePre * :call TrimWhiteSpace()

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

" Close [No Name] tabs
nnoremap <silent> ,C :call CleanNoNameEmptyBuffers()<CR>

" VIMSCRIPT -------------------------------------------------------------- {{{
" " This will enable code folding.
" Use the marker method of folding.
augroup filetype_vim
   autocmd!
   autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

call plug#end()
" }}} vim-plug
