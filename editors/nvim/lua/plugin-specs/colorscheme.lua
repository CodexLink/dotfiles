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
      CursorLineNr = { bg = "NONE", fg = "#FECE2A" },
      Comment = { bg = "NONE", fg = "#00BFFF" },
      Directory = { bg = "NONE", fg = "#FECE2A" },
      WinSeparator = { bg = "NONE", fg = "#FECE2A" },
      Normal = { bg = "NONE" },
      NormalNC = { bg = "NONE" },
      NormalSB = { bg = "NONE" },
      LineNr = { fg = "#FFFFFF" },
      EndOfBuffer = { bg = "NONE", fg = "#00BFFF" }
    },
    integrations = {
      aerial = true,
      cmp = true,
      fidget = true,
      hop = true,
      leap = true,
      lsp_trouble = true,
      mason = true,
      notify = true,
      telescope = {
        enabled = true
      },
      which_key = true
    },
    styles = {
      functions = { "bold" },
      types = { "standout" }
    },
  },
  priority = 1000
}
