if true then
  return {}
end
return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  opts = {
    provider = "ollama",
    auto_suggestions_provider = "ollama",

    providers = {
      ollama = {
        endpoint = "http://127.0.0.1:11434",
        timeout = 30000, -- Timeout in milliseconds
        extra_request_body = {
          options = {
            temperature = 0.75,
            num_ctx = 20480,
            keep_alive = "5m",
          },
        },
      },
    },

    -- O Avante agora usa muito o nui.nvim para a interface
    hints = { enabled = true },
    windows = {
      position = "right",
      width = 30,
    },
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim", -- Esta é a principal dependência de UI agora
    "nvim-tree/nvim-web-devicons",
  },
  -- Compilação opcional para melhor performance (necessário ter 'make' instalado)
  build = "make",
}
