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
    vim.wo.conceallevel = 0
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

-- Ensure exactly one trailing blank line on save (collapse duplicates, add if missing).
-- Deferred so it registers after LazyVim's format-on-save hook and therefore runs
-- *after* the formatter, which would otherwise strip the blank line back out.
vim.schedule(function()
  vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
      if vim.bo.buftype ~= "" then
        return
      end
      local buf = 0
      local n = vim.api.nvim_buf_line_count(buf)
      local last = n
      while last > 0 and vim.api.nvim_buf_get_lines(buf, last - 1, last, false)[1] == "" do
        last = last - 1
      end
      if last == 0 then
        return -- buffer is entirely blank, leave it alone
      end
      if last ~= n - 1 then
        vim.api.nvim_buf_set_lines(buf, last, n, false, { "" })
      end
    end,
    desc = "Ensure exactly one trailing blank line on save",
  })
end)

-- Detect OS and configure the clipboard provider manually if needed
-- Note: Neovim usually auto-detects these, but this forces the right tool
local function configure_clipboard()
  local os = jit.os

  -- 1. macOS Detection
  if os == "OSX" then
    vim.g.clipboard = {
      name = "macOS-clipboard",
      copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
      paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
      cache_enabled = 0,
    }
  -- 2. Linux Detection (Handles SSH and Local)
  elseif os == "Linux" then
    -- Check if we are in an SSH session or inside Zellij/Tmux over SSH
    local is_ssh = vim.env.SSH_CONNECTION ~= nil or vim.env.SSH_CLIENT ~= nil

    if is_ssh then
      -- Copy via OSC 52 (forwarded by tmux to the outer terminal's clipboard).
      -- Paste via `tmux save-buffer -` when inside tmux, so yanks made in one
      -- nvim instance are visible from another nvim in a different split.
      -- Falls back to a per-process cache + register 0 outside tmux.
      local in_tmux = vim.env.TMUX ~= nil
      local ssh_clipboard = { ["+"] = nil, ["*"] = nil }
      local osc52_copy_plus = require("vim.ui.clipboard.osc52").copy("+")
      local osc52_copy_star = require("vim.ui.clipboard.osc52").copy("*")

      -- Sidecar file shares {lines, regtype} across Neovim instances on this host,
      -- because tmux's paste buffer alone can't carry regtype.
      local cache_dir = vim.env.XDG_RUNTIME_DIR or vim.fn.stdpath("cache")
      local cache_file = cache_dir .. "/nvim-clipboard.json"

      local function read_file_cache()
        local f = io.open(cache_file, "r")
        if not f then return {} end
        local content = f:read("*a")
        f:close()
        local ok, data = pcall(vim.json.decode, content)
        return (ok and type(data) == "table") and data or {}
      end

      local function write_file_cache(reg, lines, regtype)
        local data = read_file_cache()
        data[reg] = { lines = lines, regtype = regtype }
        local f = io.open(cache_file, "w")
        if f then
          f:write(vim.json.encode(data))
          f:close()
        end
      end

      local function trim_trailing_empty(lines)
        local last = #lines
        while last > 0 and lines[last] == "" do
          last = last - 1
        end
        return last
      end

      local function lines_equal(a, b)
        local la = trim_trailing_empty(a)
        local lb = trim_trailing_empty(b)
        if la ~= lb then return false end
        for i = 1, la do
          if a[i] ~= b[i] then return false end
        end
        return true
      end

      local function tmux_paste()
        local out = vim.fn.systemlist("tmux save-buffer -")
        if vim.v.shell_error ~= 0 then return nil end
        return out
      end

      local function make_copy(reg, osc52_fn)
        return function(lines, regtype)
          ssh_clipboard[reg] = { lines, regtype }
          write_file_cache(reg, lines, regtype)
          osc52_fn(lines, regtype)
        end
      end

      local function make_paste(reg)
        return function()
          local tmux_lines = in_tmux and tmux_paste() or nil

          local cache
          local file_entry = read_file_cache()[reg]
          if file_entry then
            cache = { file_entry.lines, file_entry.regtype }
          elseif ssh_clipboard[reg] then
            cache = ssh_clipboard[reg]
          end

          if tmux_lines and #tmux_lines > 0 then
            -- tmux content matches our cache → reuse the cached regtype.
            if cache and lines_equal(tmux_lines, cache[1]) then
              return cache
            end
            -- Otherwise tmux holds something we didn't yank (external paste) — use it as-is.
            return tmux_lines
          end

          if cache then return cache end
          return vim.split(vim.fn.getreg("0"), "\n")
        end
      end

      vim.g.clipboard = {
        name = "OSC52",
        copy = {
          ["+"] = make_copy("+", osc52_copy_plus),
          ["*"] = make_copy("*", osc52_copy_star),
        },
        paste = {
          ["+"] = make_paste("+"),
          ["*"] = make_paste("*"),
        },
      }
    else
      -- LOCAL Linux: Fallback to Wayland or X11 logic
      if vim.env.WAYLAND_DISPLAY and vim.fn.executable("wl-copy") == 1 then
        local function wl_paste(args)
          return function()
            local result = vim.fn.system("wl-paste --no-newline " .. args .. " 2>/dev/null")
            if vim.v.shell_error ~= 0 then return {} end
            return vim.split(result, "\n", { plain = true })
          end
        end
        vim.g.clipboard = {
          name = "wl-clipboard",
          copy = { ["+"] = "wl-copy", ["*"] = "wl-copy --primary" },
          paste = { ["+"] = wl_paste(""), ["*"] = wl_paste("--primary") },
          cache_enabled = 0,
        }
      elseif vim.fn.executable("xsel") == 1 then
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
--     if mark[1] > 0 and mark[1] <= lcount then
--       pcall(vim.api.nvim_win_set_cursor, 0, mark)
--       -- Open folds if cursor is in a fold
--       pcall(vim.cmd, "normal! zv")
--       -- Center the screen
--       pcall(vim.cmd, "normal! zz")
--     end
--   end,
--   desc = "Restore cursor position with fold handling",
-- })
