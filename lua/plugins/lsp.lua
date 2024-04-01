return {
  -- java
  { "mfussenegger/nvim-jdtls" },
  { "mfussenegger/nvim-dap", config = function() end },
  {
    "nvim-java/nvim-java",
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
      "mfussenegger/nvim-dap",
      "MunifTanjim/nui.nvim",
      "neovim/nvim-lspconfig",

      {
        "williamboman/mason.nvim",
        opts = {
          registries = {
            "github:nvim-java/mason-registry",
            "github:mason-org/mason-registry",
          },
        },
      },
    },
    config = function()
      require("java").setup()

      local lspconfig = require("lspconfig")
      local lsp_helpers = require("plugins.helpers.lsp-helpers")
      lspconfig.jdtls.setup({})
    end,
  },

  -- pascal, delphi
  {
    "skywind3000/asyncrun.vim", -- async make
    "mattia72/vim-delphi", -- aligning
    "dylanaraps/pascal_lint.nvim", -- linter
    config = function()
      require("vim-delphi").setup()
      require("pascal_list.nvim").setup()
      require("asyncrun.vim").setup()
    end,
  },

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
        "astro-language-server",
        "ruff",
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
    lazy = false,
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

    config = function()
      local lspconfig = require("lspconfig")
      local cmp_nvim_lsp = require("cmp_nvim_lsp")
      local keymap = vim.keymap

      local lsp_helpers = require("plugins.helpers.lsp-helpers")

      lspconfig.tailwindcss.setup({
        capabilities = lsp_helpers.capabilities,
        on_attach = lsp_helpers.on_attach,
      })
      lspconfig.delphi_ls.setup({
        capabilities = lsp_helpers.capabilities,
        on_attach = lsp_helpers.on_attach,
      })
      lspconfig.ruff.setup({
        capabilities = lsp_helpers.capabilities,
        on_attach = lsp_helpers.on_attach,
      })
      lspconfig.ruff_lsp.setup({
        on_attach = lsp_helpers.on_attach,
        init_options = {
          settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {},
          },
        },
      })
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
      lspconfig.tsserver.setup({
        capabilities = lsp_helpers.capabilities,
        on_attach = lsp_helpers.on_attach,
      })
      lspconfig.astro.setup({
        capabilities = lsp_helpers.capabilities,
        on_attach = lsp_helpers.on_attach,
      })
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdLineEnter" },
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "codeium",
        group_index = 1,
        priority = 100,
      })

      local cmp = require("cmp")
      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
          ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
          ["<C-e>"] = cmp.mapping.abort(), -- close completion window
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
        }),
      })
    end,
  },
}
