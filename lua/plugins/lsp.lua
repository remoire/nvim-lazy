return {

  -- Java development
  -- { "mfussenegger/nvim-jdtls" },
  -- {
  --   "nvim-java/nvim-java",
  --   dependencies = {
  --     "nvim-java/lua-async-await",
  --     "nvim-java/nvim-java-core",
  --     "nvim-java/nvim-java-test",
  --     "nvim-java/nvim-java-dap",
  --     "mfussenegger/nvim-dap",
  --     "MunifTanjim/nui.nvim",
  --     "neovim/nvim-lspconfig",
  --
  --     {
  --       "williamboman/mason.nvim",
  --       opts = {
  --         registries = {
  --           "github:nvim-java/mason-registry",
  --           "github:mason-org/mason-registry",
  --         },
  --       },
  --     },
  --   },
  --   config = function() end,
  -- },
  --

  -- {
  --   "mfussenegger/nvim-dap",
  --   opts = {},
  --   config = function() end,
  -- },
  --
  {
    "williamboman/mason.nvim",

    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "luacheck",
        "shfmt",
        "flake8",
        "selene",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
        "jdtls",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts

    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
        pyright = {},
        java = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
    config = function()
      -- require("java").setup()
      -- local lspconfig = require("lspconfig")
      -- lspconfig.jdtls.setup({})
    end,
  },
}
