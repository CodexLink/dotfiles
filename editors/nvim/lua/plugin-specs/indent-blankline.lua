-- indent-blankline.lua | Plugin spec for the 'indent-blankline', used for the package manager lazy.nvim"
-- Version 0.1.0  | Since 01/05/2023
-- @CodexLink     | https://github.com/CodexLink

return {
        "lukas-reineke/indent-blankline.nvim",
	lazy = false,
        config = {
		show_current_context = true,
		show_current_context_start = true,
		show_end_of_line = true
	}
}
