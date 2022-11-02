-- autopairs.lua | Plugin configuration for `windwp/nvim-autopairs`
-- Version 0.1.0  | Since 11/01/2022
-- @CodexLink     | https://github.com/CodexLink

local instantiated, ap_configurator = pcall(require, "nvim-autopairs")
if not instantiated then
	print("Plugin configuration for `windwp/nvim-autopairs` has failed to load. The module itself may not be installed properly.")
end

ap_configuration.setup {
	check_ts = true,
	disable_filetype = { "TelescopePrompt" , "vim" },
	disable_in_macro = false,
	map_c_h = true,
	fast_wrap = {}
}
