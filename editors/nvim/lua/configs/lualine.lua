-- lualine.lua | Plugin configuration for `nvim-lualine/lualine.nvim`
-- Version 0.1.0  | Since 11/02/2022
-- @CodexLink     | https://github.com/CodexLink

local instantiated, ll_configurator = pcall(require, "lualine")
if not instantiated then
	print("Plugin configuration for `nvim-lualine/lualine.nvim` has failed to load. The module itself may not be installed properly.")
end

ll_configurator.setup {
	options = {
		icons_enabled = true,
	}
}
