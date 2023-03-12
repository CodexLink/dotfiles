---@module 'ui'
---@author CodexLink <https://github.com/CodexLink>
---@license Apache-2.0

return {
  {
    -- NOTE: DAP-Equivalent for displaying code context in one sidebar.
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
      keymaps = {
        ["z"] = "actions.tree_toggle",
        ["x"] = "actions.tree_open_recursive",
        ["c"] = "actions.tree_close_recursive",
      },
      show_guides = true
    }
  },
  {
    -- NOTE: Buffer file displayed as a tab.
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
    -- NOTE: Just an LSP stats indicator on top of the 'lualine'.
    "j-hui/fidget.nvim",
    config = true,
    lazy = true,
    opts = {
      text = { spinner = "dots" }
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
            ['<A-e>'] = glance_actions.preview_scroll_win( -5),
            ['<A-q>'] = glance_actions.preview_scroll_win(5)
          }
        }
      })
    end,
    lazy = true
  },
  {
    -- NOTE: Indention guider, useful on identifying space or tabs on code.
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPost",
    opts = {
      show_current_context = true,
      show_current_context_start = true,
      show_end_of_line = true
    }
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
    lazy = false,
    config = function(_, opts)
      -- Define custom function for the section C.
      -- NOTE: Reference for getting the length (The unary '#' operator): https://en.wikibooks.org/wiki/Lua_Programming/length_operator.
      local lsp_active_server = function()
        local _get_active_servers = vim.lsp.get_active_clients({ buffer = vim.fn.bufnr() })
        if #_get_active_servers == 0 then
          return "None"
        else
          -- NOTE: Only get the first one.
          return _get_active_servers[1].name
        end
      end

      local lsp_active_formatter = function()
        if lsp_active_server() == "sumneko_lua" then
          return "Same as LSP"
        else
          local _available_sources = require("null-ls.sources").get_available(vim.bo.filetype)
          if (#_available_sources == 0) then
            return "None"
          else
            local sources = ""

            for _, each_formatter in pairs(_available_sources) do
              sources = sources .. (_ == 1 and "" or ", ") .. each_formatter.name
            end

            return sources
          end
        end
      end

      -- NOTE: Inject these functions.
      opts.sections.lualine_c[2] = { function() return require("utils").WakaTimeToday end, icon = "󰔚 " }
      opts.sections.lualine_c[3] = { lsp_active_server, icon = "󰒋 " }
      opts.sections.lualine_c[4] = { lsp_active_formatter, icon = "󱇧 " }
      opts.sections.lualine_c[5] = { '=%', separator = "" }
      -- Then run the setup.
      require("lualine").setup(opts)
    end,
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
          { "filename", icon = "",     separator = "" },
          { "filetype", separator = "" },
          { "aerial",   dense = true,     dense_sep = ".",  sep = " -> ", separator = { right = "" } },
        },
        lualine_c = {
          { '%=', separator = "" }
        },
        lualine_x = {},
        lualine_y = {
          { "diagnostics", sources = { "nvim_lsp", "nvim_diagnostic", "nvim_workspace_diagnostic", separator = { left = "" } } },
          { "branch",      separator = "" },
        },
        lualine_z = {
          { "progress", separator = "" },
          { "location", icon = "",     separator = { right = "" } },
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
    priority = 900 -- NOTE: Load after `colorscheme`.
  },
  {
    -- NOTE: Literally a scrollbar, but in nvim.
    "petertriho/nvim-scrollbar",
    config = true,
    event = "BufReadPost"
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
      { "nvim-telescope/telescope-fzf-native.nvim",   build = "make", lazy = true },
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
    -- NOTE: Similar to every other OS's window nanager where each `n` of scope window contains `k` of tabs.
    "tiagovla/scope.nvim",
    config = true
  }
}
