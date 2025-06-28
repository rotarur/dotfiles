-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE
return {
  "mrcjkb/rustaceanvim",
  version = "^6", -- Recommended
  lazy = false, -- This plugin is already lazy
  keys = {
    { -- lazy style key map
      "n",
      "<leader>la",
      function()
        vim.cmd.RustLsp "codeAction" -- supports rust-analyzer's grouping
        -- or vim.lsp.buf.codeAction() if you don't want grouping.
      end,
      desc = "Code Actions",
    },
    {
      "n",
      "K", -- Override Neovim's built-in hover keymap with rustaceanvim's hover actions
      function() vim.cmd.RustLsp { "hover", "actions" } end,
      { silent = true, buffer = vim.api.nvim_get_current_buf() },
    },
    {
      "n",
      "n", -- Disabled opening manual on search next word
      false,
    },
  },
}
