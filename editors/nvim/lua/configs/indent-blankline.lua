-- indent-blankline.lua | Plugin configuration for `lukas-reineke/indent-blankline.nvim`
-- Version 0.1.0  | Since 11/02/2022
-- @CodexLink     | https://github.com/CodexLink

local instantiated, ib_configurator = pcall(require, "indent_blankline")
if not instantiated then
	error("Plugin configuration for `lukas-reineke/indent-blankline.nvim` has failed to load. The module itself may not be installed properly.")
end

ib_configurator.setup {
	show_current_context = true,
	show_current_context_start = true,
	show_end_of_line = true
}
