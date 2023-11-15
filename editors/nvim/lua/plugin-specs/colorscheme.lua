---@module 'colorscheme'
---@author CodexLink <https://github.com/CodexLink>
---@license Apache-2.0
---@info [1] Higher priority is required for the colorscheme, as stated by the author of the package manager.

return {
        "ellisonleao/gruvbox.nvim", -- theme
        priority = 1000,
        lazy = false,
        config = function()
            require("gruvbox").setup({
                contrast = "hard",
                palette_overrides = {dark0_hard = "#0E1018"},
                overrides = {
                    -- Comment = {fg = "#626A73", italic = true, bold = true},
                    -- #736B62,  #626273, #627273 
                    Comment = {fg = "#81878f", italic = true, bold = true},
                    Define = {link = "GruvboxPurple"},
                    Macro = {link = "GruvboxPurple"},
                    ["@constant.builtin"] = {link = "GruvboxPurple"},
                    ["@storageclass.lifetime"] = {link = "GruvboxAqua"},
                    ["@text.note"] = {link = "TODO"},
                    ["@namespace.latex"] = {link = "Include"},
                    ["@namespace.rust"] = {link = "Include"},
                    ContextVt = {fg = "#878788"},
                    CopilotSuggestion = {fg = "#878787"},
                    CocCodeLens = {fg = "#878787"},
                    CocWarningFloat = {fg = "#dfaf87"},
                    CocInlayHint = {fg = "#ABB0B6"},
                    CocPumShortcut = {fg = "#fe8019"},
                    CocPumDetail = {fg = "#fe8019"},
                    DiagnosticVirtualTextWarn = {fg = "#dfaf87"},
                    -- fold
                    Folded = {fg = "#fe8019", bg = "#3c3836", italic = true},
                    FoldColumn = {fg = "#fe8019", bg = "#0E1018"},
                    SignColumn = {bg = "#fe8019"},
                    -- new git colors
                    DiffAdd = { bold = true, reverse = false, fg = "", bg = "#2a4333"},
                    DiffChange = { bold = true, reverse = false, fg = "", bg = "#333841" },
                    DiffDelete = { bold = true, reverse = false, fg = "#442d30", bg = "#442d30" },
                    DiffText = { bold = true, reverse = false, fg = "", bg = "#213352" },
                    -- statusline
                    StatusLine = {bg = "#ffffff", fg = "#0E1018"},
                    StatusLineNC = {bg = "#3c3836", fg = "#0E1018"},
                    CursorLineNr = {fg = "#fabd2f", bg = ""},
                    GruvboxOrangeSign = {fg = "#dfaf87", bg = ""},
                    GruvboxAquaSign = {fg = "#8EC07C", bg = ""},
                    GruvboxGreenSign = {fg = "#b8bb26", bg = ""},
                    GruvboxRedSign = {fg = "#fb4934", bg = ""},
                    GruvboxBlueSign = {fg = "#83a598", bg = ""},
                    WilderMenu = {fg = "#ebdbb2", bg = ""},
                    WilderAccent = {fg = "#f4468f", bg = ""},
                    -- coc semantic token
                    CocSemStruct = {link = "GruvboxYellow"},
                    CocSemKeyword = {fg = "", bg = "#0E1018"},
                    CocSemEnumMember = {fg = "", bg = "#0E1018"},
                    CocSemTypeParameter = {fg = "", bg = "#0E1018"},
                    CocSemComment = {fg = "", bg = "#0E1018"},
                    CocSemMacro = {fg = "", bg = "#0E1018"},
                    CocSemVariable = {fg = "", bg = "#0E1018"},
                    -- CocSemFunction = {link = "GruvboxGreen"},
                    -- neorg
                    ["@neorg.markup.inline_macro"] = {link = "GruvboxGreen"}
                }
            })
      vim.cmd.colorscheme("gruvbox")
  end
  -- "rebelot/kanagawa.nvim",
  -- lazy = false,
  -- priority = 1000,
  -- config = function()
  --   require("kanagawa").setup({
  --     undercurl = true,
  --     commentStyle = { italic = true },
  --     functionStyle = { bold = true },
  --     keywordStyle = { italic = true },
  --     statementStyle = { bold = true },
  --     typeStyle = {},
  --     variablebuiltinStyle = { italic = true },
  --     specialReturn = true,
  --     specialException = true,
  --     transparent = false,
  --     dimInactive = true,
  --     globalStatus = true,
  --     terminalColors = true,
  --     theme = "dragon",
  --     overrides = function(colors)
  --       return {
  --         CmpItemAbbrDeprecated = { bg = "NONE", fg = colors.palette.waveRed, strikethrough = true },
  --         CmpItemAbbrMatch = { bg = "NONE", bold = true, fg = colors.palette.waveRed },
  --         CmpItemAbbrMatchFuzzy = { bg = "NONE", bold = true, fg = colors.palette.waveRed },
  --         CmpItemMenu = { bg = "NONE", fg = colors.palette.carpYellow, bold = true },
  --         CmpItemKindField = { bg = colors.palette.sakuraPink, fg = colors.palette.sumiInk1 },
  --         CmpItemKindProperty = { bg = colors.palette.sakuraPink, fg = colors.palette.sumiInk1 },
  --         CmpItemKindEvent = { bg = colors.palette.sakuraPink, fg = colors.palette.sumiInk1 },
  --         CmpItemKindText = { bg = colors.palette.springGreen, fg = colors.palette.sumiInk1 },
  --         CmpItemKindEnum = { bg = colors.palette.springGreen, fg = colors.palette.sumiInk1 },
  --         CmpItemKindKeyword = { bg = colors.palette.springGreen, fg = colors.palette.sumiInk1 },
  --         CmpItemKindConstant = { bg = colors.palette.carpYellow, fg = colors.palette.sumiInk1 },
  --         CmpItemKindConstructor = { bg = colors.palette.carpYellow, fg = colors.palette.sumiInk1 },
  --         CmpItemKindReference = { bg = colors.palette.carpYellow, fg = colors.palette.sumiInk1 },
  --         CmpItemKindFunction = { bg = colors.palette.surimiOrange, fg = colors.palette.sumiInk1 },
  --         CmpItemKindStruct = { bg = colors.palette.surimiOrange, fg = colors.palette.sumiInk1 },
  --         CmpItemKindClass = { bg = colors.palette.surimiOrange, fg = colors.palette.sumiInk1 },
  --         CmpItemKindModule = { bg = colors.palette.surimiOrange, fg = colors.palette.sumiInk1 },
  --         CmpItemKindOperator = { bg = colors.palette.surimiOrange, fg = colors.palette.sumiInk1 },
  --         CmpItemKindVariable = { bg = colors.palette.waveRed, fg = colors.palette.sumiInk1 },
  --         CmpItemKindFile = { bg = colors.palette.waveRed, fg = colors.palette.sumiInk1 },
  --         CmpItemKindUnit = { bg = colors.palette.autumnRed, fg = colors.palette.sumiInk1 },
  --         CmpItemKindSnippet = { bg = colors.palette.autumnRed, fg = colors.palette.sumiInk1 },
  --         CmpItemKindFolder = { bg = colors.palette.autumnRed, fg = colors.palette.sumiInk1 },
  --         CmpItemKindMethod = { bg = colors.palette.roninYellow, fg = colors.palette.sumiInk1 },
  --         CmpItemKindValue = { bg = colors.palette.roninYellow, fg = colors.palette.sumiInk1 },
  --         CmpItemKindEnumMember = { bg = colors.palette.roninYellow, fg = colors.palette.sumiInk1 },
  --         CmpItemKindInterface = { bg = colors.palette.fujiWhite, fg = colors.palette.sumiInk1 },
  --         CmpItemKindColor = { bg = colors.palette.fujiWhite, fg = colors.palette.sumiInk1 },
  --         CmpItemKindTypeParameter = { bg = colors.palette.fujiWhite, fg = colors.palette.sumiInk1 },
  --         CursorToNavigation = { fg = "NONE", bg = colors.palette.roninYellow },
  --         CursorToInsertion = { fg = "NONE", bg = colors.palette.surimiOrange },
  --         CursorToReplacement = { fg = colors.palette.autumnYellow, bg = colors.palette.samuraiRed },
  --         -- NOTE: This highlight may work based on your terminal, currently this does not work in my case.
  --         Cursor = { bg = colors.palette.surimiOrange, fg = colors.palette.surimiOrange },
  --         TermCursor = { bg = colors.palette.surimiOrange, fg = colors.palette.surimiOrange },
  --         HighlightedYank = { bg = colors.palette.roninYellow, fg = colors.palette.sumiInk1 },
  --         IlluminatedWordRead = { bg = colors.palette.carpYellow, bold = true, fg = colors.palette.sumiInk1 },
  --         IlluminatedWordText = { bg = colors.palette.oldWhite, fg = colors.palette.sumiInk1, underline = false },
  --         IlluminatedWordWrite = { bg = colors.palette.sakuraPink, bold = true, fg = colors.palette.sumiInk1 },
  --         Visual = { bg = colors.palette.waveRed, fg = colors.palette.sumiInk1 },
  --         Pmenu = { bg = colors.palette.sumiInk2, fg = colors.palette.sakuraPink },
  --         PmenuSel = { bg = colors.palette.carpYellow, fg = colors.palette.sumiInk1 },
  --       }
  --     end
  --   })
  --
  --   require("kanagawa").load()
  -- end
}
