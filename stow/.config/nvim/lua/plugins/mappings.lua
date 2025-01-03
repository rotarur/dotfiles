-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCore provides a central place to modify mappings, vim options, autocommands, and more!
-- Configuration documentation can be found with `:h astrocore`

---@type LazySpec
return {
  "AstroNvim/astrocore",
  ---@type AstroCoreOpts
  opts = function(_, opts)
    local get_icon = require("astroui").get_icon
    -- rewrite all telescope <Leader>f to <Leader>s
    opts.mappings.n["<Leader>s"] = vim.tbl_get(opts, "_map_sections", "f")
    opts.mappings.n["<Leader>f"] = false
    opts.mappings.n["<Leader>sn"] = { function() print "TEST MAPPING" end, desc = "test mapping" }
    opts.mappings.n["<Leader>fn"] = false
    opts.mappings.n["<Leader>s<CR>"] =
      { function() require("telescope.builtin").resume() end, desc = "Resume previous search" }
    opts.mappings.n["<Leader>f<CR>"] = false
    opts.mappings.n["<Leader>s'"] = { function() require("telescope.builtin").marks() end, desc = "Find marks" }
    opts.mappings.n["<Leader>f'"] = false
    opts.mappings.n["<Leader>s/"] = {
      function() require("telescope.builtin").current_buffer_fuzzy_find() end,
      desc = "Find words in current buffer",
    }
    opts.mappings.n["<Leader>f/"] = false
    opts.mappings.n["<Leader>sa"] = {
      function()
        require("telescope.builtin").find_files {
          prompt_title = "Config Files",
          cwd = vim.fn.stdpath "config",
          follow = true,
        }
      end,
      desc = "Find AstroNvim config files",
    }
    opts.mappings.n["<Leader>fa"] = false
    opts.mappings.n["<Leader>sb"] = { function() require("telescope.builtin").buffers() end, desc = "Find buffers" }
    opts.mappings.n["<Leader>fb"] = false
    opts.mappings.n["<Leader>sc"] =
      { function() require("telescope.builtin").grep_string() end, desc = "Find word under cursor" }
    opts.mappings.n["<Leader>fc"] = false
    opts.mappings.n["<Leader>sC"] = { function() require("telescope.builtin").commands() end, desc = "Find commands" }
    opts.mappings.n["<Leader>fC"] = false
    opts.mappings.n["<Leader>sf"] = { function() require("telescope.builtin").find_files() end, desc = "Find files" }
    opts.mappings.n["<Leader>ff"] = false
    opts.mappings.n["<Leader>sF"] = {
      function() require("telescope.builtin").find_files { hidden = true, no_ignore = true } end,
      desc = "Find all files",
    }
    opts.mappings.n["<Leader>fF"] = false
    opts.mappings.n["<Leader>sg"] = { function() require("telescope.builtin").git_files() end, desc = "Find git files" }
    opts.mappings.n["<Leader>fg"] = false
    opts.mappings.n["<Leader>sh"] = { function() require("telescope.builtin").help_tags() end, desc = "Find help" }
    opts.mappings.n["<Leader>fh"] = false
    opts.mappings.n["<Leader>sk"] = { function() require("telescope.builtin").keymaps() end, desc = "Find keymaps" }
    opts.mappings.n["<Leader>fk"] = false
    opts.mappings.n["<Leader>sm"] = { function() require("telescope.builtin").man_pages() end, desc = "Find man" }
    opts.mappings.n["<Leader>fm"] = false
    opts.mappings.n["<Leader>sn"] =
      { function() require("telescope").extensions.notify.notify() end, desc = "Find notifications" }
    opts.mappings.n["<Leader>fn"] = false
    opts.mappings.n["<Leader>so"] = { function() require("telescope.builtin").oldfiles() end, desc = "Find history" }
    opts.mappings.n["<Leader>fo"] = false
    opts.mappings.n["<Leader>sr"] = { function() require("telescope.builtin").registers() end, desc = "Find registers" }
    opts.mappings.n["<Leader>fr"] = false
    opts.mappings.n["<Leader>st"] = {
      function() require("telescope.builtin").colorscheme { enable_preview = true, ignore_builtins = true } end,
      desc = "Find themes",
    }
    opts.mappings.n["<Leader>ft"] = false
    if vim.fn.executable "rg" == 1 then
      opts.mappings.n["<Leader>sw"] = { function() require("telescope.builtin").live_grep() end, desc = "Find words" }
      opts.mappings.n["<Leader>fw"] = false
      opts.mappings.n["<Leader>sW"] = {
        function()
          require("telescope.builtin").live_grep {
            additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
          }
        end,
        desc = "Find words in all files",
      }
    end
    opts.mappings.n["<Leader>fW"] = false
    if require("astrocore").is_available "telescope.nvim" then
      opts.mappings.n["<Leader>sT"] = { "<Cmd>TodoTelescope<CR>", desc = "Find TODOs" }
      opts.mappings.n["<Leader>fT"] = false
    end

    -- create file group
    opts.mappings.n["<Leader>f"] = { get_icon("DefaultFile", 1, true) .. "File" }
    opts.mappings.n["<Leader>n"] = false
    opts.mappings.n["<Leader>fn"] = { "<Cmd>enew<CR>", desc = "New File" }
    opts.mappings.n["<Leader>w"] = false
    opts.mappings.n["<Leader>fw"] = { "<Cmd>w<CR>", desc = "Save" }
    opts.mappings.n["<Leader>fp"] = { "<Cmd>Neotree toggle<CR>", desc = "Toggle Explorer" }
    opts.mappings.n["<Leader>fo"] = {
      function()
        if vim.bo.filetype == "neo-tree" then
          vim.cmd.wincmd "p"
        else
          vim.cmd.Neotree "focus"
        end
      end,
      desc = "Toggle Explorer Focus",
    }
  end,
  -- opts = {
  --   mappings = {
  --     -- first key is the mode
  --     n = {
  --       -- second key is the lefthand side of the map
  --       -- mappings seen under group name "Buffer"
  --       ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
  --       ["<Leader>bD"] = {
  --         function()
  --           require("astroui.status").heirline.buffer_picker(
  --             function(bufnr) require("astrocore.buffer").close(bufnr) end
  --           )
  --         end,
  --         desc = "Pick to close",
  --       },
  --
  --       ["<Leader>sf"] = { require(astrocore.mappings)., desc = "New tab" },
  --       -- quick save
  --       -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
  --     },
  --     t = {
  --       -- setting a mapping to false will disable it
  --       -- ["<esc>"] = false,
  --     },
  --   },
  -- },
  --   -- Configure core features of AstroNvim
  --   features = {
  --     large_buf = { size = 1024 * 256, lines = 10000 }, -- set global limits for large files for disabling features like treesitter
  --     autopairs = true, -- enable autopairs at start
  --     cmp = true, -- enable completion at start
  --     diagnostics_mode = 3, -- diagnostic mode on start (0 = off, 1 = no signs/virtual text, 2 = no virtual text, 3 = on)
  --     highlighturl = true, -- highlight URLs at start
  --     notifications = true, -- enable notifications at start
  --   },
  --   -- Diagnostics configuration (for vim.diagnostics.config({...})) when diagnostics are on
  --   diagnostics = {
  --     virtual_text = true,
  --     underline = true,
  --   },
  --   -- vim options can be configured here
  --   options = {
  --     opt = { -- vim.opt.<key>
  --       relativenumber = true, -- sets vim.opt.relativenumber
  --       number = true, -- sets vim.opt.number
  --       spell = false, -- sets vim.opt.spell
  --       signcolumn = "yes", -- sets vim.opt.signcolumn to yes
  --       wrap = false, -- sets vim.opt.wrap
  --     },
  --     g = { -- vim.g.<key>
  --       -- configure global vim variables (vim.g)
  --       -- NOTE: `mapleader` and `maplocalleader` must be set in the AstroNvim opts or before `lazy.setup`
  --       -- This can be found in the `lua/lazy_setup.lua` file
  --     },
  -- },
  -- Mappings can be configured through AstroCore as well.
  -- NOTE: keycodes follow the casing in the vimdocs. For example, `<Leader>` must be capitalized
  -- mappings = {
  --   -- first key is the mode
  --   n = {
  --     -- second key is the lefthand side of the map
  --
  --     -- navigate buffer tabs
  --     -- ["]b"] = { function() require("astrocore.buffer").nav(vim.v.count1) end, desc = "Next buffer" },
  --     -- ["[b"] = { function() require("astrocore.buffer").nav(-vim.v.count1) end, desc = "Previous buffer" },
  --
  --     -- mappings seen under group name "Buffer"
  --     -- ["<Leader>bd"] = {
  --     --   function()
  --     --     require("astroui.status.heirline").buffer_picker(
  --     --       function(bufnr) require("astrocore.buffer").close(bufnr) end
  --     --     )
  --     --   end,
  --     --   desc = "Close buffer from tabline",
  --     -- },
  --
  --     -- tables with just a `desc` key will be registered with which-key if it's installed
  --     -- this is useful for naming menus
  --     -- ["<Leader>s"] = { desc = "Find" },
  --     -- ["<leader>sf"] = { "<cmd>Telescope find_files<cr>", desc = "Find Files" },
  --     ["<leader>sf"] = { "<cmd>Telescope find_files<cr>", desc = "Find Files" },
  --
  --     -- setting a mapping to false will disable it
  --     -- ["<C-S>"] = false,
  --   },
  -- },
  -- },
}
