-- local discipline = require("craftzdog.discipline")
-- discipline.cowboy()
local keymap = vim.keymap

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", "J", "mzJ`z")
keymap.set("n", "<C-d>", "<C-d>zz")
keymap.set("n", "<C-u>", "<C-u>zz")
keymap.set("n", "n", "nzzzv")
keymap.set("n", "N", "Nzzzv")

keymap.set("x", "<leader>p", [["_dP]])
keymap.set({ "n", "v" }, "<leader>y", [["+y]])
keymap.set("n", "<leader>Y", [["+Y]])
keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- keymap.set("n", "<leader>xd", "<cmd>lua vim.")
keymap.set(
  "n",
  "<leader>xd",
  "<cmd> lua vim.diagnostic.open_float() <CR>",
  { desc = "Toggle diagnostic floating window" }
)

keymap.set("i", "<C-c>", "<Esc>")

-- Obsidian
keymap.set("n", "<leader>o9", "<cmd>Lazy load obsidian.nvim<cr>", { desc = "Load obsidian.nvim" }) -- load obsidian.nvim from lazy.nvim
