--[[ Remove the trailing space and null lines on write ]]
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})

vim.api.nvim_create_autocmd({ "BufReadPost" }, {
    pattern = { "*" },
    command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]]
})

-- [[ Add newline at EOF ]]
vim.cmd [[
  augroup AddNewlineAtEOF
    autocmd!
    autocmd BufWritePre * lua local lines = vim.api.nvim_buf_get_lines(0, -2, -1, false) if lines[#lines] ~= '' and lines[#lines]:sub(-1) ~= '\n' then vim.api.nvim_buf_set_lines(0, -1, -1, false, {''}) end
    augroup END
]]

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})
