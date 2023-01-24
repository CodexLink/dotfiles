-- colorsheme.lua	 | Plugin spec for the 'kanagawa' (rebelot/kanagawa.nvim), used for the package manager lazy.nvim"
-- @CodexLink    | https://github.com/CodexLink

-- Info
-- [1] Higher priority is required for the colorscheme, as stated by the author of the package manager.

return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function(_, opts)
			vim.cmd([[ colorscheme kanagawa ]])

			-- For some reason, applying the following in the colorscheme of the following doesn't work unless re-declared or re-instantiated with nvim-api.
			vim.api.nvim_set_hl(0, "IlluminatedWordRead", opts.overrides.IlluminatedWordRead)
			vim.api.nvim_set_hl(0, "IlluminatedWordText", opts.overrides.IlluminatedWordText)
			vim.api.nvim_set_hl(0, "IlluminatedWordWrite", opts.overrides.IlluminatedWordWrite)
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
		overrides = {
			CmpItemAbbrDeprecated = { fg = "#7E8294", bg = "NONE", fmt = "strikethrough" },
			CmpItemAbbrMatch = { fg = "#82AAFF", bg = "NONE", fmt = "bold" },
			CmpItemAbbrMatchFuzzy = { fg = "#82AAFF", bg = "NONE", fmt = "bold" },
			CmpItemMenu = { fg = "#C792EA", bg = "NONE", fmt = "italic" },

			CmpItemKindField = { fg = "#EED8DA", bg = "#B5585F" },
			CmpItemKindProperty = { fg = "#EED8DA", bg = "#B5585F" },
			CmpItemKindEvent = { fg = "#EED8DA", bg = "#B5585F" },

			CmpItemKindText = { fg = "#C3E88D", bg = "#9FBD73" },
			CmpItemKindEnum = { fg = "#C3E88D", bg = "#9FBD73" },
			CmpItemKindKeyword = { fg = "#C3E88D", bg = "#9FBD73" },

			CmpItemKindConstant = { fg = "#FFE082", bg = "#D4BB6C" },
			CmpItemKindConstructor = { fg = "#FFE082", bg = "#D4BB6C" },
			CmpItemKindReference = { fg = "#FFE082", bg = "#D4BB6C" },

			CmpItemKindFunction = { fg = "#EADFF0", bg = "#A377BF" },
			CmpItemKindStruct = { fg = "#EADFF0", bg = "#A377BF" },
			CmpItemKindClass = { fg = "#EADFF0", bg = "#A377BF" },
			CmpItemKindModule = { fg = "#EADFF0", bg = "#A377BF" },
			CmpItemKindOperator = { fg = "#EADFF0", bg = "#A377BF" },

			CmpItemKindVariable = { fg = "#C5CDD9", bg = "#7E8294" },
			CmpItemKindFile = { fg = "#C5CDD9", bg = "#7E8294" },

			CmpItemKindUnit = { fg = "#F5EBD9", bg = "#D4A959" },
			CmpItemKindSnippet = { fg = "#F5EBD9", bg = "#D4A959" },
			CmpItemKindFolder = { fg = "#F5EBD9", bg = "#D4A959" },

			CmpItemKindMethod = { fg = "#DDE5F5", bg = "#6C8ED4" },
			CmpItemKindValue = { fg = "#DDE5F5", bg = "#6C8ED4" },
			CmpItemKindEnumMember = { fg = "#DDE5F5", bg = "#6C8ED4" },

			CmpItemKindInterface = { fg = "#D8EEEB", bg = "#58B5A8" },
			CmpItemKindColor = { fg = "#D8EEEB", bg = "#58B5A8" },
			CmpItemKindTypeParameter = { fg = "#D8EEEB", bg = "#58B5A8" },

			IlluminatedWordRead = { bg = "#FFD740", bold = true, fg = "#424242", underline = false },
			IlluminatedWordText = { bg = "#FFFF8D", bold = true, fg = "#424242", underline = false },
			IlluminatedWordWrite = { bg = "#FFB2FF", bold = true, fg = "#424242", underline = false },

			Pmenu = { bg = "#000000", fg = "#FFFFFF" },
			PmenuSel = { bg = "#282C34", fg = "NONE" },
		},
	}
}
