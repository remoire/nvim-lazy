return {
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
}
