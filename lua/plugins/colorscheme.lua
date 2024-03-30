return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "macchiato",
      })
      vim.cmd("colorscheme catppuccin")
    end,
  },

  {
    "2nthony/vitesse.nvim",
    dependencies = {
      "tjdevries/colorbuddy.nvim",
    },
    opts = function()
      require("vitesse").setup({
        transparent_background = true,
        transparent_float_background = true, -- aka pum(popup menu) background
      })
    end,
  },

  {
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
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "vitesse",
    },
  },
}
