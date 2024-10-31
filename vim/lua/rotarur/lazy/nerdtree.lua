return {
    'preservim/nerdtree',

    config = function()
        vim.keymap.set("n", "<leader>n", ":NERDTreeFocus<CR>")
        -- vim.keymap.set("n", "<C-n>", ":NERDTree<CR>")
        vim.keymap.set("n", "<C-t>", ":NERDTreeToggle<CR>")
        vim.keymap.set("n", "<C-f>", ":NERDTreeFind<CR>")

        -- -- Start NERDTree when Vim is started without file arguments.
        -- vim.cmd('autocmd StdinReadPre * let s:std_in=1')
        -- vim.cmd('autocmd VimEnter * if argc() == 0 && !exists(\'s:std_in\') | NERDTree | endif')

        -- Start NERDTree when Vim starts with a directory argument.
        vim.cmd('autocmd StdinReadPre * let s:std_in=1')
        vim.cmd(
            'autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists(\'s:std_in\') | execute \'NERDTree\' argv()[0] | wincmd p | enew | execute \'cd \'.argv()[0] | endif')
        -- Exit Vim if NERDTree is the only window remaining in the only tab.
        vim.cmd(
            'autocmd BufEnter * if tabpagenr(\'$\') == 1 && winnr(\'$\') == 1 && exists(\'b:NERDTree\') && b:NERDTree.isTabTree() | call feedkeys(":quit\\<CR>:\\<BS>") | endif ')

        -- Close the tab if NERDTree is the only window remaining in it.
        vim.cmd(
            'autocmd BufEnter * if winnr(\'$\') == 1 && exists(\'b:NERDTree\') && b:NERDTree.isTabTree() | call feedkeys(":quit\\<CR>:\\<BS>") | endif')

        -- Mirror the NERDTree before showing it. This makes it the same on all tabs.
        vim.keymap.set("n", "<C-n>", ":NERDTreeMirror<CR>:NERDTreeFocus<CR>")

        -- If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
        vim.cmd(
            'autocmd BufEnter * if winnr() == winnr("h") && bufname("#") =~ "NERD_tree_\\d\\+" && bufname("%") !~ "NERD_tree_\\d\\+" && winnr("$") > 1 | let buf=bufnr() | buffer# | execute "normal! \\<C-W>w" | execute "buffer".buf | endif'
        )
    end
}
