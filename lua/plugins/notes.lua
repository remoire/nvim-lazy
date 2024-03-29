return {
  {
    "nvim-neorg/neorg",
    enabled = false,
    config = function()
      require("neorg").setup({})
    end,
  },

  {
    "jakewvincent/mkdnflow.nvim",
    enabled = true,
    config = function()
      local mkdnflow = require("mkdnflow")
      mkdnflow.setup({})
    end,
  },

  {
    "epwalsh/obsidian.nvim",
    version = "*", -- recommended, use latest release instead of latest commit
    ft = "markdown",
    lazy = "false",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("obsidian").setup({
        workspaces = {
          {
            name = "main-vault",
            path = "/Users/rezaarya4/Documents/Obsidian/main-vault",
          },
        },
        templates = {
          subdir = "Templates",
        },
        completion = {
          nvim_cmp = true,
          min_chars = 2,
        },
        notes_subdir = "Zettelkasten",
        note_id_func = function(title)
          return title
        end,
        new_notes_location = "notes_subdir",
        daily_notes = {
          folder = "Reviews/Daily",
          template = "Daily.md",
        },
        mappings = {
          ["gf"] = {
            action = function()
              return require("obsidian").util.gf_passthrough()
            end,
            opts = { noremap = false, expr = true, buffer = true },
          },
          -- Toggle check-boxes.
          ["<leader>ch"] = {
            action = function()
              return require("obsidian").util.toggle_checkbox()
            end,
            opts = { buffer = true },
          },
        },
        ui = {
          enable = true,
        },
      })

      -- Obsidian keymaps
      local keymap = vim.keymap
      keymap.set(
        "n",
        "<leader>oc",
        "<cmd>lua require('obsidian').util.toggle_checkbox()<cr>",
        { desc = "Obsidian Check Checkbox" }
      )

      keymap.set("n", "<leader>ot", "<cmd>ObsidianTemplate<cr>", { desc = "Insert Obsidian Template" })
      keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<cr>", { desc = "Open in Obsidian App" })
      keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<cr>", { desc = "Show ObsidianBacklinks" })
      keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<cr>", { desc = "Show ObsidianLinks" })
      keymap.set("n", "<leader>on", "<cmd>ObsidianNew<cr>", { desc = "Create New Note" })
      keymap.set("n", "<leader>od", "<cmd>ObsidianToday<cr>", { desc = "Create New Note" })
      keymap.set("n", "<leader>of", "<cmd>ObsidianSearch<cr>", { desc = "Search Obsidian text" })
      keymap.set("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Quick Switch" })

      vim.wo.conceallevel = 1
    end,
  },
}
