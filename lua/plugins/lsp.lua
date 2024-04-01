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

      lspconfig.jdtls.setup({})
      -- python
      lspconfig.ruff_lsp.setup({
        on_attach = function(client, bufnr)
          -- Enable completion triggered by <c-x><c-o>
          vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

          -- Mappings.
          -- See `:help vim.lsp.*` for documentation on any of the below functions
          local bufopts = { noremap = true, silent = true, buffer = bufnr }
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
          vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, bufopts)
          vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, bufopts)
          vim.keymap.set("n", "<space>wl", function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, bufopts)
          vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
          vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
          vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
          vim.keymap.set("n", "<space>f", function()
            vim.lsp.buf.format({ async = true })
          end, bufopts)
        end,
        init_options = {
          settings = {
            -- Any extra CLI arguments for `ruff` go here.
            args = {},
          },
        },
      })
      -- lspconfig.stylua.setup({})
      lspconfig.lua_ls.setup({
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })
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

    -- config = function()
    --   local lspconfig = require("lspconfig")
    --   local cmp_nvim_lsp = require("cmp_nvim_lsp")
    --   local keymap = vim.keymap
    --
    --   local opts = { noremap = true, silent = true }
    --   local capabilities = cmp_nvim_lsp.default_capabilities()
    --
    --   lspconfig["tailwindcss"].setup({
    --     root_dir = function()
    --       return require("lspconfig.util").root_pattern(".git")(...)
    --     end,
    --   })
    --   lspconfig["tailwindcss"].setup({})
    --   lspconfig["tsserver"].setup({
    --         require("typescript").setup({ server = opts })
    --         return true
    --   })
    --   lspconfig["delphi_ls"]=.setup({})
    --   lspconfig["ruff"]=.setup({})
    --   --     tsserver = function(_, opts)
    --   --       require("typescript").setup({ server = opts })
    --   --       return true
    --   --     end,
    -- end,
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
