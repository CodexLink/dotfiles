-- tracker.lua	 | Plugin Spec for all plugins that track my movements and progression with the editor, used for the package manager lazy.nvim"
-- Version 0.1.0 | Since 01/11/2023
-- @CodexLink    | https://github.com/CodexLink

-- Notes
-- [1] ! Requires `CODESTATS_API_KEY` on Environmental Variables.

return {
	{ "wakatime/vim-wakatime", event = "VeryLazy" },
	{ "andweeb/presence.nvim", event = "VeryLazy" },
	{ "NTBBloodbath/codestats.nvim", event = "VeryLazy", pin = true } -- [1]
}
