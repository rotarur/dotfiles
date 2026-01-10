if true then
  return {}
end
return {
  "olimorris/codecompanion.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
  opts = {
    adapters = {
      ollama = function()
        return require("codecompanion.adapters").extend("ollama", {
          schema = {
            model = { default = "qwen2.5-coder:7b" }, -- Modelo leve para não travar o PC
          },
        })
      end,
    },
    strategies = {
      inline = { adapter = "ollama" },
      chat = { adapter = "ollama" },
    },
  },
}
