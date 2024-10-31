return {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    config = function()
        local harpoon = require "harpoon"
        harpoon:setup()

        vim.keymap.set("n", "<leader>a", function()
            harpoon:list():add()
        end)
        vim.keymap.set("n", "<C-e>", function()
            harpoon.ui:toggle_quick_menu(harpoon:list())
        end)

        -- Set <space>1..<space>5 be my shortcuts to moving to the files
        for _, idx in ipairs { 1, 2, 3, 4, 5 } do
            vim.keymap.set("n", string.format("<leader>%d", idx), function()
                harpoon:list():select(idx)
            end)
        end

        -- vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
        -- vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
        -- vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
        -- vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
        -- vim.keymap.set("n", "<leader><C-h>", function() harpoon:list():replace_at(1) end)
        -- vim.keymap.set("n", "<leader><C-t>", function() harpoon:list():replace_at(2) end)
        -- vim.keymap.set("n", "<leader><C-n>", function() harpoon:list():replace_at(3) end)
        -- vim.keymap.set("n", "<leader><C-s>", function() harpoon:list():replace_at(4) end)
    end,
}
