-- neogen.lua | Plugin spec for the 'neogen', used for the package manager lazy.nvim"
-- Version 0.1.0  | Since 01/11/2023
-- @CodexLink     | https://github.com/CodexLink

local kb_opts = { noremap = true, silent = true }

return {
	"danymat/neogen",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("neogen").setup({ snippet_engine = "luasnip" })
	end,
	keys = {
		{"<Leader>GA", [[<CMD>require("neogen").generate()<CR>]], kb_opts}
	},
	lazy = false
}
