if true then
  return {}
end
return {
  "supermaven-inc/supermaven-nvim",
  dependencies = {
    -- Ensure nvim-cmp is loaded before configuring its sources
    { "hrsh7th/nvim-cmp" },
  },
  opts = {}, -- Supermaven options
  config = function(_, opts)
    -- Your specific Supermaven setup, which might include:
    require("supermaven-nvim").setup(opts)

    -- --- ERROR FIX: The insertion logic should be here ---
    -- If you are manually inserting into cmp sources, ensure cmp is ready.
    local cmp = require("cmp")
    local sources = cmp.get_config().sources -- Get the current sources table

    if sources then
      table.insert(sources, { name = "supermaven" })
      cmp.setup({ sources = sources })
    else
      -- If sources is nil, this is where the original error occurs.
      -- LazyVim/nvim-cmp should handle initialization, but this check
      -- ensures robustness.
      vim.notify("nvim-cmp sources table was nil. Supermaven completion may not work.", vim.log.levels.ERROR)
    end
    ----------------------------------------------------------
  end,
}
