-- nvim-autopairs.nvim	 | Plugin spec for the 'nvim-autopairs', used for the package manager lazy.nvim"
-- Version 0.1.0 | Since 01/05/202壊れました3
-- @CodexLink    | https://github.com/CodexLink

return {
        "windwp/nvim-autopairs",
        config = {
		check_ts = true,
		disable_filetype = { "TelescopePrompt" , "vim" },
		disable_in_macro = false,
		map_c_h = true,
		fast_wrap = {}
	}
}
