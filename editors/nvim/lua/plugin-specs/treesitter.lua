-- treesitter.nvim	| Plugin spec for the 'nvim-treesitter' and its `friends`, used for the package manager lazy.nvim".
-- @CodexLink    		| https://github.com/CodexLink

-- Info
-- [1] According to the issue (https://github.com/LazyVim/LazyVim/issues/2) from LazyVim, there were build failures and repeating compilation for every new buffer were done by `nvim-treesitter`.
-- Since then, latest upstream should be used by setting version to `false`.
-- ! Note that this also works on any other plugins that has a very stale version release, using their latest upstream would make it better, but not really recommended.

return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
		dependencies = {
			{ "andymass/vim-matchup", config = function() vim.g.matchup_matchparen_offscreen = { method = "popup" } end,
				event = "BufReadPost", version = false },
			{ "nvim-treesitter/nvim-treesitter-context", config = function() require("treesitter-context").setup() end,
				event = "BufReadPost" }
		},
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
	}
}
