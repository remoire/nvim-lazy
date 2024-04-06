vim.filetype.add({
  extension = {
    astro = "astro",
    mdx = "mdx",
  },
})

vim.treesitter.language.register("markdown", "mdx") -- the mdx filetype will use the markdown parser and queries.
