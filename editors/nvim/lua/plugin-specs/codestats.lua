-- codestats.nvim	 | Plugin spec for the 'codestats', used for the package manager lazy.nvim"
-- Version 0.1.0 | Since 01/05/2023
-- @CodexLink    | https://github.com/CodexLink

-- Info:
-- [1] This uses the forked version which fixes the languages.lua missing comma.
-- [2] NOTE: This plugin requires `CODESTATS_API_KEY` from your Environment Variables!

return {
	"NTBBloodbath/codestats.nvim",
	lazy = true,
	pin = true
}
