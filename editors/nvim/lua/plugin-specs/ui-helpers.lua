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
		-- ! Code dimmer (by buffer, blocks) when the cursor is focused elsewhere.
		"folke/twilight.nvim",
		config = function(_, opts)
			-- Setup the plugin first.
			require("twilight").setup(opts)

			-- Then run "TwilightEnable" immediately after load.
			vim.cmd([[ TwilightEnable ]])
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
		},
		event = "VeryLazy"
	}
}
