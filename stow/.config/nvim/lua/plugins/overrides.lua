return {
  {
    "windwp/nvim-autopairs",
    opts = {
      enable_bracket_in_quote = true,
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        ["<leader>C"] = { name = "+Claude Code" },
        ["<leader>r"] = { name = "+Rename" },
      },
    },
  },
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
}
