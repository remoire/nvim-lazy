return {
  -- neorg
  { "vhyrro/luarocks.nvim", priority = 1000, config = true },
  -- { "nvim-neorocks/rocks.nvim" },
  {
    "nvim-neorg/neorg",
    lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
    version = "*", -- Pin Neorg to the latest stable release
    enabled = true,
    ft = "norg",
    dependencies = { "luarocks.nvim", "nvim-lua/plenary.nvim" },
    cmd = "Neorg",
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.norg.concealer"] = {
            config = {
              icons = {
                heading = {
                  enabled = true,

                  level_1 = {
                    enabled = true,
                    icon = "◉",
                  },
                  level_2 = {
                    enabled = true,
                    icon = " ○",
                  },
                  level_3 = {
                    enabled = true,
                    icon = "  ●",
                  },
                  level_4 = {
                    enabled = true,
                    icon = "   ○",
                  },
                },
              },
            },
          },
          ["core.summary"] = {},
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
              name = "[Norg]",
            },
          },
          ["core.integration.nvim-cmp"] = {},
          ["core.keybinds"] = {
            -- https://github.com/nvim-neorg/neorg/blob/main/lua/neorg/modules/core/keybinds/keybinds.lua
            config = {
              default_keybinds = true,
              neorg_leader = "<Leader><Leader>",
            },
          },
          ["core.norg.dirman"] = {
            config = {
              workspaces = {
                notes = "~/neorg/notes",
              },
            },
          },
        },
      })
    end,
  },

  -- markdown
  {
    "gaoDean/autolist.nvim",
    ft = {
      "markdown",
      "text",
      "tex",
      "plaintex",
      "norg",
    },
    config = function()
      require("autolist").setup({
        lists = {
          markdown = {},
        },
      })

      vim.keymap.set("i", "<tab>", "<cmd>AutolistTab<cr>")
      vim.keymap.set("i", "<s-tab>", "<cmd>AutolistShiftTab<cr>")
      -- vim.keymap.set("i", "<c-t>", "<c-t><cmd>AutolistRecalculate<cr>") -- an example of using <c-t> to indent
      vim.keymap.set("i", "<CR>", "<CR><cmd>AutolistNewBullet<cr>")
      vim.keymap.set("n", "o", "o<cmd>AutolistNewBullet<cr>")
      vim.keymap.set("n", "O", "O<cmd>AutolistNewBulletBefore<cr>")
      vim.keymap.set("n", "<CR>", "<cmd>AutolistToggleCheckbox<cr><CR>")
      vim.keymap.set("n", "<C-r>", "<cmd>AutolistRecalculate<cr>")

      -- cycle list types with dot-repeat
      vim.keymap.set("n", "<leader>cn", require("autolist").cycle_next_dr, { expr = true })
      vim.keymap.set("n", "<leader>cp", require("autolist").cycle_prev_dr, { expr = true })

      -- if you don't want dot-repeat
      -- vim.keymap.set("n", "<leader>cn", "<cmd>AutolistCycleNext<cr>")
      -- vim.keymap.set("n", "<leader>cp", "<cmd>AutolistCycleNext<cr>")

      -- functions to recalculate list on edit
      vim.keymap.set("n", ">>", ">><cmd>AutolistRecalculate<cr>")
      vim.keymap.set("n", "<<", "<<<cmd>AutolistRecalculate<cr>")
      vim.keymap.set("n", "dd", "dd<cmd>AutolistRecalculate<cr>")
      vim.keymap.set("v", "d", "d<cmd>AutolistRecalculate<cr>")
    end,
  },

  -- obsidian
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
            path = "/Users/rezaarya4/Documents/Obsidian/obsidian-main-vault",
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
        ---@param url string
        follow_url_func = function(url)
          vim.fn.jobstart({ "open", url }) -- Mac OS
        end,
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
          ["<leader>cl"] = {
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
