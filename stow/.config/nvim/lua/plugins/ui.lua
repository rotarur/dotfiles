return {
    {
        "folke/snacks.nvim",
        opts = {
            picker = {
                actions = {
                    -- upstream uses vim.fn.filereadable() which returns 0 for directories,
                    -- so yanked folders are silently dropped and paste always fails
                    explorer_paste = function(picker)
                        local uv = vim.uv or vim.loop
                        local files = vim.split(vim.fn.getreg(vim.v.register or "+") or "", "\n", { plain = true })
                        files = vim.tbl_filter(function(f)
                            return f ~= "" and uv.fs_stat(f) ~= nil
                        end, files)
                        if #files == 0 then
                            return Snacks.notify.warn(
                                ("The `%s` register does not contain any files"):format(vim.v.register or "+")
                            )
                        end
                        local dir = picker:dir()
                        local Tree = require("snacks.explorer.tree")
                        Snacks.picker.util.copy(files, dir)
                        Tree:refresh(dir)
                        Tree:open(dir)
                        require("snacks.explorer.actions").update(picker, { target = dir })
                    end,
                },
            },
        },
    },
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
        "neovim/nvim-lspconfig",
        ---@class PluginLspOpts
        opts = {
            ---@type lspconfig.options
            diagnostics = {
                virtual_text = false,
                signs = false,
            },
        },
    },
    { "akinsho/bufferline.nvim", enabled = false },
}

