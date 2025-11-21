-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("i", "jj", "<Esc>", { noremap = false })
-- vim.api.nvim_set_keymap("n", "J", "mzJ`z", { desc = "Keep cursor in place while appending lines" })

-- Increment / Decrement
keymap.set("n", "+", "<C-a>")
keymap.set("n", "-", "<C-x>")

-- Select all
keymap.set("n", "<C-a>", "gg<S-v>G")

-- Search
keymap.set("n", "<leader>s.", function()
  require("telescope.builtin").grep_string()
end, { desc = "Find word under cursor" })

-- Rename
keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { expr = true })
--
-- Tabs
keymap.set("n", "te", ":tabedit<Return>", opts)
keymap.set("n", "<Tab>", ":BufferLineCycleNext<Return>", opts)
keymap.set("n", "<S-Tab>", ":BufferLineCyclePrev<Return>", opts)

-- Split window
keymap.set("n", "ss", ":split<Return>", opts)
keymap.set("n", "sv", ":vsplit<Return>", opts)

-- Move window keymap.set("n", "mh", "<C-w>h")
keymap.set("n", "mh", "<C-w>h")
keymap.set("n", "ml", "<C-w>l")
keymap.set("n", "mj", "<C-w>j")
keymap.set("n", "mk", "<C-w>k")

-- Diagnostics
keymap.set("n", "<C-j>", function()
  vim.diagnostic.get_next()
end, opts)

--   -- Key mappings for LSP functions
--   vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
--   vim.keymap.set('n', 'gr', vim.lsp.buf.references)
--   vim.keymap.set('n', 'K', vim.lsp.buf.hover)
--   vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename)
--   vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action)
-- end
