---@module "trackers"
---@author CodexLink <https://github.com/CodexLink>
---@license Apache-2.0
---@info [1] Requires `CODESTATS_API_KEY` on Environmental Variables.

return {
  { "wakatime/vim-wakatime",        event = "VeryLazy" },
  {
    "vyfor/cord.nvim",
    build = ":Cord update",
    opts = function()
      return {
        buttons = {
          {
            label = function(_)
              return 'View My Profile'
            end,
            url = function(_)
              return 'https://github.com/CodexLink'
            end
          }
        },
        hooks = {
          post_activity = function(_, activity)
            local version = vim.version()
            activity.assets.small_text = string.format('Neovim %s.%s.%s', version.major, version.minor, version.patch)
          end
        },
        text = {
          editing = function(opts)
            local text = string.format('Editing %s - %s:%s', opts.filename, opts.cursor_line, opts.cursor_char)
            if vim.bo.modified then text = text .. '[+]' end
            return text
          end
        }
      }
    end
  },
  { "YannickFricke/codestats.nvim", config = function() require("codestats-nvim").setup() end, dependencies = "nvim-lua/plenary.nvim", event = "VeryLazy" } -- [1]
}
