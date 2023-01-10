-- gitsigns.lua | Plugin spec for the 'gitsigns', used for the package manager lazy.nvim"
-- Version 0.1.0  | Since 01/11/2023
-- @CodexLink     | https://github.com/CodexLink

-- Info
-- [1] I don't like the boostrap function, therefore, I will be using the lazy.nvim's key field.
return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			current_line_blame = true,
			numhl = true,
			word_diff = true
		})
	end,
	keys = {
		{ "<C-G>h", "<CMD>Gitsigns preview_hunk<CR>", desc = "Preview hunk (changes on certain code line)." },
		{ "<C-G>b", "<CMD>Gitsigns toogle_current_line_blame<CR>", desc = "Toggle line blame." },
		{ "<C-G>d", "<CMD>Gitsigns diffthis<CR>", desc = "Activate 'diffthis' on current line." },
		{ "<C-G>D", function() require("gitsigns").diffthis("~") end, desc = "Activate `diffthis` on whole file." },
	},
	lazy = false
}
