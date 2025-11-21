return {
  {
    "windwp/nvim-autopairs",
    opts = {
      enable_bracket_in_quote = true,
    },
  },
  -- {
  --   "folke/which-key.nvim",
  --   opts = {
  --     spec = {
  --       ["<leader>r"] = { name = "+Rename" },
  --     },
  --   },
  -- },
  {
    "nvim-telescope/telescope.nvim",
    opts = {
      defaults = {
        hidden = true,
        no_ignore = true,
        file_ignore_patterns = {
          "node_modules",
          ".git/",
          "dist/",
          "build/",
        },
      },
    },
  },
  {
    "LazyVim",
    opts = {},
    init = function()
      vim.api.nvim_create_autocmd("BufReadPost", {
        group = vim.api.nvim_create_augroup("RestoreCursor", { clear = true }),
        callback = function(event)
          local exclude_ft = { "gitcommit", "gitrebase", "svn", "hgcommit" }
          local buf = event.buf
          if vim.tbl_contains(exclude_ft, vim.bo[buf].filetype) or vim.b[buf].last_loc then
            return
          end
          vim.b[buf].last_loc = true
          local mark = vim.api.nvim_buf_get_mark(buf, '"')
          local lcount = vim.api.nvim_buf_line_count(buf)
          if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
          end
        end,
      })
    end,
  },
}
