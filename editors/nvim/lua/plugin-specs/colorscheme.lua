---@module 'colorscheme'
---@author CodexLink <https://github.com/CodexLink>
---@license Apache-2.0
---@info [1] Higher priority is required for the colorscheme, as stated by the author of the package manager.

return {
  "catppuccin/nvim",
  name = "catppuccin",
  config = function() vim.cmd.colorscheme('catppuccin') end,
  priority = 1000,
}
