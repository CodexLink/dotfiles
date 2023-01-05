-- diffview.nvim	 | Plugin spec for the 'diffview', used for the package manager lazy.nvim"
-- Version 0.1.0 | Since 01/05/2023
-- @CodexLink    | https://github.com/CodexLink

return {
        "sindrets/diffview.nvim",
	lazy = true,
        dependencies = {
		"nvim-lua/plenary.nvim"
	}
    }
