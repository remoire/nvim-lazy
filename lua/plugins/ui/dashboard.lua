return {
  "nvimdev/dashboard-nvim",
  enabled = true,
  event = "VimEnter",
  opts = function(_, opts)
    local logo = [[
                                          
                              /          
          ___  ___  _ _  ___    ___  ___ 
          |   )|___)| | )|   )| |   )|___)
          |    |__  |  / |__/ | |    |__  
                                          
      ]]

    logo = string.rep("\n", 8) .. logo .. "\n\n"
    opts.config.header = vim.split(logo, "\n")
  end,
}
