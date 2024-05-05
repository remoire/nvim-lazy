return {
  {
    "marilari88/twoslash-queries.nvim",
    ft = {
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
    config = true,
  },

  {
    "andrewferrier/debugprint.nvim",
    opts = {},
    dependencies = {
      "echasnovski/mini.nvim", -- Needed to enable :ToggleCommentDebugPrints
      "nvim-treesitter/nvim-treesitter", -- Only needed for NeoVim 0.8
    },
    config = function()
      require("debugprint").setup({
        filetypes = {
          -- ["tsx"] = tsx_format,
          ["tsx"] = js,
        },
      })
    end,
    -- end,
  },
  -- Debug, live change
  { "metakirby5/codi.vim" },
}
