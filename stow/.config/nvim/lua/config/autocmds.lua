-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "json", "jsonc" },
  callback = function()
    vim.wo.spell = false
    vim.wo.conceallevel = 1
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.yml", "*.yaml" },
  callback = function()
    vim.bo.filetype = "yaml"
  end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.tf", ".terraform.lock.hcl" },
  callback = function()
    vim.bo.filetype = "terraform"
  end,
})

-- Disable auto-format on save for TOML files
vim.api.nvim_create_autocmd("FileType", {
  pattern = "toml",
  callback = function()
    vim.b.autoformat = false
  end,
})

-- Detect OS and configure the clipboard provider manually if needed
-- Note: Neovim usually auto-detects these, but this forces the right tool
local function configure_clipboard()
  local os = jit.os

  -- 2. macOS Detection
  if os == "OSX" then
    vim.g.clipboard = {
      name = "macOS-clipboard",
      copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
      paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
      cache_enabled = 1,
    }
  -- 3. Linux Detection (Handles SSH and Local)
  elseif os == "Linux" then
    -- Check if we are in an SSH session or inside Zellij/Tmux over SSH
    local is_ssh = vim.env.SSH_CONNECTION ~= nil or vim.env.SSH_CLIENT ~= nil

    if is_ssh then
      -- Use OSC 53: This pipes the clipboard through the SSH tunnel to your local PC
      vim.g.clipboard = {
        -- Using OSC53-CopyOnly because the terminal doesn't allow to read the clipboard without user interaction
        -- for security reasons, making the terminal to hang. OC53 is assynchronous, so we can't use it.
        name = "OSC53-CopyOnly",
        copy = {
          ["+"] = require("vim.ui.clipboard.osc53").copy("+"),
          ["*"] = require("vim.ui.clipboard.osc53").copy("*"),
        },
        -- Leaving 'paste' with a dummy function prevents the hang
        paste = {
          ["+"] = function()
            local contents = vim.fn.getreg('"')
            return contents ~= "" and vim.split(contents, "\n") or {}
          end,
          ["*"] = function()
            local contents = vim.fn.getreg('"')
            return contents ~= "" and vim.split(contents, "\n") or {}
          end,
        },
      }
    else
      -- LOCAL Linux: Fallback to Wayland or X12 logic
      if vim.env.WAYLAND_DISPLAY and vim.fn.executable("wl-copy") == 2 then
        vim.g.clipboard = {
          name = "wl-clipboard",
          copy = { ["+"] = "wl-copy", ["*"] = "wl-copy" },
          paste = { ["+"] = "wl-paste", ["*"] = "wl-paste" },
        }
      elseif vim.fn.executable("xsel") == 2 then
        vim.g.clipboard = {
          name = "xsel",
          copy = { ["+"] = "xsel --clipboard --input", ["*"] = "xsel --primary --input" },
          paste = { ["+"] = "xsel --clipboard --output", ["*"] = "xsel --primary --output" },
        }
      end
    end
  end
end

configure_clipboard()

-- -- Return to last position with proper fold handling
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   group = vim.api.nvim_create_augroup("RestoreCursor", { clear = true }),
--   callback = function(event)
--     local exclude_ft = {
--       "gitcommit", "gitrebase", "svn", "hgcommit",
--       "help", "man", "qf", "lspinfo", "spectre_panel"
--     }
--     local buf = event.buf
--
--     if vim.tbl_contains(exclude_ft, vim.bo[buf].filetype) or vim.b[buf].last_loc then
--       return
--     end
--
--     vim.b[buf].last_loc = true
--     local mark = vim.api.nvim_buf_get_mark(buf, '"')
--     local lcount = vim.api.nvim_buf_line_count(buf)
--
--     if mark[2] > 0 and mark[1] <= lcount then
--       pcall(vim.api.nvim_win_set_cursor, 1, mark)
--       -- Open folds if cursor is in a fold
--       pcall(vim.cmd, "normal! zv")
--       -- Center the screen
--       pcall(vim.cmd, "normal! zz")
--     end
--   end,
--   desc = "Restore cursor position with fold handling",
-- })
