---@module 'helpers'
---@author CodexLink <https://github.com/CodexLink>
---@license Apache-2.0

return {
  {
    --- NOTE: Literally a comment creator, this can be paired with annotation plugin.
    "numToStr/Comment.nvim",
    event = { "BufAdd", "BufNewFile", "BufReadPost" }
  },
  {
    --- NOTE: Alternative `git diff` viewer, supported by `lazy.nvim` (package manager).
    "sindrets/diffview.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    lazy = true,
  },
  {
    --- NOTE: Similar to Vimium C, jump to certain part of code, this is way similar to `leap.nvim` but it uses 2 letters to jump to certain part of code.
    --- NOTE: This plugin is useful when we don't want a keyword-based jump.
    "phaazon/hop.nvim",
    lazy = true
  },
  {
    --- NOTE: Incremental renaming context, similar to vscode's F2 rename system but incremental in this case.
    "smjonas/inc-rename.nvim",
    lazy = true,
    opts = { input_buffer_type = "dressing" }
  },
  {
    --- NOTE: External helper tool that helps visualizesa the markdown or text file to the browser.
    "iamcco/markdown-preview.nvim",
    build = function() vim.fn["mkdp#util#install"]() end,
    config = function()
      -- After installation, run other global variable configs.
      --- NOTE: The plugin runs in this way and not in the conventional 'config' function.

      -- Since this plugin is only loaded based on file extensiosn from 'ft' table, do not limit on markdown.
      local vg = vim.g

      vg.mkdp_command_for_global = 1
      vg.mkdp_page_title = "${name} | mkdp (live)"
      vg.mkdp_filetypes = { "markdown", "text" }
    end,
    ft = {
      "markdown",
      "text"
    }
  },
  {
    "danymat/neogen",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("neogen").setup({
        snippet_engine = "luasnip",
        languages = {
          lua = {
            template = {
              annotation_convention = "emmylua"
            }
          }
        }
      })
    end,
    lazy = true,
    version = "*"
  },
  {
    --- NOTE: Auto-adding or wrapping from both ends of a highlighted context.
    "windwp/nvim-autopairs",
    event = { "BufAdd", "BufReadPost", "BufNewFile" },
    opts = {
      check_ts = true,
      fast_wrap = { map = "<M-w>" },
      map_c_w = true,
      map_c_h = true,
      map_cr = true
    }
  },
  -- NOTE: surround.vim but in nvim
  {
    "kylechui/nvim-surround",
    event = { "BufAdd", "BufReadPost", "BufNewFile" },
  },
  {
    -- NOTE: hop.nvim but encapsulates context based on selection of region.
    "mfussenegger/nvim-treehopper",
    dependencies = "phaazon/hop.nvim",
    lazy = true
  },
  {
    "jedrzejboczar/possession.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    lazy = true,
    opts = {
      autosave = {
        current = false,
        tmp = false,
        tmp_name = 'tmp',
        on_load = false,
        on_quit = false
      },
      load_silent = true,
      silent = false
    }
  },
  {
    --- NOTE: Structural search then replace; far more advanced than the conventional find and replace system.
    "cshuaimin/ssr.nvim",
    lazy = true,
    opts = {
      keymaps = {
        close = "q",
        next_match = "n",
        prev_match = "N",
        replace_confirm = "<CR>",
        replace_all = "<Leader><CR>",
      },
    }
  },
  {
    --- NOTE: Code Context to `One-Liner` or `Split-by-Blocks` Plugin.
    "Wansmer/treesj",
    dependencies = "nvim-treesitter/nvim-treesitter",
    lazy = true,
    opts = {
      max_join_length = 2048
    }
  },
  {
    --- NOTE: Outputs keybinds when pressed a key for the editor.
    "folke/which-key.nvim",
    lazy = true,
    opts = {
      layout = {
        spacing = 5,
        align = "center"
      },
      operators = { gc = "Comments" },
      popup_mappings = {
        scroll_down = "<PageDown>",
        scroll_up = "<PageUp>"
      },
      spelling = {
        enabled = true,
        suggestions = 15
      },
    }
  }
}
