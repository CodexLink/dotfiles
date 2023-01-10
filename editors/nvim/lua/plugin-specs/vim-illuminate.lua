-- vim-illuminate.nvim	 | Plugin spec for the 'vim-illuminate', used for the package manager lazy.nvim"
-- Version 0.1.0 | Since 01/05/2023
-- @CodexLink    | https://github.com/CodexLink

return {
	"RRethy/vim-illuminate",
	config = function() require("illuminate").configure({}) end,
	lazy = false
}
