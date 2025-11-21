if true then
  return {}
end
return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    adapters = {
      gemini = function()
        return require("codecompanion.adapters").extend("gemini", {
          env = {
            api_key = "GEMINI_API_KEY",
          },
        })
      end,
    },
    strategies = {
      -- Change the default chat adapter and model
      chat = {
        adapter = "gemini",
      },
      inline = {
        adapter = "gemini",
      },
      cmd = {
        adapter = "gemini",
      },
    },
    display = {
      action_palette = {
        width = 95,
        height = 10,
        prompt = "Prompt ", -- Prompt used for interactive LLM calls
        provider = "default", -- Can be "default", "telescope", "fzf_lua", "mini_pick" or "snacks". If not specified, the plugin will autodetect installed providers.
        opts = {
          show_default_actions = true, -- Show the default actions in the action palette?
          show_default_prompt_library = true, -- Show the default prompt library in the action palette?
          title = "CodeCompanion actions", -- The title of the action palette
        },
      },
    },
    -- NOTE: The log_level is in `opts.opts`
    opts = {
      log_level = "DEBUG",
    },
  },
}
