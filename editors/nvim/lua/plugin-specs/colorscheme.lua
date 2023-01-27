-- colorsheme.lua	 | Plugin spec for the 'kanagawa' (rebelot/kanagawa.nvim), used for the package manager lazy.nvim"
-- @CodexLink    | https://github.com/CodexLink

-- Info
-- [1] Higher priority is required for the colorscheme, as stated by the author of the package manager.

return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function(_, opts)
		require("kanagawa").setup(opts)
		vim.cmd([[ colorscheme kanagawa ]])
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
			BufferLineBufferSelected = { bg = "#DCA561", bold = true, fg = "#1F1F28" },
			BufferLineDevIconDefaultSelected = { bg = "#DCA561", fg = "#1F1F28" },
			BufferLineDevIconGitCommitSelected = { bg = "#DCA561", fg = "#1F1F28" },
			BufferLineDevIconLogSelected = { bg = "#DCA561", fg = "#1F1F28" },
			BufferLineDevIconLuaSelected = { bg = "#DCA561", fg = "#1F1F28" },
			BufferLineDevIconPythonSelected = { bg = "#DCA561", fg = "#1F1F28" },

			BufferLineErrorVisible = { bold = true, fg = "#FF5252", italic = false },
			BufferLineErrorSelected = { bg = "#DCA561", bold = true, fg = "#D50000", italic = false },
			BufferLineHintVisible = { bold = true, fg = "#E7B9FF", italic = false },
			BufferLineHintSelected = { bg = "#DCA561", bold = true, fg = "#6200EA", italic = false },
			BufferLineInfoVisible = { bold = true, fg = "#00E5FF", italic = false },
			BufferLineInfoSelected = { bg = "#DCA561", bold = true, fg = "#00B8D4", italic = false },
			BufferLineWarningVisible = { bold = true, fg = "#FF6E40", italic = false },
			BufferLineWarningSelected = { bg = "#DCA561", bold = true, fg = "#DD2C00", italic = false },

			BufferLineIndicatorSelected = { bg = "#DCA561", fg = "#FFFFFF" },
			BufferLineModifiedSelected = { bg = "#DCA561", fg = "#1F1F28" },
			BufferLinePickSelected = { bg = "#DCA561", fg = "#D50000" },

			CmpItemAbbrDeprecated = { bg = "NONE", fg = "#7E8294", strikethrough = true },
			CmpItemAbbrMatch = { bg = "NONE", bold = true, fg = "#82AAFF" },
			CmpItemAbbrMatchFuzzy = { bg = "NONE", bold = true, fg = "#82AAFF" },
			CmpItemMenu = { bg = "NONE", fg = "#C792EA", italic = true },

			CmpItemKindField = { bg = "#B5585F", fg = "#EED8DA" },
			CmpItemKindProperty = { bg = "#B5585F", fg = "#EED8DA" },
			CmpItemKindEvent = { bg = "#B5585F", fg = "#EED8DA" },

			CmpItemKindText = { bg = "#9FBD73", fg = "#C3E88D" },
			CmpItemKindEnum = { bg = "#9FBD73", fg = "#C3E88D" },
			CmpItemKindKeyword = { bg = "#9FBD73", fg = "#C3E88D" },

			CmpItemKindConstant = { bg = "#D4BB6C", fg = "#FFE082" },
			CmpItemKindConstructor = { bg = "#D4BB6C", fg = "#FFE082" },
			CmpItemKindReference = { bg = "#D4BB6C", fg = "#FFE082" },

			CmpItemKindFunction = { bg = "#A377BF", fg = "#EADFF0" },
			CmpItemKindStruct = { bg = "#A377BF", fg = "#EADFF0" },
			CmpItemKindClass = { bg = "#A377BF", fg = "#EADFF0" },
			CmpItemKindModule = { bg = "#A377BF", fg = "#EADFF0" },
			CmpItemKindOperator = { bg = "#A377BF", fg = "#EADFF0" },

			CmpItemKindVariable = { bg = "#7E8294", fg = "#C5CDD9" },
			CmpItemKindFile = { bg = "#7E8294", fg = "#C5CDD9" },

			CmpItemKindUnit = { bg = "#D4A959", fg = "#F5EBD9" },
			CmpItemKindSnippet = { bg = "#D4A959", fg = "#F5EBD9" },
			CmpItemKindFolder = { bg = "#D4A959", fg = "#F5EBD9" },

			CmpItemKindMethod = { bg = "#6C8ED4", fg = "#DDE5F5" },
			CmpItemKindValue = { bg = "#6C8ED4", fg = "#DDE5F5" },
			CmpItemKindEnumMember = { bg = "#6C8ED4", fg = "#DDE5F5" },

			CmpItemKindInterface = { bg = "#58B5A8", fg = "#D8EEEB" },
			CmpItemKindColor = { bg = "#58B5A8", fg = "#D8EEEB" },
			CmpItemKindTypeParameter = { bg = "#58B5A8", fg = "#D8EEEB" },

			IlluminatedWordRead = { bg = "#FFD740", bold = true, fg = "#424242", underline = false },
			IlluminatedWordText = { bg = "#FFFF8D", bold = true, fg = "#424242", underline = false },
			IlluminatedWordWrite = { bg = "#FFB2FF", bold = true, fg = "#424242", underline = false },

			Pmenu = { bg = "#000000", fg = "#FFFFFF" },
			PmenuSel = { bg = "#282C34", fg = "#1F1F28" },
		},
	},
}
