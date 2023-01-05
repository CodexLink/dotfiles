-- prescene.nvim	 | Plugin spec for the 'prescene', used for the package manager lazy.nvim"
-- Version 0.1.0 | Since 01/05/2023
-- @CodexLink    | https://github.com/CodexLink

-- Info
-- [1] This plugin spec contains the event 'VeryLazy' as this plugin in particular hinders or caps the peformance of my nvim.

return {
	"andweeb/presence.nvim",
	lazy = true,
        event = "VeryLazy"
}
