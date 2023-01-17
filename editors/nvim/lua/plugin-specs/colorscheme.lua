-- colorsheme.lua	 | Plugin spec for the 'kanagawa' (rebelot/kanagawa.nvim), used for the package manager lazy.nvim"
-- @CodexLink    | https://github.com/CodexLink

-- Info
-- [1] Higher priority is required for the colorscheme, as stated by the author of the package manager.

return {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        -- Load the theme.
        vim.cmd([[colorscheme kanagawa]])
    end,
			opts = {
				undercurl = true,
				commentStyle = { italic = true },
				functionStyle = { bold = true },
				keywordStyle = { italic = true },
				statementStyle = { bold = true },
				typeStyle = {},
				variablebuiltinStyle = { italic = true },
				specialReturn = true,
				specialException = true,
				transparent = false,
				dimInactive = true,
				globalStatus = true,
				terminalColors = true,
				colors = {},
				overrides = {},
				theme = "default"
		}
}
