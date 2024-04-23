---@module "trackers"
---@author CodexLink <https://github.com/CodexLink>
---@license Apache-2.0
---@info [1] Requires `CODESTATS_API_KEY` on Environmental Variables.

return {
  { "wakatime/vim-wakatime",        event = "VeryLazy" },
  { "andweeb/presence.nvim",        config = true,                                             event = "VeryLazy" },
  { "YannickFricke/codestats.nvim", config = function() require("codestats-nvim").setup() end, dependencies = "nvim-lua/plenary.nvim", event = "VeryLazy" } -- [1]
}
