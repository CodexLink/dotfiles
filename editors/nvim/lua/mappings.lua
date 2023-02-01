-- mappings.lua  | Literally anything mapping, but with `which-key.nvim`.
-- @CodexLink    | https://github.com/CodexLink

-- Info
-- * I cannot do keybinds for LSP as they are required to be fed from the setup function argument `on_attach` on every LSP installed.
-- [1] Some keybinds require using string instead of encapsulated [[]] context. This may be due to special handling after executing the function.

-- [2] APIs for the plugins leveraging `telescope` are most likely not documented in terms of accessing them through APIs, the following is the command used to identify them: 'lua vim.inspect(print(require("telescope.extensions")))`
-- [3] To reduce telescope startup time, require("telescop").load_extension was declared from the keybinds instead before initializing them.
--
local wk = require("which-key")
local notifier = require("utils").NotifyAfterExecution

local mapping_default_opts = { animate = true, timeout = 1250, title = "Mapping-to-Execution" }

wk.register({
	["<F1>"] = { function() require("telescope.builtin").builtin() end, "telescope.nvim: Toggle 'builtin'" },
	["<M-F1>"] = { function() require("telescope").load_extension("file_browser")
		require("telescope").extensions.file_browser
				.file_browser()
	end,
		"telescope.nvim: Toggle 'file browser'" },
	["<F2>"] = { function() require("trouble").toggle() end, "trouble.nvim (Diagnostics): Toggle" },
	["<M-F2>"] = { function() require("telescope.builtin").diagnostics() end, "telescope.nvim: Toggle 'diagnostics'" },
	["<F3>"] = { function() require("aerial").toggle({ focus = false }) end, "aerial.nvim: Toggle (Unfocused/" },
	["<S-F3>"] = { function() require("aerial").toggle({ focus = true }) end, "aerial.nvim: Toggle (Focused)" },
	["<M-F3>"] = { function() require("telescope").load_extension("aerial") require("telescope").extensions.aerial.aerial() end,
		"telescope.nvim: Toggle 'aerial'" },
	-- ["<F4>"] = { function () print end, "DAP"},
	["<F5>"] = { function() require("lazy").home() end, "lazy.nvim: Opens UI window" },
	["<F6>"] = { function() require("which-key").show() end, "which-key.nvim: Opens UI window for hinting keybinds" },
	["<F7>"] = { function() require("mason.ui").open() end, "mason.nvim: Opens UI window" },
	["<Leader>"] = {
		a = { function() notifier({ cmd = function() require("neogen").generate() end,
				message = "neogen: Code annotation added!", opts = mapping_default_opts })
		end, "neogen: Annotate code context" },
		G = {
			name = "gitsigns.nvim",
			b = { function() notifier({ cmd = function() require("gitsigns").toggle_current_line_blame() end,
					message = "gitsigns: Line blame toggled.", opts = mapping_default_opts })
			end, "Toggle line blame" },
			d = { function() notifier({ cmd = function() require("gitsigns").diffthis() end,
					message = "gitsigns: Diff view (at current line) activated.", opts = mapping_default_opts })
			end,
				"'diffthis' on current line" },
			D = { function() notifier({ cmd = function() require("gitsigns").diffthis("~") end,
					message = "gitsigns: Diff view (at whole file) activated.", opts = mapping_default_opts })
			end,
				"`diffthis` on whole file" },
			h = { function() notifier({ cmd = function() require("gitsigns").preview_hunk() end,
					message = "gitsigns: Hunk on current line preview, activated", opts = mapping_default_opts })
			end, "Preview hunk" },
			H = { function() notifier({ cmd = function() require("gitsigns").preview_hunk_inline() end,
					message = "gitsigns: Hunk on current line inline-preview, activated", opts = mapping_default_opts })
			end,
				"Preview hunk (Inlined)" },
		},
		i = { ":IncRename ", "inc-rename.nvim: Rename on cursor" },
		I = { function() return ":IncRename " .. vim.fn.expand("<CWORD>") end, "inc-rename.nvim: Rename by type", expr = true },
		l = {
			name = "LSP Actions",
		},
		L = { function() require("telescope").load_extension("lazygit") require("lazygit").lazygit() end,
			"lazygit.nvim: Toggle window" },
		m = { [[ <CMD>MarkdownPreviewToggle<CR> ]], "markdown-preview.nvim: Toggle" },
		n = { function() require("telescope").extensions.notify.notify() end,
			"nvim-notify: Check notifications via 'Telescope'" },
		r = { function() require("ssr").open() end, mode = { "n", "x" }, "ssr.nvim: Do 'Structural Search and Replace'" },
		t = { function() require("tsht").nodes() end, "nvim-treehopper: Hop to highlight context" },
		T = { function() notifier({ cmd = function() require("twilight").toggle() end,
				message = "twilight: Code dimming toggled.", opts = mapping_default_opts })
		end, "twilight.nvim: Toggle code dimming" },
		w = {
			name = "windows.nvim",
			["="] = { function() notifier({ cmd = function() require("windows.commands").equalize() end,
					message = "All windows were equalized.", opts = mapping_default_opts })
			end, "Equalize" },
			["+"] = { function() notifier({ cmd = function() require("windows.commands").maximize() end,
					message = "Current window set to maximized.", opts = mapping_default_opts })
			end, "Maximize" },
			["-"] = { function() notifier({ cmd = function() require("windows.commands").maximize_vertically() end,
					message = "Current window set to maximize vertically.", opts = mapping_default_opts })
			end, "Maximize vertically" },
			["_"] = { function() notifier({ cmd = function() require("windows.commands").maximize_horizontally() end,
					message = "Current window set to maximize horizontally", opts = mapping_default_opts })
			end, "Maximize horizontally" },
		}
	},
	["<M-~>"] = { function() notifier({ cmd = function() vim.cmd([[ set wrap! ]]) end, message = "Code wrapping toggled.", opts = mapping_default_opts }) end, "builtin: Toggle wrap" },
	["<M-<>"] = { function() require("bufferline").cycle(-1) end, "bufferline: Move to Previous Buffer." },
	["<M->>"] = { function() require("bufferline").cycle(1) end, "bufferline: Move to Next Buffer." },
	["<M-a>"] = { function() require("hop").hint_char1() end, "hop.nvim: Hop 1 char" },
	["<M-A>"] = { function() require("hop").hint_char2() end, "hop.nvim: Hop 2 chars" },
	["<M-c>"] = { function() notifier({ cmd = function() require("bufferline").close_buffer_with_pick() end,
			message = "Selected buffer closed!", opts = mapping_default_opts })
	end, "bufferline: Pick a buffer to close." }, -- [1]
	["<M-d>"] = { function() notifier({ cmd = function() require("bufferline").pick_buffer() end,
			message = "Selected buffer displayed!", opts = mapping_default_opts })
	end, "bufferline: Pick a buffer to display." }, -- [1]
	["<M-s>"] = { function() require("hop").hint_anywhere({ direction = require("hop.hint").HintDirection.AFTER_CURSOR }) end,
		"hop.nvim: hop below anywhere" },
	["<M-S>"] = { function() require("hop").hint_anywhere({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR }) end,
		"hop.nvim: hop above anywhere" },
	["<M-v>"] = { function() notifier({ cmd = function() require("treesj").toggle() end,
			message = "treesj: toggled to wrap/one-line a context.", opts = mapping_default_opts })
	end,
		"treesj: Toggle 'One-Liner/Splitted' Style." },
	["<M-x>"] = { function() require("illuminate").goto_next_reference() end, "vim-illuminate: Jump to next reference" },
	["<M-z>"] = { function() require("illuminate").goto_prev_reference() end, "vim-illuminate: Jump to previous reference" },
	["<M-F>"] = { function() notifier({ cmd = function() vim.lsp.buf.format({ async = true }) end,
			message = "Formatting done!", opts = mapping_default_opts })
	end, "utils: Code Format (Async)" },
	["<S-Left>"] = { function() require("bufferline").move(-1) end, "buffeline: Move Buffer to the Left." },
	["<S-Right>"] = { function() require("bufferline").move(1) end, "bufferline: :Move Buffer to the Right." },
	["<Space>"] = {
		name = "LSP Actions",
		c = { function() notifier({ cmd = function() vim.lsp.buf.code_action() end, message = "Code action window triggered.",
				opts = mapping_default_opts })
		end, "lsp: seek code action" },
		d = { function() notifier({ cmd = vim.lsp.buf.declaration(), message = "Seek declaration triggered.",
			opts = mapping_default_opts }) end, "lsp: seek declaration" },
		D = { function() notifier({ cmd = vim.lsp.buf.definition(), message = "Seek definition triggered.",
			opts = mapping_default_opts }) end, "lsp: seek definition" },
		h = { function() notifier({ cmd = vim.lsp.buf.hover(), message = "Hover for context triggered.",
				opts = mapping_default_opts })
		end, "lsp: hover for context" },
		i = { function() notifier({ cmd = vim.lsp.buf.implementation(), message = "Seek implementation triggered.",
			opts = mapping_default_opts }) end, "lsp: seek implementation" },
		o = { function() notifier({ cmd = function() vim.diagnostic.open_float() end, message = "Float for context opened.",
				opts = mapping_default_opts })
		end, "lsp: float context" },
		r = { function() notifier({ cmd = function() vim.lsp.buf.rename() end, message = "Context renamed!",
				opts = mapping_default_opts })
		end, "lsp: rename context" },
		R = { function() notifier({ cmd = function() vim.lsp.buf.references() end, message = "Seek reference triggered.",
				opts = mapping_default_opts })
		end, "lsp: seek references" },
		s = { function() notifier({ cmd = function() vim.lsp.buf.signature_help() end,
				message = "Seek signature help triggered.", opts = mapping_default_opts })
		end, "lsp: seek signature help" },
		t = { function() notifier({ cmd = function() vim.lsp.buf.type_definition() end,
				message = "Seek type definition triggered.", opts = mapping_default_opts })
		end, "lsp: seek type definition" },
		x = { function() notifier({ cmd = function() vim.diagnostic.goto_prev() end,
				message = "Jumped from previous to diagnostic.", opts = mapping_default_opts })
		end, "lsp: go to previous" },
		z = { function() notifier({ cmd = function() vim.diagnostic.goto_next() end, message = "Jumped from next to diagnostic",
				opts = mapping_default_opts })
		end, "lsp: go to next" }
	}
})
