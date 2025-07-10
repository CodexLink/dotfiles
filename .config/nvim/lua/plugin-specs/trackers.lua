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
      local blacklist = {
        'science',
        'engineering'
      }

      -- Find substring, not exact string.
      local is_blacklisted = function(opts)
        for _, word in ipairs(blacklist) do
          if string.find(opts.workspace, word) then
            return true
          end
        end

        return false
      end

      return {
        editor = {
          client = '469726647545757741',
          tooltip = 'Ahh yes, a CLI Editor that makes you say: "look ma, no mouse!" :3',
          icons = nil
        },
        idle = {
          details = function(opts)
            return string.format('Looking at your beauty :3')
          end
        },
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
          viewing = function(opts)
            if is_blacklisted(opts) then
              local text = string.format('Viewing (%s:%s)', opts.cursor_line, opts.cursor_char)

              if vim.bo.modified then text = text .. ' [+]' end
              return text
            end

            local text = string.format('Viewing %s (%s:%s)', opts.filename, opts.cursor_line, opts.cursor_char)

            if vim.bo.modified then text = text .. ' [+]' end
            return text
          end,
          editing = function(opts)
            if is_blacklisted(opts) then
              local text = string.format('Editing (%s:%s)', opts.cursor_line, opts.cursor_char)

              if vim.bo.modified then text = text .. ' [+]' end
              return text
            end

            local text = string.format('Editing %s (%s:%s)', opts.filename, opts.cursor_line, opts.cursor_char)

            if vim.bo.modified then text = text .. ' [+]' end
            return text
          end,
          workspace = function(opts) return 'Elysia: Hi~! Did you miss me? :3' end,
        }
      }
    end
  },
  { "YannickFricke/codestats.nvim", config = function() require("codestats-nvim").setup() end, dependencies = "nvim-lua/plenary.nvim", event = "VeryLazy" } -- [1]
}
