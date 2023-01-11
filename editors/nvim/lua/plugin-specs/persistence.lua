-- persistence.lua | Plugin spec for the 'persistence', used for the package manager lazy.nvim"
-- Version 0.1.0  | Since 01/11/2023
-- @CodexLink     | https://github.com/CodexLink

return {
	"folke/persistence.nvim",
	config = true,
	keys = {
		{"<LEADER>plc", [[<CMD>lua require("persistence").load()<CR>]], desc = "Persistence: Load session from the current directory."},
		{"<LEADER>pls", [[<CMD>lua require("persistence").load({ last = true})<CR>]], "", desc = "Persistence: Load session from the last session."},
		{"<LEADER>pq", [[<CMD>lua require("persistence").stop()<CR]], "", desc = "Persistence: Stop saving current session on exit."},
	},
	lazy = false
}
