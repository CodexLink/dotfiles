-- treesitter.lua | Plugin configuration for `nvim-treesitter/nvim-treesitter`
-- Version 0.1.0  | Since 11/01/2022
-- @CodexLink     | https://github.com/CodexLink

local instantiated, ts_configurator = pcall(require, "nvim-treesitter.configs")
if not instantiated then
	print("Plugin configuration for `nvim-treesitter/nvim-treesitter` has failed to load. The module itself may not be installed properly.")
end

ts_configurator.setup {
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
	}

	highlight = { enable = true },
	incremental_selection = { enable = true },
	indent = { enable = true },
	keymaps = { -- Experimental, I'm currently figuring this one out.
		init_selection = "gnn",
		node_incremental = "grn",
		scope_incremental = "grc",
		node_decremental = "grm",
	},
	sync_install = false,
	textobjects = { enable = true },
}
