-- mappings.lua  | Literally anything mapping, but with `which-key.nvim`.
-- @CodexLink    | https://github.com/CodexLink

-- Info
-- * I cannot do keybinds for LSP as they are required to be fed from the setup function argument `on_attach` on every LSP installed.
-- [1] Some keybinds require using string instead of encapsulated [[]] context. This may be due to special handling after executing the function.

local wk = require("which-key")

wk.register({
		["<F1>"] = { [[ <CMD>Telescope builtin<CR> ]], "telesocpe.nvim: Toggle 'builtin'" },
		["<M-F1>"] = { [[ <CMD>Telescope file_browser<CR> ]], "telescope.nvim: Toggle 'file browser'" },
		["<F2>"] = { [[ <CMD>TroubleToggle<CR> ]], "trouble.nvim (Diagnostics): Toggle" },
		["<M-F2>"] = { [[ <CMD>Telescope diagnostics<CR> ]], "telescope.nvim: Toggle 'diagnostics'" },
		["<F3>"] = { [[ <CMD>AerialToggle!<CR> ]], "symbols-outline.nvim: Toggle (Unfocused)" },
		["<S-F3>"] = { [[ <CMD>AerialToggle<CR> ]], "symbols-outline.nvim: Toggle (Focused)" },
		["<M-F3>"] = { [[ <CMD>Telescope aerial<CR> ]], "telescope.nvim: Toggle 'aerial'" },
		["<F4>"] = { function() print end, "DAP"},
		["<F5>"] = { [[ <CMD>Lazy<CR> ]], "lazy.nvim: Opens UI window" },
		["<F6>"] = { [[ <CMD>WhichKey<CR> ]], "which-key.nvim: Opens UI window for hinting keybinds" },
		["<F7>"] = { [[ <CMD>Mason<CR> ]], "mason.nvim: Opens UI window" },
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
			L = { [[ <CMD>LazyGit<CR> ]], "lazygit.nvim: Toggle window", silent = true },
			m = { [[ <CMD>MarkdownPreviewToggle<CR> ]], "markdown-preview.nvim: Toogle" },
			r = { function () require("ssr").open() end, mode={ "n", "x" }, "ssr.nvim: Do 'Structural Search and Replace'" },
			t = { function() require("tsht").nodes() end, "nvim-treehopper: Toggle context to hoppable" },
			w = {
				name = "windows.nvim",
				["="] = { [[ <CMD>WindowsEqualize<CR> ]], "Equalize" },
				["+"] = { [[ <CMD>WindowsMaximize<CR> ]], "Maximize" },
				["-"] = { [[ <CMD>WindowsMaximizeVertically<CR> ]], "Maximize vertically" },
				["_"] = { [[ <CMD>WindowsMaximizeHorizontally<CR> ]], "Maximize horizontally" },
			}
		},
		["<M->>"] = { [[ <CMD>BufferLineCyclePrev<CR> ]], "bufferline: Move to Previous Buffer." },
		["<M-<>"] = { [[ <CMD>BufferLineCycleNext<CR> ]], "bufferline: Move to Next Buffer." },
		["<M-q>"] = { "<CMD>BufferLinePickClose<CR>", "bufferline: Pick a buffer to close." }, 	-- [1]
		["<M-w>"] = { "<CMD>BufferLinePick<CR>", "bufferline: Pick a buffer to display." },			-- [1]
		["<M-e>"] = { [[ <CMD>TSJToggle<CR> ]], "treesj: Toggle 'One-Liner/Splitted' Style." },
		["<S-Left>"] = { [[ <CMD>BufferLineMovePrev<CR> ]], "bufferline: Move Buffer to the Left." },
		["<S-Right>"] = { [[ <CMD>BufferLineMoveNext<CR> ]], "bufferline: Move Buffer to the Right." }
	})
