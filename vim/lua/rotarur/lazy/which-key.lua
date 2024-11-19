return {
    "folke/which-key.nvim",
    event = "VeryLazy",

    config = function()
        local wk = require("which-key")
        wk.add({
            { "<leader>c", desc = "[C]ode" },
            { "<leader>d", desc = "[D]debug" },
            { "<leader>g", desc = "[G]it" },
            -- { "<leader>h", desc = "Git [H]unk" },
            { "<leader>r", desc = "[R]ename" },
            { "<leader>s", desc = "[S]earch" },
            { "<leader>t", desc = "[T]oggle Tabs" },
            { "<leader>n", desc = "[N]eotree" },
            -- { "<leader>w", desc = "[W]orkspace" },
        })
    end
}
