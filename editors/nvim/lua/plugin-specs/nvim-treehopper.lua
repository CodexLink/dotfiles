-- nvim-treehopper.lua | Plugin spec for the 'nvim-treehopper', used for the package manager lazy.nvim"
-- Version 0.1.0  | Since 01/11/2023
-- @CodexLink     | https://github.com/CodexLink

return {
	"mfussenegger/nvim-treehopper",
	dependencies = {
		{ "phaazon/hop.nvim", lazy = false }
	},
	keys = {
		{ "fT", function() require("tsht").nodes() end, desc = "Toggle nodes to region highlight." },
	},
	lazy = false,
}
