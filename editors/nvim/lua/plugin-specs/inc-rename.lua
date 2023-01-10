-- inc-rename.lua | Plugin spec for the 'inc-rename', used for the package manager lazy.nvim"
-- Version 0.1.0  | Since 01/11/2023
-- @CodexLink     | https://github.com/CodexLink

return {
	"smjonas/inc-rename.nvim",
	config = function()
		require("inc_rename").setup({
			input_buffer_type = "dressing",
		})
	end,
	keys = {
		{ "<S-F2>", ":IncRename ", desc = "Incremental renaming by typing the name." },
		{ "<F2>", function() return ":IncRename " .. vim.fn.expand("<CWORD>") end, desc = "Incremental renaming by typing the name.", { expr = true }},
	},
	lazy = false
}
