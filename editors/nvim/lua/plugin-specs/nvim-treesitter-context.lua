-- nvim-treesitter-context.lua | Plugin spec for the 'nvim-treesitter-context', used for the package manager lazy.nvim"
-- Version 0.1.0  | Since 01/11/2023
-- @CodexLink     | https://github.com/CodexLink

return {
	"nvim-treesitter/nvim-treesitter-context",
	config = true,
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	keys = {
		{"<LEADER>Tce", "<CMD>TSContextEnable<CR>", desc = "Enable `treesitter-context`."}
		{"<LEADER>Tcd", "<CMD>TSContextDisable<CR>", desc = "Disable `treesitter-context`."}
		{"<LEADER>Tct", "<CMD>TSContextToggle<CR>", desc = "Toggle `treesitter-context`."}
	},
	lazy = true
}
