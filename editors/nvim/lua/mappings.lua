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
local require_input_on_fn_call = require("utils").HandleInputToFn
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
	["<F8>"] = { function() notifier({ cmd = function() require("telescope").load_extension("possession")
			require("telescope")
					.extensions.possession.list()
		end, message = "Session-to-load selection displayed.", opts = mapping_default_opts })
	end,
		"possession.nvim: session-to-load selection" },
	["<Leader>"] = {
		a = { function() notifier({ cmd = require("neogen").generate,
				message = "neogen: Code annotation added!", opts = mapping_default_opts })
		end, "neogen: Annotate code context" },
		G = {
			name = "gitsigns.nvim",
			b = { function() notifier({ cmd = require("gitsigns").toggle_current_line_blame,
					message = "gitsigns: Line blame toggled.", opts = mapping_default_opts })
			end, "Toggle line blame" },
			d = { function() notifier({ cmd = require("gitsigns").diffthis,
					message = "gitsigns: Diff view (at current line) activated.", opts = mapping_default_opts })
			end,
				"'diffthis' on current line" },
			D = { function() notifier({ cmd = function() require("gitsigns").diffthis("~") end,
					message = "gitsigns: Diff view (at whole file) activated.", opts = mapping_default_opts })
			end,
				"`diffthis` on whole file" },
			h = { function() notifier({ cmd = require("gitsigns").preview_hunk,
					message = "gitsigns: Hunk on current line preview, activated", opts = mapping_default_opts })
			end, "Preview hunk" },
			H = { function() notifier({ cmd = require("gitsigns").preview_hunk_inline,
					message = "gitsigns: Hunk on current line inline-preview, activated", opts = mapping_default_opts })
			end,
				"Preview hunk (Inlined)" },
		},
		L = { function() require("telescope").load_extension("lazygit") require("lazygit").lazygit() end,
			"lazygit.nvim: Toggle window" },
		m = { [[ <CMD>MarkdownPreviewToggle<CR> ]], "markdown-preview.nvim: Toggle" },
		n = { function() require("telescope").extensions.notify.notify() end,
			"nvim-notify: Check notifications via 'Telescope'" },
		r = { function() require("ssr").open() end, mode = { "n", "x" }, "ssr.nvim: Do 'Structural Search and Replace'" },
		s = {
			name = "possession.nvim: Session Management",
			d    = { function() require_input_on_fn_call({ fn_reference = require("possession").delete,
				input_options = { prompt = "Session name to delete." } }) end, "possession.nvim: Delete session by name" },
			s    = { function() require_input_on_fn_call({ fn_reference = require("possession").save,
				input_options = { prompt = "Session name to save." } }) end, "possession.nvim: Save current session" },
			l    = { function() require_input_on_fn_call({ fn_reference = require("possession").load,
				input_options = { prompt = "Session name to load. (Note: Use `telescope` to retrieve a list of sessions!)" } }) end,
				"Load saved session (dialogue)" },
		},
		t = { function() require("tsht").nodes() end, "nvim-treehopper: Hop to highlight context" },
		T = { function() notifier({ cmd = require("twilight").toggle,
				message = "twilight: Code dimming toggled.", opts = mapping_default_opts })
		end, "twilight.nvim: Toggle code dimming" },
		w = {
			name = "windows.nvim",
			["="] = { function() notifier({ cmd = require("windows.commands").equalize,
					message = "All buffer windows were equalized.", opts = mapping_default_opts })
			end, "Equalize" },
			["+"] = { function() notifier({ cmd = require("windows.commands").maximize,
					message = "Current window set to maximized.", opts = mapping_default_opts })
			end, "Maximize" },
			["-"] = { function() notifier({ cmd = require("windows.commands").maximize_vertically,
					message = "Current window set to maximize vertically.", opts = mapping_default_opts })
			end, "Maximize vertically" },
			["_"] = { function() notifier({ cmd = require("windows.commands").maximize_horizontally,
					message = "Current window set to maximize horizontally.", opts = mapping_default_opts })
			end, "Maximize horizontally" },
		}
	},
	["<M-~>"] = { function() notifier({ cmd = [[ set wrap! ]], message = "Code wrapping toggled.",
			opts = mapping_default_opts })
	end, "builtin: Toggle wrap" },
	["<M-<>"] = { function() require("bufferline").cycle(-1) end, "bufferline: Move to Previous Buffer." },
	["<M->>"] = { function() require("bufferline").cycle(1) end, "bufferline: Move to Next Buffer." },
	["<M-a>"] = { function() require("hop").hint_char1() end, "hop.nvim: Hop 1 char" },
	["<M-A>"] = { function() require("hop").hint_char2() end, "hop.nvim: Hop 2 chars" },
	["<M-c>"] = { function() notifier({ cmd = require("bufferline").close_buffer_with_pick,
			message = "Selected buffer closed!", opts = mapping_default_opts })
	end, "bufferline: Pick a buffer to close." }, -- [1]
	["<M-d>"] = { function() notifier({ cmd = require("bufferline").pick_buffer,
			message = "Selected buffer displayed!", opts = mapping_default_opts })
	end, "bufferline: Pick a buffer to display." }, -- [1]
	["<M-s>"] = { function() require("hop").hint_anywhere({ direction = require("hop.hint").HintDirection.AFTER_CURSOR }) end,
		"hop.nvim: hop below anywhere" },
	["<M-S>"] = { function() require("hop").hint_anywhere({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR }) end,
		"hop.nvim: hop above anywhere" },
	["<M-v>"] = { function() notifier({ cmd = require("treesj").toggle,
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
		name = "LSP + LSP-Related Actions",
		c = { function() notifier({ cmd = vim.lsp.buf.code_action,
				opts = mapping_default_opts })
		end, "lsp: seek code action" },
		d = { function() notifier({ cmd = vim.lsp.buf.declaration,
				opts = mapping_default_opts })
		end, "lsp: seek declaration" },
		D = { function() notifier({ cmd = vim.lsp.buf.definition,
				opts = mapping_default_opts })
		end, "lsp: seek definition" },
		h = { function() notifier({ cmd = vim.lsp.buf.hover,
				opts = mapping_default_opts })
		end, "lsp: hover for context" },
		i = { function() notifier({ cmd = vim.lsp.buf.implementation,
				opts = mapping_default_opts })
		end, "lsp: seek implementation" },
		o = { function() notifier({ cmd = vim.diagnostic.open_float,
				opts = mapping_default_opts })
		end, "lsp: float context" },
		r = { function() notifier({ cmd = vim.lsp.buf.rename,
				opts = mapping_default_opts })
		end, "lsp: rename context" },
		R = { ":IncRename ", "inc-rename.nvim: Rename on cursor" },
		s = { function() notifier({ cmd = vim.lsp.buf.signature_help,
				opts = mapping_default_opts })
		end, "lsp: seek signature help" },
		S = { function() notifier({ cmd = vim.lsp.buf.references,
				opts = mapping_default_opts })
		end, "lsp: seek references" },
		t = { function() notifier({ cmd = vim.lsp.buf.type_definition,
				message = "Seek type definition triggered.", opts = mapping_default_opts })
		end, "lsp: seek type definition" },
		x = { function() notifier({ cmd = vim.diagnostic.goto_prev,
				message = "Jumped from previous to diagnostic.", opts = mapping_default_opts })
		end, "lsp: go to previous" },
		z = { function() notifier({ cmd = vim.diagnostic.goto_next, message = "Jumped from next to diagnostic",
				opts = mapping_default_opts })
		end, "lsp: go to next" }
	}
})
