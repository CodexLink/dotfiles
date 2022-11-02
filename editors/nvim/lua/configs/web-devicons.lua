-- web-devicons.lua | Plugin configuration for `nvim-tree/nvim-web-devicons`
-- Version 0.1.0  | Since 11/01/2022
-- @CodexLink     | https://github.com/CodexLink

local instantiated, wdi_configurator = pcall(require, "nvim-web-devicons")
if not instantiated then
	print("Plugin configuration for `nvim-tree/nvim-web-devicons` has failed to load. The module itself may not be installed properly.")
end

wdi_configurator.setup {
	color_icons = true,
	default = true
}
