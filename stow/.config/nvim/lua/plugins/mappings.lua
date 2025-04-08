-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`

-- custom icons
-- search in https://www.nerdfonts.com/cheat-sheet
vim.g.icons = {
  ui = {
    File = "",
    Search = "",
  },
}
---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = {
    mappings = {
      n = {
        -- rewrite all telescope <Leader>f to <Leader>s
        -- ["<Leader>s"] = vim.tbl_get(opts, "_map_sections", "f"),
        ["<Leader>s"] = { desc = vim.g.icons.ui.Search .. " Search" },
        ["<Leader>s<CR>"] = { function() require("telescope.builtin").resume() end, desc = "Resume previous search" },
        ["<Leader>f<CR>"] = false,
        ["<Leader>s'"] = { function() require("telescope.builtin").marks() end, desc = "Find marks" },
        ["<Leader>f'"] = false,
        ["<Leader>s/"] = {
          function() require("telescope.builtin").current_buffer_fuzzy_find() end,
          desc = "Find words in current buffer",
        },
        ["<Leader>f/"] = false,
        ["<Leader>sa"] = {
          function()
            require("telescope.builtin").find_files {
              prompt_title = "Config Files",
              cwd = vim.fn.stdpath "config",
              follow = true,
            }
          end,
          desc = "Find AstroNvim config files",
        },
        ["<Leader>fa"] = false,
        ["<Leader>sb"] = { function() require("telescope.builtin").buffers() end, desc = "Find buffers" },
        ["<Leader>fb"] = false,
        ["<Leader>sc"] = { function() require("telescope.builtin").grep_string() end, desc = "Find word under cursor" },
        ["<Leader>fc"] = false,
        ["<Leader>sC"] = { function() require("telescope.builtin").commands() end, desc = "Find commands" },
        ["<Leader>fC"] = false,
        ["<Leader>sf"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" },
        ["<Leader>ff"] = false,
        ["<Leader>sF"] = {
          function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
          desc = "Find all files",
        },
        ["<Leader>fF"] = false,
        ["<Leader>sg"] = { function() require("telescope.builtin").git_files() end, desc = "Find git files" },
        ["<Leader>fg"] = false,
        ["<Leader>sh"] = { function() require("telescope.builtin").help_tags() end, desc = "Find help" },
        ["<Leader>fh"] = false,
        ["<Leader>sk"] = { function() require("telescope.builtin").keymaps() end, desc = "Find keymaps" },
        ["<Leader>fk"] = false,
        ["<Leader>sm"] = { function() require("telescope.builtin").man_pages() end, desc = "Find man" },
        ["<Leader>fm"] = false,
        ["<Leader>sn"] = { function() require("telescope").extensions.notify.notify() end, desc = "Find notifications" },
        ["<Leader>fn"] = { "<Cmd>enew<CR>", desc = "New File" },
        ["<Leader>so"] = { function() require("telescope.builtin").oldfiles() end, desc = "Find history" },
        ["<Leader>sr"] = { function() require("telescope.builtin").registers() end, desc = "Find registers" },
        ["<Leader>fr"] = false,
        ["<Leader>st"] = {
          function() require("telescope.builtin").colorscheme { enable_preview = true, ignore_builtins = true } end,
          desc = "Find themes",
        },
        ["<Leader>ft"] = false,
        ["<Leader>sw"] = { function() require("telescope.builtin").live_grep() end, desc = "Find words" },
        ["<Leader>sW"] = {
          function()
            require("telescope.builtin").live_grep {
              additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
            }
          end,
          desc = "Find words in all files",
        },
        ["<Leader>fW"] = false,
        ["<Leader>sT"] = { "<Cmd>TodoTelescope<CR>", desc = "Find TODOs" },
        ["<Leader>fT"] = false,

        -- create file group
        -- ["<Leader>f"] = { require("astroui").get_icon.("DefaultFile", 1, true) .. "File" },
        ["<Leader>f"] = { desc = vim.g.icons.ui.File .. " File" },
        ["<Leader>n"] = false,
        ["<Leader>fw"] = { "<Cmd>w<CR>", desc = "Save" },
        ["<Leader>fp"] = { "<Cmd>Neotree toggle<CR>", desc = "Toggle Explorer" },
        ["<Leader>fo"] = {
          function()
            if vim.bo.filetype == "neo-tree" then
              vim.cmd.wincmd "p"
            else
              vim.cmd.Neotree "focus"
            end
          end,
          desc = "Toggle Explorer Focus",
        },

        -- shortcuts
        L = { "<CMD>]b<CR>", desc = "Next tab" },
        H = { "<CMD>[b<CR>", desc = "Previous tab" },
        ["<Leader>v"] = {
          "<CMD>vsplit | lua vim.lsp.buf.definition()<CR>",
          desc = "Go to definition in vertical split",
        },
        J = { "mzJ`z", desc = "Keep cursor in place while appending lines" },
        ["<Leader>lF"] = {
          [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
          desc = "Replace current word in current buffer",
        },
        ["<Leader>w"] = { "<CMD>:w<CR>", desc = "Save buffer" },
      },
      v = {
        J = { ":m '>+1<CR>gv=gv", desc = "Move selected like / block of text down" },
        K = { ":m '<-2<CR>gv=gv", desc = "Move selected like / block of text up" },
      },
      x = {
        p = { '"_dp', desc = "Paste line without losing the buffer" },
      },
      i = {
        ["<C-c>"] = { "<Esc>", desc = "Ctrl-c as Escape" },
      },
    },
    -- -- add newline at EOF
    -- vim.cmd [[
    --   augroup AddNewlineAtEOF
    --     autocmd!
    --     autocmd BufWritePre * lua local lines = vim.api.nvim_buf_get_lines(0, -2, -1, false) if lines[#lines] ~= '' and lines[#lines]:sub(-1) ~= '\n' then vim.api.nvim_buf_set_lines(0, -1, -1, false, {''}) end
    --     augroup END
    -- ]]
    -- end,
    -- easily configure auto commands
    autocmds = {
      -- disable alpha autostart
      alpha_autostart = false,
      restore_session = {
        {
          event = "VimEnter",
          desc = "Restore previous directory session if neovim opened with no arguments",
          nested = true, -- trigger other autocommands as buffers open
          callback = function()
            -- Only load the session if nvim was started with no args
            if vim.fn.argc(-1) == 0 then
              -- try to load a directory session using the current working directory
              require("resession").load(vim.fn.getcwd(), { dir = "dirsession", silence_errors = true })
            end
          end,
        },
      },
      -- -- first key is the `augroup` (:h augroup)
      -- add_new_line_at_eof = {
      --   -- list of auto commands to set
      --   {
      --     -- events to trigger
      --     event = "BufWritePre",
      --     -- the rest of the autocmd options (:h nvim_create_autocmd)
      --     desc = "Add new line at EOF",
      --     callback = function()
      --       local lines = vim.api.nvim_buf_get_lines(0, -2, -1, false)
      --       if lines[#lines] ~= "" and lines[#lines]:sub(-1) ~= "\n" then
      --         vim.api.nvim_buf_set_lines(0, -1, -1, false, { "" })
      --       end
      --     end,
      --   },
      -- },
      remove_duplicated_new_lines = {
        {
          event = { "BufWritePre" },
          desc = "Remove duplicated new lines",
          callback = function()
            local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
            if #lines > 1 and lines[#lines] == "" and lines[#lines - 1] == "" then
              vim.api.nvim_buf_set_lines(0, #lines - 1, #lines, false, {})
            end
          end, -- command = [[if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif]],
        },
      },
      -- autohidetabline = {
      --   -- each augroup contains a list of auto commands
      --   {
      --     -- create a new autocmd on the "User" event
      --     event = "User",
      --     -- the pattern is the name of our User autocommand events
      --     pattern = "AstroBufsUpdated", -- triggered when vim.t.bufs is updated
      --     -- nice description
      --     desc = "Hide tabline when only one buffer and one tab",
      --     -- add the autocmd to the newly created augroup
      --     group = "autohidetabline",
      --     callback = function()
      --       -- if there is more than one buffer in the tab, show the tabline
      --       -- if there are 0 or 1 buffers in the tab, only show the tabline if there is more than one vim tab
      --       local new_showtabline = #vim.t.bufs > 1 and 2 or 1
      --       -- check if the new value is the same as the current value
      --       if new_showtabline ~= vim.opt.showtabline:get() then
      --         -- if it is different, then set the new `showtabline` value
      --         vim.opt.showtabline = new_showtabline
      --       end
      --     end,
      --   },
      -- },
    },
    -- vim options can be configured here
    options = {
      opt = { -- vim.opt.<key>
        wrap = true, -- sets vim.opt.wrap
        swapfile = false,
        backup = false,
        -- go to previous/next line with h,l,left arrow and right arrow
        -- when cursor reaches end/beginning of line
        whichwrap = "<>[]hl",
        showtabline = 0,
      },
    },
    cmp = {
      completion = {
        completeopt = "menu,menuone,noinsert",
      },
    },

    --   -- easily configure user commands
    --   commands = {
    --     -- key is the command name
    --     AstroReload = {
    --       -- first element with no key is the command (string or function)
    --       function() require("astrocore").reload() end,
    --       -- the rest are options for creating user commands (:h nvim_create_user_command)
    --       desc = "Reload AstroNvim (Experimental)",
    --     },
    --   },
    --   -- Configure diagnostics options (`:h vim.diagnostic.config()`)
    --   diagnostics = {
    --     update_in_insert = false,
    --   },
    --   -- passed to `vim.filetype.add`
    filetypes = {
      -- see `:h vim.filetype.add` for usage
      extension = {
        rust_analyzer = "rust",
      },
      filename = {
        Cargo = "rust",
      },
      pattern = {
        [".*/Cargo.toml"] = "rust",
        [".*/Cargo.lock"] = "rust",
      },
    },
    --   -- easily configure functions on key press
    --   on_keys = {
    --     -- first key is the namespace
    --     auto_hlsearch = {
    --       -- list of functions to execute on key press (:h vim.on_key)
    --       function(char) -- example automatically disables `hlsearch` when not actively searching
    --         if vim.fn.mode() == "n" then
    --           local new_hlsearch = vim.tbl_contains({ "<CR>", "n", "N", "*", "#", "?", "/" }, vim.fn.keytrans(char))
    --           if vim.opt.hlsearch:get() ~= new_hlsearch then vim.opt.hlsearch = new_hlsearch end
    --         end
    --       end,
    --     },
    --   },
    --   -- configure AstroNvim features
    features = {
      nullls = false,
      -- autopairs = true, -- enable or disable autopairs on start
      -- cmp = true, -- enable or disable cmp on start
      -- diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = off)
      -- highlighturl = true, -- enable or disable highlighting of urls on start
      -- -- table for defining the size of the max file for all features, above these limits we disable features like treesitter.
      -- large_buf = { size = 1024 * 100, lines = 10000 },
      -- notifications = true, -- enable or disable notifications on start
    },
    --   -- Enable git integration for detached worktrees
    --   git_worktrees = {
    --     { toplevel = vim.env.HOME, gitdir = vim.env.HOME .. "/.dotfiles" },
    --   },
    --   -- Configure project root detection, check status with `:AstroRootInfo`
    -- rooter = {
    --   -- list of detectors in order of prevalence, elements can be:
    --   --   "lsp" : lsp detection
    --   --   string[] : a list of directory patterns to look for
    --   --   fun(bufnr: integer): string|string[] : a function that takes a buffer number and outputs detected roots
    --   detector = {
    --     "lsp", -- highest priority is getting workspace from running language servers
    --     { ".git", "_darcs", ".hg", ".bzr", ".svn" }, -- next check for a version controlled parent directory
    --     { "lua", "MakeFile", "package.json" }, -- lastly check for known project root files
    --   },
    --   -- ignore things from root detection
    --   ignore = {
    --     servers = {}, -- list of language server names to ignore (Ex. { "efm" })
    --     dirs = { "*.cargo/*" }, -- list of directory patterns (Ex. { "~/.cargo/*" })
    --   },
    --   -- automatically update working directory (update manually with `:AstroRoot`)
    --   autochdir = true,
    --   -- scope of working directory to change ("global"|"tab"|"win")
    --   scope = "tab",
    --   -- show notification on every working directory change
    --   notify = true,
    -- },
    --   -- Configuration table of session options for AstroNvim's session management powered by Resession
    sessions = {
      -- Configure auto saving
      autosave = {
        last = true, -- auto save last session
        cwd = true, -- auto save session for each working directory
      },
      -- Patterns to ignore when saving sessions
      ignore = {
        dirs = {}, -- working directories to ignore sessions in
        filetypes = { "gitcommit", "gitrebase" }, -- filetypes to ignore sessions
        buftypes = {}, -- buffer types to ignore sessions
      },
    },
    -- }
  },
}
