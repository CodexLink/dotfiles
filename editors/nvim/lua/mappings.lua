-- mappings.lua  | Literally anything mapping, but with `which-key.nvim`.
-- @CodexLink    | https://github.com/CodexLink

-- Info
-- * I cannot do keybinds for LSP as they are required to be fed from the setup function argument `on_attach` on every LSP installed.
-- [1] Some keybinds require using string instead of encapsulated [[]] context. This may be due to special handling after executing the function.

-- [2] APIs for the plugins leveraging `telescope` are most likely not documented in terms of accessing them through APIs, the following is the command used to identify them: 'lua vim.inspect(print(require("telescope.extensions")))`
-- [3] To reduce telescope startup time, require("telescop").load_extension was declared from the keybinds instead before initializing them.
--
local wk = require("which-key")

wk.register({
	["<F1>"] = { function() require("telescope.builtin").builtin() end, "telesocpe.nvim: Toggle 'builtin'" },
	["<M-F1>"] = { function() require("telescope").load_extension("file_browser") require("telescope").extensions.file_browser.file_browser() end,
		"telescope.nvim: Toggle 'file browser'" },
	["<F2>"] = { function() require("trouble").toggle() end, "trouble.nvim (Diagnostics): Toggle" },
	["<M-F2>"] = { function() require("telescope.builtin").diagnostics() end, "telescope.nvim: Toggle 'diagnostics'" },
	["<F3>"] = { function() require("aerial").toggle({ focus = false }) end, "symbols-outline.nvim: Toggle (Unfocused)" },
	["<S-F3>"] = { function() require("aerial").toggle({ focus = true }) end, "symbols-outline.nvim: Toggle (Focused)" },
	["<M-F3>"] = { function() require("telescope").load_extension("aerial") require("telescope").extensions.aerial.aerial() end,
		"telescope.nvim: Toggle 'aerial'" },
	-- ["<F4>"] = { function () print end, "DAP"},
	["<F5>"] = { function() require("lazy").home() end, "lazy.nvim: Opens UI window" },
	["<F6>"] = { function () require("which-key").show() end, "which-key.nvim: Opens UI window for hinting keybinds" },
	["<F7>"] = { function () require("mason.ui").open() end, "mason.nvim: Opens UI window" },
	["<Leader>"] = {
		a = { function() require("neogen").generate() end, "neogen: Annotate code context" },
		G = {
			name = "gitsigns.nvim",
			b = { function() require("gitsigns").toggle_current_line_blame() end, "Toggle line blame" },
			d = { function() require("gitsigns").diffthis() end, "'diffthis' on current line" },
			D = { function() require("gitsigns").diffthis("~") end, "`diffthis` on whole file" },
			h = { function() require("gitsigns").preview_hunk() end, "Preview hunk" },
			H = { function() require("gitsigns").preview_hunk_inline() end, "Preview hunk (Inlined)" },
		},
		i = { ":IncRename ", "inc-rename.nvim: Rename on cursor" },
		I = { function() return ":IncRename " .. vim.fn.expand("<CWORD>") end, "inc-rename.nvim: Rename by type", expr = true },
		l = {
			name = "LSP Actions",
		},
		L = { function() require("telescope").load_extension("lazygit") require("lazygit").lazygit() end, "lazygit.nvim: Toggle window" },
		m = { [[ <CMD>MarkdownPreviewToggle<CR> ]], "markdown-preview.nvim: Toggle" },
		n = { function() require("telescope").extensions.notify.notify() end,
			"nvim-notify: Check notifications via 'Telescope'" },
		r = { function() require("ssr").open() end, mode = { "n", "x" }, "ssr.nvim: Do 'Structural Search and Replace'" },
		t = { function() require("tsht").nodes() end, "nvim-treehopper: Hop to highlight context" },
		T = { function() require("twilight").toggle() end, "twilight.nvim: Toggle code dimming" },
		w = {
			name = "windows.nvim",
			["="] = { function() require("windows.commands").equalize() end, "Equalize" },
			["+"] = { function() require("windows.commands").maximize() end, "Maximize" },
			["-"] = { function() require("windows.commands").maximize_vertically() end, "Maximize vertically" },
			["_"] = { function() require("windows.commands").maximize_horizontally() end, "Maximize horizontally" },
		}
	},
	["M-`"] = { function() vim.cmd([[ set wrap! ]]) end, "builtin: Toggle wrap" },
	["<M-<>"] = { function() require("bufferline").cycle(-1) end, "bufferline: Move to Previous Buffer." },
	["<M->>"] = { function() require("bufferline").cycle(1) end, "bufferline: Move to Next Buffer." },
	["<M-a>"] = { function() require("hop").hint_char1() end, "hop.nvim: Hop 1 char" },
	["<M-A>"] = { function() require("hop").hint_char2() end, "hop.nvim: Hop 2 chars" },
	["<M-c>"] = { function() require("bufferline").close_buffer_with_pick() end, "bufferline: Pick a buffer to close." }, -- [1]
	["<M-d>"] = { function() require("bufferline").close_buffer_with_pickfunction() require("bufferline").pick_buffer() end, "bufferline: Pick a buffer to display." }, -- [1]
	["<M-s>"] = { function() require("hop").hint_anywhere({ direction = require("hop.hint").HintDirection.AFTER_CURSOR }) end,
		"hop.nvim: hop below anywhere" },
	["<M-S>"] = { function() require("hop").hint_anywhere({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR }) end,
		"hop.nvim: hop above anywhere" },
	["<M-v>"] = { function() require("treesj").toggle() end, "treesj: Toggle 'One-Liner/Splitted' Style." },
	["<M-x>"] = { function() require("illuminate").goto_next_reference() end, "vim-illuminate: Jump to next reference" },
	["<M-z>"] = { function() require("illuminate").goto_prev_reference() end, "vim-illuminate: Jump to previous reference" },
	["<M-F>"] = { function() require("utils").LSPCodeFileFormat() end, "utils: Code Format (Async)" },
	["<S-Left>"] = {  function() require("bufferline").move(-1) end, "bufferline: Move Buffer to the Left." },
	["<S-Right>"] = { function() require("bufferline").move(1) end, "bufferline: :Move Buffer to the Right." }
})
