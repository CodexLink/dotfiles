-- windows.nvim	 | Plugin spec for the 'windows', used for the package manager lazy.nvim"
-- Version 0.1.0 | Since 01/05/2023
-- @CodexLink    | https://github.com/CodexLink

-- Info
-- [1] If I didn't like the default config of the window's width, I might just adjust it here.
return {
	"anuvyklack/windows.nvim",
	config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup()
		end,
	dependencies = {
		{ "anuvyklack/middleclass" },
		{ "anuvyklack/animation.nvim" }
	},
	keys = {
		{ "<C-W>M", "<CMD>WindowsMaximize<CR>", desc = "Maximize the focused window." },
		{ "<C-W>|", "<CMD>WindowsMaximizeVertically<CR>", desc = "Maximize vertical side of the focused window." },
		{ "<C-W>-", "<CMD>WindowsMaximizeHorizontally<CR>", desc = "Maximize horizontal side of the focused window." },
		{ "<C-W>=", "<CMD>WindowsEqualize<CR>", desc = "Equalize all windows." }
	},
	lazy = false,
}
