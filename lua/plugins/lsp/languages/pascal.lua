-- pascal, delphi
return {
  "skywind3000/asyncrun.vim", -- async make
  "mattia72/vim-delphi", -- aligning
  "dylanaraps/pascal_lint.nvim", -- linter
  "vim-scripts/fpc.vim",
  config = function()
    require("vim-delphi").setup()
    require("pascal_list.nvim").setup()
    require("asyncrun.vim").setup()
    require("fpc.vim").setup()
  end,
}
