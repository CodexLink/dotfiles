-- lualine.lua | Plugin spec for the 'lualine', used for the package manager lazy.nvim"
-- Version 0.1.0  | Since 01/11/2023
-- @CodexLink     | https://github.com/CodexLink

return {
	"stevearc/dressing.nvim",
	config = function()
		require("dressing").setup({
		input = {
			override = function(conf)
				conf.col = -1
				conf.row = 0
				return conf
			end,
		}
	})
	end,
	lazy = false
}
