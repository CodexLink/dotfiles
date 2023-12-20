---@module 'ui-helpers'
---@author CodexLink <https://github.com/CodexLink>
---@license Apache-2.0

return {
  {
    -- NOTE: Alternative dialogue, similar to `telescope.nvim`.
    "stevearc/dressing.nvim",
    config = true,
    lazy = false,
    opts = {
      input = {
        override = function(conf)
          conf.col = -1
          conf.row = 0
          return conf
        end
      },
      mappings = {
        n = {
          ["<Esc>"] = "Close",
          ["<CR>"] = "Confirm",
        },
        i = {
          ["<C-c>"] = "Close",
          ["<C-w>"] = "Confirm",
          ["<C-q>"] = "HistoryPrev",
          ["<C-e>"] = "HistoryNext",
        },
      },
    },
  },
  {
    -- NOTE: Displays git states from each line either by blame or by hunk (changes from that line).
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    config = function()
      require("scrollbar.handlers.gitsigns").setup()
      -- NOTE: Since we overriden the config field of this plugin spec, we have to re-establish this plugin's setup.
      -- NOTE: We cannot use `opts` field anymore because of the potential conflict configuration with the `config` field.
      require("gitsigns").setup({
        current_line_blame = true,
        numhl = true,
        signs = {
          add = { text = '+' },
          change = { text = '~' },
          delete = { text = '-' },
          topdelete = { text = '--' },
          changedelete = { text = '=' },
          untracked = { text = '?' },
        }
      })

      -- Preference: Just wanted to enable it already.
      require("gitsigns").toggle_current_line_blame()
    end,
    lazy = true
  },
  {
    -- NOTE: Colorizes any string that states a color.
    "NvChad/nvim-colorizer.lua",
    config = true,
    event = { "BufAdd", "BufNewFile", "BufReadPost" }
  },
  {
    -- NOTE: Displays context per indentation to see what part of code scope are we based on the cursor position.
    -- This just visually supports `aerial.nvim`.
    "haringsrob/nvim_context_vt",
    config = true,
    event = { "BufAdd", "BufNewFile", "BufReadPost" },
  },
  {
    -- NOTE: Display notification from the right side, similar to modern game notification system.
    -- NOTE: Lazy-loaded because only my own config will use this plugin.
    "rcarriga/nvim-notify",
    config = function(_, opts)
      require("notify").setup(opts)
      vim.notify = require("notify")
    end,
    lazy = false,
    opts = { render = "compact" }
  },
  {
    -- NOTE: Better alternative for `GIX DECO Comments` plugin from VSCode
    "folke/todo-comments.nvim",
    config = true,
    event = { "BufReadPost" },
  },
  {
    -- NOTE: Just a typescript-specific plugin that displays the evaluated type of the context.
    "marilari88/twoslash-queries.nvim",
    config = true,
    ft = { "ts", "tsx" },
    lazy = true,
    opts = {
      multi_line = true
    },
  },
  {
    -- NOTE: Code dimmer (by buffer, blocks) when the cursor is focused elsewhere.
    "folke/twilight.nvim",
    config = function(_, opts)
      -- Setup the plugin first.
      require("twilight").setup(opts)
    end,
    lazy = true,
    opts = {
      dimming = { alpha = .40 }
    }
  },
}
