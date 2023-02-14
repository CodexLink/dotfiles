---@module 'treesitter'
---@author CodexLink <https://github.com/CodexLink>
---@license Apache-2.0
--@info [1] According to the issue (https://github.com/LazyVim/LazyVim/issues/2) from LazyVim, there were build failures and repeating compilation for every new buffer were done by `nvim-treesitter`.
--@info Since then, latest upstream should be used by setting version to `false`.
--@info ! Note that this also works on any other plugins that has a very stale version release, using their latest upstream would make it better, but not really recommended.

return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
    lazy = true,
    event = { "BufAdd", "BufReadPost", "BufNewFile" },
    opts = {
      additional_vim_regex_highlighting = false,
      autopairs = { enable = true },
      ensure_installed = {
        "c",
        "comment",
        "cpp",
        "css",
        "dockerfile",
        "gitignore",
        "go",
        "graphql",
        "html",
        "http",
        "javascript",
        "json",
        "json5",
        "jsonc",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "regex",
        "rust",
        "scss",
        "solidity",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vue",
        "yaml"
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
      },
      incremental_selection = { enable = true },
      indent = { enable = true },
      keymaps = { -- Experimental, I'm currently figuring this one out.
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
      matchup = { enable = true },
      textobjects = { enable = true }
    },
    version = false
  },
  -- ! Shows the header of a certain section of the code.
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    lazy = false,
    config = function() require("treesitter-context").setup() end,
  },
  {
    -- ! Highlights similar case of a certain pattern from the code, similar to vscode's highlight behavior.
    "RRethy/vim-illuminate",
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    lazy = true,
    opts = { delay = 200 }
  }
}
