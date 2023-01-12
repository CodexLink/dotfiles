-- ui-helpers.lua 	| Plugins that naturally makes the UI even more better, these plugins were add-ons from the `first-order plugins`, therefore plugins declared from this file were classified as `second-order plugins`; used for the package manager lazy.nvim"
-- Version 0.1.0		| Since 01/05/2023
-- @CodexLink				| https://github.com/CodexLink

return {
	{
		-- ! Alternative dialogue, similar to `telescope.nvim`.
		-- !!! This plugin is a dependency from other plugins!
		"stevearc/dressing.nvim",
		opts = {
			input = {
				override = function(conf)
					conf.col = -1
					conf.row = 0
					return conf
				end,
			}
		}
		end,
		lazy = true
	},
	{
		-- ! Displays git states from each line either by blame or by hunk (changes from that line).
		"lewis6991/gitsigns.nvim",
		config = function()
			require("scrollbar.handlers.gitsigns").setup()
		end,
		dependency = {
			{"petertriho/nvim-scrollbar" } -- !!! Despite this plugin is declared in `ui.lua`, if `ui-helpers.lua` was the first plugin spec file to initialize, then install this plugin as possible, if missing, then re-configure on `ui.lua` later.
		},
		keys = {
			{ "<C-G>h", "<CMD>Gitsigns preview_hunk<CR>", desc = "Preview hunk (changes on certain code line)." },
			{ "<C-G>b", "<CMD>Gitsigns toggle_current_line_blame<CR>", desc = "Toggle line blame." },
			{ "<C-G>d", "<CMD>Gitsigns diffthis<CR>", desc = "Activate 'diffthis' on current line." },
			{ "<C-G>D", function() require("gitsigns").diffthis("~") end, desc = "Activate `diffthis` on whole file." },
		},
		event = "BufReadPost",
		opts = {
			current_line_blame = true,
			numhl = true,
			word_diff = true
		}
	},
	{
		-- ! Colorizes any string that states a color.
		"NvChad/nvim-colorizer.lua",
		config = true,
		event = "BufReadPost"
	},
	{
		-- ! Display notification from the right side, similar to modern game notification system.
		-- !!! Lazy-loaded because only my own config will use this plugin.
		"rcarriga/nvim-notify",
		config = true,
		lazy = true
	},
	{
		-- File explorer, but in dialogue, this is very similar to `dressing.nvim`.
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		lazy = false,
		init = function()
			local telescope = require("telescope")
			telescope.load_extension("fzf")       -- nvim-telescope/telescope-ui-select.nvim
			telescope.load_extension("ui-select") -- nvim-telescope/telescope-ui-select.nvim
		end,
		config = {
			defaults = {
				layout_config = {
					vertical = { width = 0.5 }
				},
			},
			extensions = {
				fzf = {
					fuzzy = true,                    -- false will only do exact matching
					override_generic_sorter = true,  -- override the generic sorter
					override_file_sorter = true,     -- override the file sorter
					case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
				}
			}
		},
		dependencies = {
			{ "nvim-lua/plenary.nvim", lazy = false },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			{ "nvim-telescope/telescope-ui-select.nvim" }
		}
	},
	{
		"folke/trouble.nvim",
		event = "BufReadPost",
		opts = {
			action_keys = {
				close = "q",
				cancel = "<esc>",
				refresh = "r",
				jump = {"<cr>", "<tab>"},
				open_split = { "<c-x>" },
				open_vsplit = { "<c-v>" },
				open_tab = { "<c-t>" },
				jump_close = {"o"},
				toggle_mode = "m",
				toggle_preview = "P",
				hover = "K",
				preview = "p",
				close_folds = {"zM", "zm"},
				open_folds = {"zR", "zr"},
				toggle_fold = {"zA", "za"},
				previous = "k",
				next = "j"
			},
			mode = "lsp_references"
		}
	},
	{
		-- ! Code dimmer (by buffer, blocks) when the cursor is focused elsewhere.
		"folke/twilight.nvim",
		config = true,
		event = "BufReadPost"
	},
	{
		-- ! Highlights similar case of a certain pattern from the code, similar to vscode's highlight behavior.
		"RRethy/vim-illuminate",
		config = function() require("illuminate").configure({}) end,
		event = "BufReadPost"
}
	{
		-- ! Window sizing management with animation.
		"anuvyklack/windows.nvim",
		config = function()
				vim.o.winwidth = 10
				vim.o.winminwidth = 10
				vim.o.equalalways = false
				require("windows").setup()
			end,
		dependencies = {
			{ "anuvyklack/middleclass" },
			{ "anuvyklack/animation.nvim" }
		},
		event = "VeryLazy",
		keys = {
			{ "<C-W>M", "<CMD>WindowsMaximize<CR>", desc = "Maximize the focused window." },
			{ "<C-W>|", "<CMD>WindowsMaximizeVertically<CR>", desc = "Maximize vertical side of the focused window." },
			{ "<C-W>-", "<CMD>WindowsMaximizeHorizontally<CR>", desc = "Maximize horizontal side of the focused window." },
			{ "<C-W>=", "<CMD>WindowsEqualize<CR>", desc = "Equalize all windows." }
		}
}
}
