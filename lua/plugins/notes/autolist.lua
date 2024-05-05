return {
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
}