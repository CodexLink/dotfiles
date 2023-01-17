-- mappings.lua  | Literally anything mapping, but with `which-key.nvim`.
-- @CodexLink    | https://github.com/CodexLink

-- Info
-- * I cannot do keybinds for LSP as they are required to be fed from the setup function argument `on_attach` on every LSP installed.
-- [1] Some keybinds require using string instead of encapsulated [[]] context. This may be due to special handling after executing the function.

local wk = require("which-key")

wk.register({
		["<F1>"] = { [[ <CMD>Neotree action=focus position=left reveal=true toggle=true<CR> ]], "neotree.nvim: Toggle" },
		["<F2>"] = { [[ <CMD>TroubleToggle<CR> ]], "trouble.nvim (Diagnostics): Toggle" },
		["<F3>"] = "TODO: DAP",
		["<F4>"] = { [[ <CMD>WhichKey<CR> ]], "which-key.nvim: Opens UI window for hinting keybinds" },
		["<F5>"] = { [[ <CMD>Lazy<CR> ]], "lazy.nvim: Opens UI window" },
		["<F6>"] = { [[ <CMD>Mason<CR> ]], "mason.nvim: Opens UI window" },
		["<Leader>"] = {
			a = { [[ <CMD>Neogen<CR> ]], "neogen: Annotate code context" },
			c = { [[ <CMD>TSContextToggle<CR> ]], "treesitter-context: Toggle" },
			G = {
				name = "gitsigns.nvim",
				b = { [[ <CMD>Gitsigns toggle_current_line_blame<CR> ]], "Toggle line blame" },
				d = { [[ <CMD>Gitsigns diffthis<CR> ]], "'diffthis' on current line" },
				D = { function() require("gitsigns").diffthis("~") end, "`diffthis` on whole file" },
				h = { [[ <CMD>Gitsigns preview_hunk<CR> ]], "Preview hunk (changes on certain code line)" },
			},
			i = { ":IncRename ", "inc-rename.nvim: Rename on cursor" },
			I = { function() return ":IncRename " .. vim.fn.expand("<CWORD>") end, "inc-rename.nvim: Rename by type", expr = true },
			m = { [[ <CMD>MarkdownPreviewToggle<CR> ]], "markdown-preview.nvim: Toogle" },
			s = { function () require("ssr").open() end, mode={ "n", "x" }, "ssr.nvim: Do 'Structural Search and Replace'" },
			t = { function() require("tsht").nodes() end, "nvim-treehopper: Toggle context to hoppable" },
			w = {
				name = "windows.nvim",
				["="] = { [[ <CMD>WindowsEqualize<CR> ]], "Equalize" },
				["+"] = { [[ <CMD>WindowsMaximize<CR> ]], "Maximize" },
				["-"] = { [[ <CMD>WindowsMaximizeVertically<CR> ]], "Maximize vertically" },
				["_"] = { [[ <CMD>WindowsMaximizeHorizontally<CR> ]], "Maximize horizontally" },
			}
		},
		["M->"] = { [[ <CMD>BufferLineCyclePrev<CR> ]], "bufferline: Move to Previous Buffer." },
		["M-<"] = { [[ <CMD>BufferLineCycleNext<CR> ]], "bufferline: Move to Next Buffer." },
		["M-W"] = { "<CMD>BufferLinePickClose<CR>", "bufferline: Pick a buffer to close." }, 	-- [1]
		["M-Q"] = { "<CMD>BufferLinePick<CR>", "bufferline: Pick a buffer to display." },			-- [1]
		["M-z"] = { [[ <CMD>TSJToggle<CR> ]], "treesj: Toggle 'One-Liner/Splitted' Style." },
		["<S-Left>"] = { [[ <CMD>BufferLineMovePrev<CR> ]], "bufferline: Move Buffer to the Left." },
		["<S-Right>"] = { [[ <CMD>BufferLineMoveNext<CR> ]], "bufferline: Move Buffer to the Right." }
	})
