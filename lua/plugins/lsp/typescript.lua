local keymap = vim.keymap.set

return {
  "pmizio/typescript-tools.nvim",
  ft = {
    "javascript",
    "javascriptreact",
    "javascript.jsx",
    "typescript",
    "typescriptreact",
    "typescript.tsx",
  },
  lazy = false,
  dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  config = function()
    local api = require("typescript-tools.api")
    require("lazyvim.util.lsp").on_attach(function(client, bufnr)
      if client.name == "typescript-tools" then
        keymap(
          "n",
          "<leader>cla",
          "<cmd>TSToolsAddMissingImports<cr>",
          { buffer = bufnr, desc = "Add Missing Imports" }
        )
        keymap("n", "<leader>clo", "<cmd>TSToolsOrganizeImports<cr>", { buffer = bufnr, desc = "Organize Imports" })
        keymap("n", "<leader>clO", "<cmd>TSToolsSortImports<cr>", { buffer = bufnr, desc = "Sort Imports" })
        keymap("n", "<leader>clu", "<cmd>TSToolsRemoveUnused<cr>", { buffer = bufnr, desc = "Removed Unused" })
        keymap(
          "n",
          "<leader>clr",
          "<cmd>TSToolsRemoveUnusedImports<cr>",
          { buffer = bufnr, desc = "Removed Unused Imports" }
        )
        keymap(
          "n",
          "<leader>cld",
          "<cmd>TSToolsGoToSourceDefinition<cr>",
          { buffer = bufnr, desc = "Go To Source Definition" }
        )
        keymap("n", "<leader>clf", "<cmd>TSToolsFixAll<cr>", { buffer = bufnr, desc = "Fix All" })
        require("twoslash-queries").attach(client, bufnr)
      end
    end)
    require("typescript-tools").setup({})
  end,
}
