-- ui-helpers.lua 	| Plugins that naturally makes the UI even more better, used for the package manager lazy.nvim"
-- @CodexLink				| https://github.com/CodexLink

return {
	{
		-- ! Alternative dialogue, similar to `telescope.nvim`.
		"stevearc/dressing.nvim",
		config = true,
		lazy = false,
		opts = {
			input = {
				override = function(conf)
					conf.col = -1
					conf.row = 0
					return conf
				end
			},
			mappings = {
				n = {
					["<Esc>"] = "Close",
					["<CR>"] = "Confirm",
				},
				i = {
					["<C-c>"] = "Close",
					["<C-w>"] = "Confirm",
					["<C-q>"] = "HistoryPrev",
					["<C-e>"] = "HistoryNext",
				},
			},
		},
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
			{ "petertriho/nvim-scrollbar" } -- !!! Despite this plugin is declared in `ui.lua`, if `ui-helpers.lua` was the first plugin spec file to initialize, then install this plugin as possible, if missing, then re-configure on `ui.lua` later.
		}
	},
	{
		-- ! Colorizes any string that states a color.
		"NvChad/nvim-colorizer.lua",
		config = true,
		event = { "BufAdd", "BufNewFile", "BufReadPost" }
	},
	{
		-- ! Display notification from the right side, similar to modern game notification system.
		-- !!! Lazy-loaded because only my own config will use this plugin.
		"rcarriga/nvim-notify",
		config = function(_, opts)
			require("notify").setup(opts)
			vim.notify = require("notify")
		end,
		lazy = false,
		opts = { render = "compact" }
	},
	{
		-- ! Code dimmer (by buffer, blocks) when the cursor is focused elsewhere.
		"folke/twilight.nvim",
		config = function(_, opts)
			-- Setup the plugin first.
			require("twilight").setup(opts)
		end,
		event = "VeryLazy",
		opts = {
			dimming = { alpha = 0.40 }
		}
	},
	{
		-- ! Highlights similar case of a certain pattern from the code, similar to vscode's highlight behavior.
		"RRethy/vim-illuminate",
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
		}
	}
}
