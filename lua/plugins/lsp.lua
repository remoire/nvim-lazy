return {
  require("plugins.lsp.lsp-config"),
  require("plugins.lsp.lsp-languages"), -- my custom languages
  require("plugins.lsp.mason"),
  require("plugins.lsp.treesitter"), -- Highlighter
  require("plugins.lsp.autocompletion"),
}
