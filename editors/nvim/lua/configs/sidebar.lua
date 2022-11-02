-- sidebar.lua | Plugin configuration for `sidebar-nvim/sidebar.nvim`
-- Version 0.1.0  | Since 11/02/2022
-- @CodexLink     | https://github.com/CodexLink
-- References: https://github.com/sidebar-nvim/sidebar.nvim/blob/main/doc/general.md#options

local instantiated, sb_configurator = pcall(require, "sidebar-nvim")
if not instantiated then
	print("Plugin configuration for `sidebar-nvim/sidebar.nvim` has failed to load. The module itself may not be installed properly.")
end

sb_configurator.setup {
	bindings = { ["<CR-B>"] = function() sb_configurator.close() end },
	side = "right",
	initial_width = 25,
	hide_statusline = false,
	update_interval = 500,
	-- TODO: Add dap-sidebar-nvim.breakpoints
	-- References: https://github.com/sidebar-nvim/sections-dap
}
