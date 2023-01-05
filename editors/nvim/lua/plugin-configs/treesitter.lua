-- treesitter.lua | Plugin configuration for `nvim-treesitter/nvim-treesitter`
-- Version 0.1.0  | Since 11/01/2022
-- @CodexLink     | https://github.com/CodexLink

local instantiated, ts_configurator = pcall(require, "nvim-treesitter.configs")
if not instantiated then
	print("Plugin configuration for `nvim-treesitter/nvim-treesitter` has failed to load. The module itself may not be installed properly.")
end

