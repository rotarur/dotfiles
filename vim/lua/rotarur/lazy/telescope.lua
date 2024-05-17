return {
    'nvim-telescope/telescope.nvim',

    tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' },

    config = function()
        require('telescope').setup {
            fzf = {
                fuzzy = true,                   -- false will only do exact matching
                override_generic_sorter = true, -- override the generic sorter
                override_file_sorter = true,    -- override the file sorter
                case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
                -- the default case_mode is "smart_case"
            },
            defaults = {
                mappings = {
                    i = {
                        ['<C-u>'] = false,
                        ['<C-d>'] = false,
                    },
                },
                layout_strategy = 'vertical',
                -- layout_config = {
                --     horizontal = { width = 0.5 },
                --     -- other layout configuration here
                -- },
            },
            -- pickers = {
            --     find_files = {
            --         theme = "dropdown",
            --         -- winblend = 20,
            --     }
            -- },
        }

        require('telescope').load_extension('fzf')

        -- Telescope
        vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles,
            { desc = '[?] Find recently opened files' })
        vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers,
            { desc = '[ ] Find existing buffers' })

        vim.keymap.set('n', '<leader>/', function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
                winblend = 10,
                previewer = false,
            })
        end, { desc = '[/] Fuzzily search in current buffer' })

        --[[
        local function telescope_live_grep_open_files()
           require('telescope.builtin').live_grep {
              grep_open_files = true,
              prompt_title = 'Live Grep in Open Files',
           }
        end

        vim.keymap.set('n', '<leader>s/', telescope_live_grep_open_files, { desc = '[S]earch [/] in Open Files' })
        --]]
        vim.keymap.set('n', '<leader>s/', function()
            require('telescope.builtin').live_grep {
                grep_open_files = true,
                prompt_title = 'Live Grep in Open Files',
            }
        end, { desc = '[S]earch [/] in Open Files' })

        vim.keymap.set('n', '<leader>ss', require('telescope.builtin').builtin,
            { desc = '[S]earch [S]elect Telescope' })
        vim.keymap.set('n', '<leader>gf', require('telescope.builtin').git_files,
            { desc = 'Search [G]it [F]iles' })
        vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
        vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
        vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string,
            { desc = '[S]earch current [W]ord' })
        vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
        vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = '[S]earch by [G]rep on Git Root' })
        vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics,
            { desc = '[S]earch [D]iagnostics' })
        -- vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })

        vim.keymap.set('n', '<leader>sr', function(opts)
            opts = opts or {}
            opts.cwd = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
            if vim.v.shell_error ~= 0 then
                -- if not git then active lsp client root
                -- will get the configured root directory of the first attached lsp. You will have problems if you are using multiple lsps
                opts.cwd = vim.lsp.get_active_clients()[1].config.root_dir
            end
            require 'telescope.builtin'.find_files(opts)
        end, { desc = '[S]earch Files from [R]oot' })

        -- live_grep in git root
        -- Function to find the git root directory based on the current buffer's path
        local function find_git_root()
            -- Use the current buffer's path as the starting point for the git search
            local current_file = vim.api.nvim_buf_get_name(0)
            local current_dir
            local cwd = vim.fn.getcwd()
            -- If the buffer is not associated with a file, return nil
            if current_file == '' then
                current_dir = cwd
            else
                -- Extract the directory from the current file's path
                current_dir = vim.fn.fnamemodify(current_file, ':h')
            end

            -- Find the Git root directory from the current file's path
            local git_root = vim.fn.systemlist('git -C ' ..
                vim.fn.escape(current_dir, ' ') .. ' rev-parse --show-toplevel')[1]
            if vim.v.shell_error ~= 0 then
                print 'Not a git repository. Searching on current working directory'
                return cwd
            end
            return git_root
        end

        -- Custom live_grep function to search in git root
        local function live_grep_git_root()
            local git_root = find_git_root()
            if git_root then
                require('telescope.builtin').live_grep {
                    search_dirs = { git_root },
                }
            end
        end

        vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})
    end
}
