vim.g.mapleader = ' '

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set('i', 'jj', '<ESC>', { noremap = true })

-- greatest remap ever
vim.keymap.set("x", "<leader>p", [["_dp]])

-- use C-C to vertically complete
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- -- increment/decrement
-- vim.keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
-- vim.keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })


-- splits
vim.keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split vim vertically" })
vim.keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split vim horizontally" })
vim.keymap.set("n", "<leader>se", "<C-w>=", { desc = "Make splits equal size" })
vim.keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })
vim.keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
vim.keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
vim.keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
vim.keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in a new tab" })

-- replace all occurencies under the cursor
vim.keymap.set("n", "<leader>sk", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
    { desc = "Replace all occurencies under the cursor" })

-- make me runnable and hot as chilly peper
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make current file runnable" })

-- golang shortcuts
vim.keymap.set(
    "n",
    "<leader>ee",
    "oif err != nil {<CR>}<Esc>Oreturn err<Esc>"
)

-- vim.keymap.set("n", "<leader>gd", "<Plug>(coc-definition)")
-- vim.keymap.set("n", "<leader>gy", "<Plug>(coc-type-definition)")
