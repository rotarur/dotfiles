return {
  {
    "folke/noice.nvim",
    opts = function(_, opts)
      opts.views = {
        notify = {
          timeout = 10000,
        },
      }
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      opts.presets_lsp_doc_border = true
      opts.presets_inc_rename = true
    end,
  },
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 1000000,
    },
  },
  {
    "smjonas/inc-rename.nvim",
    opts = {},
  },
}
