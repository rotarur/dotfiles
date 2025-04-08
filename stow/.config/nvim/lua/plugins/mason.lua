-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- Customize Mason plugins

---@type LazySpec
return {
  -- mason installer / updater
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    opts = {
      -- a list of all tools you want to ensure are installed upon
      -- start
      ensure_installed = {
        -- you can turn off/on auto_update per tool
        { "bash-language-server", auto_update = true },

        "lua-language-server",
        "vim-language-server",
        "gopls",
        "golangci-lint",
        "stylua",
        "shellcheck",
        "editorconfig-checker",
        "gofumpt",
        "golines",
        "gomodifytags",
        "gotests",
        "impl",
        "json-to-struct",
        "misspell",
        "revive",
        "shellcheck",
        "shfmt",
        "staticcheck",
        "vint",
        "python-lsp-server",
        "terraform-ls",
        "tflint",
        "docker-compose-language-service",
        "dockerfile-language-server",
        "rust-analyzer",
        "typescript-language-server",
        "markdownlint",
        "yaml-language-server",
        "pyright",
      },

      -- if set to true this will check each tool for updates. If updates
      -- are available the tool will be updated. This setting does not
      -- affect :MasonToolsUpdate or :MasonToolsInstall.
      -- Default: false
      auto_update = false,

      -- automatically install / update on startup. If set to false nothing
      -- will happen on startup. You can use :MasonToolsInstall or
      -- :MasonToolsUpdate to install tools and check for updates.
      -- Default: true
      run_on_start = true,

      -- By default all integrations are enabled. If you turn on an integration
      -- and you have the required module(s) installed this means you can use
      -- alternative names, supplied by the modules, for the thing that you want
      -- to install. If you turn off the integration (by setting it to false) you
      -- cannot use these alternative names. It also suppresses loading of those
      -- module(s) (assuming any are installed) which is sometimes wanted when
      -- doing lazy loading.
      integrations = {
        ["mason-lspconfig"] = true,
        ["mason-null-ls"] = true,
        ["mason-nvim-dap"] = true,
      },
    },
  },
  -- use mason-lspconfig to configure LSP installations
  {
    "williamboman/mason-lspconfig.nvim",
    -- overrides `require("mason-lspconfig").setup(...)`
    opts = {
      ensure_installed = {
        "lua_ls",
        -- add more arguments for adding more language servers
      },
    },
  },
  -- use mason-null-ls to configure Formatters/Linter installation for null-ls sources
  {
    "jay-babu/mason-null-ls.nvim",
    -- overrides `require("mason-null-ls").setup(...)`
    opts = {
      ensure_installed = {
        "stylua",
        -- add more arguments for adding more null-ls sources
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    -- overrides `require("mason-nvim-dap").setup(...)`
    opts = {
      ensure_installed = {
        "python",
        -- add more arguments for adding more debuggers
      },
    },
  },
}
