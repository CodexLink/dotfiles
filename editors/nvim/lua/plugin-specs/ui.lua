---@module 'ui'
---@author CodexLink <https://github.com/CodexLink>
---@license Apache-2.0

return {
  {
    -- NOTE: DAP-Equivalent for displaying code context in one sidebar.
    "stevearc/aerial.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {
      backends = { "lsp" },
      filter_kind = false,
      highlight_on_hover = true,
      keymaps = {
        ["z"] = "actions.tree_toggle",
        ["x"] = "actions.tree_open_recursive",
        ["c"] = "actions.tree_close_recursive",
      },
      show_guides = true
    },
  },
  {
    -- NOTE: Just an LSP stats indicator on top of the 'lualine'.
    "j-hui/fidget.nvim",
    event = "LspAttach",
    lazy = true,
    config = function(_, opts) require("fidget").setup(opts) end,
    opts = {
      progress = { display = { progress_icon = { { pattern = "dots", period = 1 } } } }
    },
  },
  {
    -- NOTE: VSCode style code context previewer, binds to LSP actions.
    "DNLHC/glance.nvim",
    config = function()
      local glance = require("glance")
      local glance_actions = glance.actions

      glance.setup({
        border = {
          enable = true, -- Show window borders. Only horizontal borders allowed
          top_char = '―',
          bottom_char = '―',
        },
        mappings = {
          list = {
            ['<A-e>'] = glance_actions.preview_scroll_win(-5),
            ['<A-q>'] = glance_actions.preview_scroll_win(5)
          }
        }
      })
    end,
    lazy = true
  },
  -- NOTE: Indention guider, useful on identifying space or tabs on code.
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    main = "ibl",
  },
  {
    -- NOTE: Lazygit but in neovim window, added in the UI as its not an enhancement plugin but rather an extender which is a UI component at this point.
    "kdheepak/lazygit.nvim",
    lazy = true,
    config = function()
      vim.g.lazygit_floating_window_use_plenary = 1
      vim.g.lazygit_use_neovim_remote = 0
    end
  },
  {
    -- NOTE: Status bar for the editor.
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function(_, opts)
      local th = require('lualine.themes.catppuccin')
      th.normal.c.bg = nil
      opts.options.theme = th

      require("lualine").setup(opts)
    end,
    opts = {
      extensions = { "aerial" },
      options = {
        component_separators = "",
        globalstatus = true,
        icons_enabled = true,
        section_separators = { left = "", right = "" },
        -- theme = "catppuccin"
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
          {
            "filename",
            symbols = {
              separator = "",
              modified = ' +',
              readonly = ' —',
              unnamed = '???',
              newfile = ' N',
            },
          },
          { "aerial", dense = true, dense_sep = ".", sep = " -> ", separator = { right = "" } },
        },
        lualine_c = {
          { '=%', separator = "" }
        },
        lualine_x = {},
        lualine_y = {
          { "diagnostics", sources = { "nvim_lsp", "nvim_diagnostic", "nvim_workspace_diagnostic", separator = { left = "" } } },
          { "branch", separator = "" },
        },
        lualine_z = { {
          function()
            local _wakatime = require("utils").WakaTimeToday
            if _wakatime == nil or _wakatime == '' then
              return "—"
            else
              return _wakatime
            end
          end,
          icon = "󰔚 ",
          separator = { left = "", right = "" },
        } },
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
  },
  -- NOTE: Literally a scrollbar, but in nvim.
  {
    "petertriho/nvim-scrollbar",
    event = "BufReadPost",
  },
  {
    -- NOTE: File explorer, but in dialogue, this is very similar to `dressing.nvim`, but has all-in-one capabilities.
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    config = function()
      -- NOTE:!! Since `opts` cannot recognize other plugins and there are other configs that needed to be done after initializing the plugins through `function` scope, I have to not lazy-load them and NOT load them on init.
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
      { "nvim-telescope/telescope-file-browser.nvim", lazy = true },
      { 'nvim-telescope/telescope-fzf-native.nvim',   build = "make" }
    },
    lazy = true
  },
  {
    -- NOTE: Displays icons, more like from the `Nerd Fonts`, note that lots of plugins depend on this plugin!
    "nvim-tree/nvim-web-devicons",
    lazy = true,
    opts = {
      color_icons = true,
      default = true
    }
  },
  {
    -- NOTE: Bottom panel that contains diagnostics.
    "folke/trouble.nvim",
    lazy = true,
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
  }
}
