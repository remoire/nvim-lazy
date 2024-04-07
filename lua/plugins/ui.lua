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
    enabled = false,
  },
  {
    "nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({
        strict = true,
        override_by_extension = {
          astro = {
            icon = "",
            color = "#EF8547",
            name = "astro",
          },
        },
      })
    end,
  },

  {
    "folke/noice.nvim",
    enabled = true,
    opts = function(_, opts)
      table.insert(opts.routes, {
        filter = {
          event = "notify",
          find = "No information available",
        },
        opts = { skip = true },
      })
      local focused = true
      vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
          focused = true
        end,
      })
      vim.api.nvim_create_autocmd("FocusLost", {
        callback = function()
          focused = false
        end,
      })
      table.insert(opts.routes, 1, {
        filter = {
          cond = function()
            return not focused
          end,
        },
        view = "notify_send",
        opts = { stop = false },
      })

      opts.commands = {
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      }

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function(event)
          vim.schedule(function()
            require("noice.text.markdown").keys(event.buf)
          end)
        end,
      })

      opts.presets.lsp_doc_border = true
    end,
  },

  {
    "nvimdev/dashboard-nvim",
    enabled = true,
    event = "VimEnter",
    opts = function(_, opts)
      local logo = [[
                                          
                              /          
          ___  ___  _ _  ___    ___  ___ 
          |   )|___)| | )|   )| |   )|___)
          |    |__  |  / |__/ | |    |__  
                                          
      ]]

      logo = string.rep("\n", 8) .. logo .. "\n\n"
      opts.config.header = vim.split(logo, "\n")
    end,
  },
}
