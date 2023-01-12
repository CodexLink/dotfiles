-- treesitter.nvim	| Plugin spec for the 'nvim-treesitter' and its `friends`, used for the package manager lazy.nvim".
-- Version 0.1.0		| Since 01/11/2023
-- @CodexLink    		| https://github.com/CodexLink

-- Info
-- [1] The plugin[1] is used to understand the file, not as an alternative to LSP.
-- [2] Configuration reference: https://github.com/rafamadriz/dotfiles/commit/c1268c73bdc7da52af0d57dcbca196ca3cb5ed79

return {
	{
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	opts = {
		-- Explicitly stated to ensure that vim native syntax checks aren't added while treesitter does it.
		additional_vim_regex_highlighting = false,
		auto_install = true,

		-- This table contains of all possible plugins that I may use, currently and in the future.
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
		matchup = {
			disable_virtual_text = true,
			enable = true
		},
		sync_install = false,
		textobjects = { enable = true },
		}
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = true,
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		event = "BufFilePre",
		keys = {
			{"<Leader>Tce", "<CMD>TSContextEnable<CR>", desc = "Enable `treesitter-context`."},
			{"<Leader>Tcd", "<CMD>TSContextDisable<CR>", desc = "Disable `treesitter-context`."},
			{"<Leader>Tct", "<CMD>TSContextToggle<CR>", desc = "Toggle `treesitter-context`."}
		}
	}
}
