--@module "colorscheme"
---@author CodexLink <https://github.com/CodexLink>
---@license Apache-2.0
---@info [1] Higher priority is required for the colorscheme, as stated by the author of the package manager.

return {
  "catppuccin/nvim",
  name = "catppuccin",
  config = function(plugin, opts)
    require(plugin.name).setup(opts)
    vim.cmd.colorscheme("catppuccin")
  end,
  opts = {
    custom_highlights = {
      CursorLineNr = { bg = "NONE", fg = "#FFBF00" },
      Comment = { bg = "NONE", fg = "#00BFFF" },
      Directory = { bg = "NONE", fg = "#FFBF00" },
      WinSeparator = { bg = "NONE", fg = "#FFBF00" },
      Normal = { bg = "NONE" },
      NormalNC = { bg = "NONE" },
      NormalSB = { bg = "NONE" },
    },
    styles = {
      functions = { "bold" },
      types = { "standout" }
    },
  },
  priority = 1000
}
