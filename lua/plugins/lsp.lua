return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "shellcheck",
        "luacheck",
        "shfmt",
        "flake8",
        "selene",
        "shfmt",
        "tailwindcss-language-server",
        "typescript-language-server",
        "css-lsp",
        "jdtls",
      },
    },
  },
}
