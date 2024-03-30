return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
  config = function(_, opts)
    local lualine = require("lualine")
    lualine.setup({
      options = {
        theme = "vitesse",
      },
      comment_italics = true,
      transparent_background = true,
      transparent_float_background = true, -- aka pum(popup menu) background
    })
  end,
}
