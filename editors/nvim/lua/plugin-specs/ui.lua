---@module 'ui'
---@author CodexLink <https://github.com/CodexLink>
---@license Apache-2.0

return {
  {
    -- ! DAP-Equivalent for displaying code context in one sidebar.
    "stevearc/aerial.nvim",
    config = true,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" }
    },
    lazy = true,
    opts = {
      backends = { "lsp" },
      filter_kind = false,
      highlight_on_hover = true,
      show_guides = true
    }
  },
  {
    -- ! Buffer file displayed as a tab.
    "akinsho/bufferline.nvim",
    dependencies = {
      { "nvim-tree/nvim-web-devicons" }
    },
    event = { "BufReadPost", "BufAdd", "BufNewFile" },
    lazy = true,
    opts = {
      options = {
        always_show_bufferline = true,
        color_icons = false,
        diagnostics = "nvim_lsp",
        groups = {
          options = {
            toggle_hidden_on_enter = true
          }
        },
        hover = {
          enabled = true,
          delay = 200,
          reveal = { "close" }
        },
        show_close_icon = false,
        show_buffer_close_icons = false,
        show_tab_indicators = true
      }
    }
  },
  {
    -- ! Indention guider, useful on identifying space or tabs on code.
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    opts = {
      show_current_context = true,
      show_current_context_start = true,
      show_end_of_line = true
    }
  },
  {
    -- ! Lazygit but in neovim window, added in the UI as its not an enhancement plugin but rather an extender which is a UI component at this point.
    "kdheepak/lazygit.nvim",
    lazy = true,
    config = function()
      vim.g.lazygit_floating_window_use_plenary = 1
      vim.g.lazygit_use_neovim_remote = 0
    end
  },
  {
    -- ! Status bar for the editor.
    "nvim-lualine/lualine.nvim",
    lazy = false,
    opts = {
      extensions = { "aerial" },
      options = {
        component_separators = "",
        globalstatus = true,
        icons_enabled = true,
        section_separators = { left = "", right = "" }
      },
      -- @note For section a, b, c, the left seperator is displayed on right side for other elements while first element is displayed at left.
      -- @note This was the same case for the section x, y, z but in opposite.
      -- @note Using the opposite of the dominant of the section (for instance, using right side of the left section (and those are section a, b, c)) destroys the style of the next element!
      -- @note Using the opposite to the last element will make things more elegant to look at.
      sections = {
        lualine_a = {
          { "mode", separator = { left = "", right = "" } },
        },
        lualine_b = {
          -- @note Right seperator is not handled specially when the next element is hidden.
          -- @note Using custom function for this matter make things a little bit harder to understand and is quite an over-engineer; But since an arrow spike is used as a default, I'm fine with it.
          { "filename", icon = "", separator = "" },
          { "filetype", separator = "" },
          { "aerial",   dense = true,   dense_sep = ".", sep = " -> ", separator = { right = "" } },
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {
          { "diagnostics", sources = { "nvim_lsp", "nvim_diagnostic", "nvim_workspace_diagnostic", separator = { left = "" } } },
          { "branch",      separator = "" },
        },
        lualine_z = {
          { "progress", icon = "李", separator = "" },
          { "location", icon = "", separator = { right = "" } },
        },
      },
      inactive_sections = {
        lualine_a = { "filename", "location" },
        lualine_b = { "diagnostics", "branch" },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { { "aerial", dense = true, sep = " -> " } },
      }
    },
    priority = 900 -- ! Load after `colorscheme`.
  },
  {
    -- ! Literally a scrollbar, but in nvim.
    "petertriho/nvim-scrollbar",
    config = true,
    event = "BufReadPost"
  },
  {
    -- ! File explorer, but in dialogue, this is very similar to `dressing.nvim`, but has all-in-one capabilities.
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    config = function()
      -- !!! Since `opts` cannot recognize other plugins and there are other configs that needed to be done after initializing the plugins through `function` scope, I have to not lazy-load them and NOT load them on init.
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      -- Load the plugin itself first before the extension.
      telescope.setup({
        defaults = {
          layout_config = {
            vertical = { width = 0.5 },
          },
          mappings = {
            i = {
              ["<C-Down>"] = actions.preview_scrolling_down,
              ["<C-q>"] = actions.close,
              ["<C-Up>"] = actions.preview_scrolling_up,
              ["<S-Down>"] = actions.results_scrolling_down,
              ["<S-Up>"] = actions.results_scrolling_up
            },
            n = {
              ["<C-Down>"] = actions.preview_scrolling_down,
              ["<C-Up>"] = actions.preview_scrolling_up,
              ["q"] = actions.close,
              ["<S-Down>"] = actions.results_scrolling_down,
              ["<S-Up>"] = actions.results_scrolling_up
            }
          }
        },
        extensions = {
          file_browser = {
            hijack_netrw = true
          },
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case"
          }
        }
      })

      -- Then load the extensions now.
      telescope.load_extension("fzf")
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "kdheepak/lazygit.nvim",                      lazy = true },
      { "nvim-telescope/telescope-file-browser.nvim", lazy = true },
      { "nvim-telescope/telescope-fzf-native.nvim",   build = "make", lazy = true },
    },
    lazy = true
  },
  {
    -- ! Displays icons, more like from the `Nerd Fonts`, note that lots of plugins depend on this plugin!
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {
      color_icons = true,
      default = true
    }
  },
  {
    -- ! Bottom panel that contains diagnostics.
    "folke/trouble.nvim",
    config = true,
    opts = {
      action_keys = {
        close = "q",
        cancel = "<ESC>",
        refresh = "r",
        jump = { "<CR>", "<TAB>" },
        open_split = "<C-s>",
        open_vsplit = "<C-S>",
        open_tab = "<C-t>",
        jump_close = "o",
        toggle_mode = "m",
        toggle_preview = "P",
        hover = "K",
        preview = "p",
        close_folds = "zc",
        open_folds = "zx",
        toggle_fold = "zz",
        previous = "k",
        next = "j"
      }
    }
  },
  {
    -- ! Similar to every other OS's window nanager where each `n` of scope window contains `k` of tabs.
    "tiagovla/scope.nvim",
    config = true
  }
}
