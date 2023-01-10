-- ssr.nvim	 | Plugin spec for the 'bufferline', used for the package manager lazy.nvim"
-- Version 0.1.0 | Since 01/11/2023
-- @CodexLink    | https://github.com/CodexLink

return {
	"cshuaimin/ssr.nvim",
	config = true,
	keys = {
		{ "<leader>SR", function () require("ssr").open() end, mode={ "n", "x" }, desc = "Show 'Structural Search and Replace'." },
	},
	lazy = false
}
