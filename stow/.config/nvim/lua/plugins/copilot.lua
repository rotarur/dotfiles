if true then
  return {}
end
-- return {
--   {
--     "CopilotC-Nvim/CopilotChat.nvim",
--     dependencies = {
--       { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
--       { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
--     },
--     build = "make tiktoken", -- Only on MacOS or Linux
--     opts = {
--       -- See Configuration section for options
--     },
--     -- See Commands section for default commands if you want to lazy load on them
--   },
-- }

-- return {
--   "zbirenbaum/copilot.lua",
--   requires = {
--     "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
--   },
-- }
return {
  "zbirenbaum/copilot.lua",
  requires = {
    "copilotlsp-nvim/copilot-lsp",
    init = function()
      vim.g.copilot_nes_debounce = 500
    end,
  },
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      nes = {
        enabled = true,
        keymap = {
          accept_and_goto = "<leader>p",
          accept = false,
          dismiss = "<Esc>",
        },
      },
    })
  end,
}
