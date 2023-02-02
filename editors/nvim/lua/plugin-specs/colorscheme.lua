-- colorsheme.lua	 | Plugin spec for the 'kanagawa' (rebelot/kanagawa.nvim), used for the package manager lazy.nvim"
-- @CodexLink    | https://github.com/CodexLink

-- Info
-- [1] Higher priority is required for the colorscheme, as stated by the author of the package manager.

return {
	"rebelot/kanagawa.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local kanagawa_colors = require("kanagawa.colors").setup()

		require("kanagawa").setup({
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
				BufferLineBufferSelected = { bg = kanagawa_colors.autumnYellow, bold = true, fg = kanagawa_colors.sumiInk1 },
				BufferLineDevIconDefaultSelected = { bg = kanagawa_colors.autumnYellow, fg = kanagawa_colors.sumiInk1 },
				BufferLineDevIconGitCommitSelected = { bg = kanagawa_colors.autumnYellow, fg = kanagawa_colors.sumiInk1 },
				BufferLineDevIconGitIgnoreSelected = { bg = kanagawa_colors.autumnYellow, fg = kanagawa_colors.sumiInk1 },
				BufferLineDevIconJsSelected = { bg = kanagawa_colors.autumnYellow, fg = kanagawa_colors.sumiInk1 },
				BufferLineDevIconJsonSelected = { bg = kanagawa_colors.autumnYellow, fg = kanagawa_colors.sumiInk1 },
				BufferLineDevIconLogSelected = { bg = kanagawa_colors.autumnYellow, fg = kanagawa_colors.sumiInk1 },
				BufferLineDevIconLuaSelected = { bg = kanagawa_colors.autumnYellow, fg = kanagawa_colors.sumiInk1 },
				BufferLineDevIconPySelected = { bg = kanagawa_colors.autumnYellow, fg = kanagawa_colors.sumiInk1 },
				BufferLineDevIconPsScriptfileSelected = { bg = kanagawa_colors.autumnYellow, fg = kanagawa_colors.sumiInk1 },
				BufferLineDevIconTsSelected = { bg = kanagawa_colors.autumnYellow, fg = kanagawa_colors.sumiInk1 },
				BufferLineDevIconTsxSelected = { bg = kanagawa_colors.autumnYellow, fg = kanagawa_colors.sumiInk1 },
				BufferLineErrorVisible = { bold = true, fg = kanagawa_colors.autumnRed, italic = false },
				BufferLineErrorSelected = { bg = kanagawa_colors.autumnYellow, bold = true, fg = kanagawa_colors.samuraiRed,
					italic = false },
				BufferLineHintVisible = { bold = true, fg = kanagawa_colors.sprintViolet1, italic = false },
				BufferLineHintSelected = { bg = kanagawa_colors.autumnYellow, bold = true, fg = kanagawa_colors.oniViolet,
					italic = false },
				BufferLineInfoVisible = { bold = true, fg = kanagawa_colors.lightBlue, italic = false },
				BufferLineInfoSelected = { bg = kanagawa_colors.autumnYellow, bold = true, fg = kanagawa_colors.springBlue,
					italic = false },
				BufferLineWarningVisible = { bold = true, fg = kanagawa_colors.boatYellow2, italic = false },
				BufferLineWarningSelected = { bg = kanagawa_colors.autumnYellow, bold = true, fg = kanagawa_colors.boatYellow1,
					italic = false },

				BufferLineIndicatorSelected = { bg = kanagawa_colors.autumnYellow, fg = kanagawa_colors.fujiWhite },
				BufferLineModifiedSelected = { bg = kanagawa_colors.autumnYellow, fg = kanagawa_colors.sumiInk1 },
				BufferLinePickSelected = { bg = kanagawa_colors.autumnYellow, fg = kanagawa_colors.samuraiRed },

				CmpItemAbbrDeprecated = { bg = "NONE", fg = kanagawa_colors.waveRed, strikethrough = true },
				CmpItemAbbrMatch = { bg = "NONE", bold = true, fg = kanagawa_colors.waveRed },
				CmpItemAbbrMatchFuzzy = { bg = "NONE", bold = true, fg = kanagawa_colors.waveRed },
				CmpItemMenu = { bg = "NONE", fg = kanagawa_colors.carpYellow, bold = true },

				CmpItemKindField = { bg = kanagawa_colors.sakuraPink, fg = kanagawa_colors.sumiInk1 },
				CmpItemKindProperty = { bg = kanagawa_colors.sakuraPink, fg = kanagawa_colors.sumiInk1 },
				CmpItemKindEvent = { bg = kanagawa_colors.sakuraPink, fg = kanagawa_colors.sumiInk1 },

				CmpItemKindText = { bg = kanagawa_colors.springGreen, fg = kanagawa_colors.sumiInk1 },
				CmpItemKindEnum = { bg = kanagawa_colors.springGreen, fg = kanagawa_colors.sumiInk1 },
				CmpItemKindKeyword = { bg = kanagawa_colors.springGreen, fg = kanagawa_colors.sumiInk1 },

				CmpItemKindConstant = { bg = kanagawa_colors.carpYellow, fg = kanagawa_colors.sumiInk1 },
				CmpItemKindConstructor = { bg = kanagawa_colors.carpYellow, fg = kanagawa_colors.sumiInk1 },
				CmpItemKindReference = { bg = kanagawa_colors.carpYellow, fg = kanagawa_colors.sumiInk1 },

				CmpItemKindFunction = { bg = kanagawa_colors.surimiOrange, fg = kanagawa_colors.sumiInk1 },
				CmpItemKindStruct = { bg = kanagawa_colors.surimiOrange, fg = kanagawa_colors.sumiInk1 },
				CmpItemKindClass = { bg = kanagawa_colors.surimiOrange, fg = kanagawa_colors.sumiInk1 },
				CmpItemKindModule = { bg = kanagawa_colors.surimiOrange, fg = kanagawa_colors.sumiInk1 },
				CmpItemKindOperator = { bg = kanagawa_colors.surimiOrange, fg = kanagawa_colors.sumiInk1 },

				CmpItemKindVariable = { bg = kanagawa_colors.waveRed, fg = kanagawa_colors.sumiInk1 },
				CmpItemKindFile = { bg = kanagawa_colors.waveRed, fg = kanagawa_colors.sumiInk1 },

				CmpItemKindUnit = { bg = kanagawa_colors.autumnRed, fg = kanagawa_colors.sumiInk1 },
				CmpItemKindSnippet = { bg = kanagawa_colors.autumnRed, fg = kanagawa_colors.sumiInk1 },
				CmpItemKindFolder = { bg = kanagawa_colors.autumnRed, fg = kanagawa_colors.sumiInk1 },

				CmpItemKindMethod = { bg = kanagawa_colors.roninYellow, fg = kanagawa_colors.sumiInk1 },
				CmpItemKindValue = { bg = kanagawa_colors.roninYellow, fg = kanagawa_colors.sumiInk1 },
				CmpItemKindEnumMember = { bg = kanagawa_colors.roninYellow, fg = kanagawa_colors.sumiInk1 },

				CmpItemKindInterface = { bg = kanagawa_colors.fujiWhite, fg = kanagawa_colors.sumiInk1 },
				CmpItemKindColor = { bg = kanagawa_colors.fujiWhite, fg = kanagawa_colors.sumiInk1 },
				CmpItemKindTypeParameter = { bg = kanagawa_colors.fujiWhite, fg = kanagawa_colors.sumiInk1 },

				CursorToNavigation = { fg = "NONE", bg = kanagawa_colors.roninYellow },
				CursorToInsertion = { fg = "NONE", bg = kanagawa_colors.surimiOrange },
				CursorToReplacement = { fg = kanagawa_colors.autumnYellow, bg = kanagawa_colors.samuraiRed },

				-- !!! This highlight may work based on your terminal, currently this does not work in my case.
				Cursor = { bg = kanagawa_colors.surimiOrange, fg = kanagawa_colors.surimiOrange },
				TermCursor = { bg = kanagawa_colors.surimiOrange, fg = kanagawa_colors.surimiOrange },

				HighlightedYank = { bg = kanagawa_colors.roninYellow, fg = kanagawa_colors.sumiInk1 },

				IlluminatedWordRead = { bg = kanagawa_colors.carpYellow, bold = true, fg = kanagawa_colors.sumiInk1 },
				IlluminatedWordText = { bg = kanagawa_colors.oldWhite, fg = kanagawa_colors.sumiInk1, underline = false },
				IlluminatedWordWrite = { bg = kanagawa_colors.sakuraPink, bold = true, fg = kanagawa_colors.sumiInk1 },

				Visual = { bg = kanagawa_colors.waveRed, fg = kanagawa_colors.sumiInk1 },

				Pmenu = { bg = kanagawa_colors.sumiInk2, fg = kanagawa_colors.sakuraPink },
				PmenuSel = { bg = kanagawa_colors.carpYellow, fg = kanagawa_colors.sumiInk1 },
			}
		})
		vim.cmd([[ colorscheme kanagawa ]])
	end
}
