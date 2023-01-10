-- leap.lua | Plugin spec for the 'leap', used for the package manager lazy.nvim"
-- Version 0.1.0  | Since 01/11/2023
-- @CodexLink     | https://github.com/CodexLink

return {
	"ggandor/leap.nvim",
	config = function() require("leap").add_default_mappings() end,
	lazy = false
}
