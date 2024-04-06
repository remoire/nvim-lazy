-- java
return { "mfussenegger/nvim-jdtls" }, { "mfussenegger/nvim-dap", config = function() end }, {
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
}
