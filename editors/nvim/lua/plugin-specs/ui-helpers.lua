-- ui-helpers.lua 	| Plugins that naturally makes the UI even more better, these plugins were add-ons from the `first-order plugins`, therefore plugins declared from this file were classified as `second-order plugins`; used for the package manager lazy.nvim"
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
				end
			}
		},
		lazy = true
	},
	{
		-- ! Displays git states from each line either by blame or by hunk (changes from that line).
		"lewis6991/gitsigns.nvim",
		config = function()
			require("scrollbar.handlers.gitsigns").setup()
			-- ! Since we overriden the config field of this plugin spec, we have to re-establish this plugin's setup.
			-- !! We cannot use `opts` field anymore because of the potential conflict configuration with the `config` field.
			require("gitsigns").setup({
				current_line_blame = true,
				numhl = true,
				signs = {
					add = { text = '+' },
					change = { text = '~' },
					delete = { text = '-' },
					topdelete = { text = '--' },
					changedelete = { text = '=' },
					untracked = { text = '?' },
				}
			})
		end,
		dependencies = {
			{"petertriho/nvim-scrollbar" } -- !!! Despite this plugin is declared in `ui.lua`, if `ui-helpers.lua` was the first plugin spec file to initialize, then install this plugin as possible, if missing, then re-configure on `ui.lua` later.
		},
		event = "BufReadPost"
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
		enabled = false,
		lazy = false,
		init = function()
			local telescope = require("telescope")
			telescope.load_extension("fzf")       -- nvim-telescope/telescope-ui-select.nvim
			telescope.load_extension("ui-select") -- nvim-telescope/telescope-ui-select.nvim
		end,
		opts = {
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
			{ "nvim-treesitter/nvim-treesitter" },
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
				cancel = "<ESC>",
				refresh = "r",
				jump = {"<CR>", "<TAB>"},
				open_split = { "<C-x>" },
				open_vsplit = { "<C-v>" },
				open_tab = { "<C-t>" },
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
			}
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
	},
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
		event = "VeryLazy"
	}
}
