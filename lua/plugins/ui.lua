return {
  {
    "echasnovski/mini.animate",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.scroll = {
        enable = false,
      }
    end,
  },
  {
    "folke/trouble.nvim",
    opts = { use_diagnostic_signs = true },
    -- enabled = false,
  },
}
