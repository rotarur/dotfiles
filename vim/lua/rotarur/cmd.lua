--- gopls
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*.go",
    callback = function()
        local params = vim.lsp.util.make_range_params()
        params.context = { only = { "source.organizeImports" } }
        -- buf_request_sync defaults to a 1000ms timeout. Depending on your
        -- machine and codebase, you may want longer. Add an additional
        -- argument after params if you find that you have to write the file
        -- twice for changes to be saved.
        -- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
        for cid, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
                if r.edit then
                    local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                    vim.lsp.util.apply_workspace_edit(r.edit, enc)
                end
            end
        end
        vim.lsp.buf.format({ async = false })
    end
})

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'Enable inlay hints',
    callback = function(event)
        local id = vim.tbl_get(event, 'data', 'client_id')
        local client = id and vim.lsp.get_client_by_id(id)
        if client == nil or not client.supports_method('textDocument/inlayHint') then
            return
        end

        vim.lsp.inlay_hint.enable(true, { bufnr = event.buf })
    end,
})

-- vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', { noremap = true })
-- vim.api.nvim_set_keymap('n', '<CR>', '<cmd>FineCmdline<CR>', { noremap = true })
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

-- vim.keymap.del('<c-b>l')
-- vim.keymap.set('n', '<c-b>l', ':TmuxNavigateRight<CR>', {
--     silent = true, buffer = true
-- })
-- vim.keymap.set('n', '<c-b>h', ':TmuxNavigateLeft<CR>', {
--     silent = true, buffer = true
-- })
