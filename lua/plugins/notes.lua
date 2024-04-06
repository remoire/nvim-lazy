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
            notes,
          },
        },
      })
    end,
  },

  -- H1
  -- 1e2718
  -- 192e26
  -- 182221
  -- H2
  -- 223332
  -- 436764
  -- 20353d
  -- 50958B
  -- 3B6B78
  -- H3
  -- 213b2e
  -- CAAE84
  -- H4
  -- B7866C
  -- H5
  -- D0492B
  -- Codeblocks
  -- 3B6B78
  -- A98979

  vim.cmd([[highlight Headline1 guibg=#1e2718]]),
  vim.cmd([[highlight Headline2 guibg=#223332]]),
  vim.cmd([[highlight Headline3 guibg=#213b2e]]),
  vim.cmd([[highlight Headline4 guibg=#213b2e]]),
  vim.cmd([[highlight Headline5 guibg=#213b2e]]),
  vim.cmd([[highlight Headline6 guibg=#213b2e]]),
  vim.cmd([[highlight CodeBlock guibg=#1c1c1c]]),
  vim.cmd([[highlight Dash guibg=#D19A66 gui=bold]]),

  -- markdown
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("headlines").setup({
        markdown = {
          query = vim.treesitter.query.parse(
            "markdown",
            [[
                (atx_heading [
                    (atx_h1_marker)
                    (atx_h2_marker)
                    (atx_h3_marker)
                    (atx_h4_marker)
                    (atx_h5_marker)
                    (atx_h6_marker)
                ] @headline)

                (thematic_break) @dash

                (fenced_code_block) @codeblock

                (block_quote_marker) @quote
                (block_quote (paragraph (inline (block_continuation) @quote)))
                (block_quote (paragraph (block_continuation) @quote))
                (block_quote (block_continuation) @quote)
            ]]
          ),
          headline_highlights = { "Headline1", "Headline2" },
          bullet_highlights = {
            "@text.title.1.marker.markdown",
            "@text.title.2.marker.markdown",
            "@text.title.3.marker.markdown",
            "@text.title.4.marker.markdown",
            "@text.title.5.marker.markdown",
            "@text.title.6.marker.markdown",
          },
          bullets = { "◉", "○", "✸", "✿" },
          codeblock_highlight = "CodeBlock",
          dash_highlight = "Dash",
          dash_string = "-",
          quote_highlight = "Quote",
          quote_string = "┃",
          fat_headlines = true,
          fat_headline_upper_string = "▃",
          fat_headline_lower_string = "🬂",
        },
      })
    end,
  },

  {
    "hedyhli/outline.nvim",
    config = function()
      -- Example mapping to toggle outline
      vim.keymap.set("n", "<leader>oo", "<cmd>Outline<CR>", { desc = "Toggle Outline" })

      require("outline").setup({
        -- Your setup opts here (leave empty to use defaults)
      })
    end,
  },

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
      require("autolist").setup()
      -- require("autolist").setup({
      --   enabled = true,
      --   cycle = { -- Cycles the list type in order
      --     "-", -- whatever you put here will match the first item in your list
      --     "*", -- for example if your list started with a `-` it would go to `*`
      --     "1.", -- this says that if your list starts with a `*` it would go to `1.`
      --     "1)", -- this all leverages the power of recalculate.
      --     "a)", -- i spent many hours on that function
      --     "I.", -- try it, change the first bullet in a list to `a)`, and press recalculate
      --   },
      --   lists = {
      --     markdown = {
      --       list_patterns.unordered,
      --       list_patterns.digit,
      --       list_patterns.ascii, -- for example this specifies activate the ascii list
      --       list_patterns.roman, -- type for markdown files.
      --     },
      --     checkbox = {
      --       left = "%[", -- the left checkbox delimiter (you could change to "%(" for brackets)
      --       right = "%]", -- the right checkbox delim (same customisation as above)
      --       fill = "x", -- if you do the above two customisations, your checkbox could be (x) instead of [x]
      --     },
      --   },
      -- })

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
          -- Go to link
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
      -- keymap.set("n", "<leader>oo", "<cmd>ObsidianOpen<cr>", { desc = "Open in Obsidian App" })
      keymap.set("n", "<leader>ob", "<cmd>ObsidianBacklinks<cr>", { desc = "Show ObsidianBacklinks" })
      keymap.set("n", "<leader>oy", "<cmd>ObsidianYesteday<cr>", { desc = "Open Yesterday Daily Note" })
      keymap.set("n", "<leader>ot", "<cmd>ObsidianTomorrow<cr>", { desc = "Open Tomorrow Daily Note" })
      keymap.set("n", "<leader>ol", "<cmd>ObsidianLinks<cr>", { desc = "Show ObsidianLinks" })
      keymap.set("n", "<leader>on", "<cmd>ObsidianNew<cr>", { desc = "Create New Note" })
      keymap.set("n", "<leader>od", "<cmd>ObsidianToday<cr>", { desc = "Open Daily Note" })
      keymap.set("n", "<leader>of", "<cmd>ObsidianSearch<cr>", { desc = "Search Obsidian text" })
      keymap.set("n", "<leader>oq", "<cmd>ObsidianQuickSwitch<cr>", { desc = "Quick Switch" })

      vim.wo.conceallevel = 1
    end,
  },
}
