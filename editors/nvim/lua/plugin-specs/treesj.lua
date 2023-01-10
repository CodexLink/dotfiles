-- treesj.nvim	 | Plugin spec for the 'treesj', used for the package manager lazy.nvim"
-- Version 0.1.0 | Since 01/11/2023
-- @CodexLink    | https://github.com/CodexLink

return {
	"Wansmer/treesj",
	config = function()
		require("treesj").setup({
			max_join_length = 512
		})
	end,
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	keys = {
		{ "<leader>tr", "<cmd>TSJToggle<cr>", desc = "Toggle 'One-Liner or Splitted Context' Code." },
	},
	lazy = false,

}
