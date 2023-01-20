-- ui.lua 					| Plugins that renders every part of the UI of my editor, these plugins are `first-order` classified, used for the package manager lazy.nvim"
-- @CodexLink				| https://github.com/CodexLink

return {
	{
		-- ! Buffer file displayed as a tab.
		"akinsho/bufferline.nvim",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" }
		},
		lazy = false,
		opts = {
			options = {
				always_show_bufferline = false,
				color_icons = true,
				diagnostics = "nvim_lsp",
				 groups = {
					options = {
						toggle_hidden_on_enter = true
					},
					items = {
						{
							name = "Code",
							auto_close = false,
							highlight = { sp = "#FFD740" },
							matcher = function(buf)
								return buf.filename:match("%.c") or buf.filename:match("%.cpp") or buf.filename:match("%.lua") or buf.filename:match("%.js") or buf.filename:match("%.json") or buf.filename:match("%.py") or buf.filename:match("%.ts")
							end
						},
						{
							name = "Docs",
							auto_close = false,
							highlight = { sp = "#64FFDA" },
							matcher = function(buf)
								return buf.filename:match('%.md') or buf.filename:match('%.txt')
							end
						},
						{
							name = "Test",
							auto_close = false,
							highlight = { sp = "#FF4081" },
							matcher = function(buf)
								return buf.filename:match('%_test') or buf.filename:match('%_spec')
							end
						}
					},
				},
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" }
				},
				separator_style = { "", "" },
				show_close_icon = false,
				show_buffer_close_icons = false,
				show_tab_indicators = true,
				sort_by = "id"
			}
		}
	},
	{
		-- ! Indention guider, useful on identifying space or tabs on code.
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPost",
		opts = {
			show_current_context = true,
			show_current_context_start = true,
			show_end_of_line = true
		}
	},
	{
		-- ! Lazygit but in neovim window, added in the UI as its not an enhancement plugin but rather an extender which is a UI component at this point.
		"kdheepak/lazygit.nvim",
		lazy = false,
		config = function()
			vim.g.lazygit_floating_window_use_plenary = 1
			vim.g.lazygit_use_neovim_remote = 0
		end
	},
	{
		-- ! Status bar for the editor.
		-- TODO: Requires further customization!
		"nvim-lualine/lualine.nvim",
		lazy = false,
		opts = { icons_enabled = true }
	},
	{
		-- ! Literally a scrollbar, but in nvim.
		"petertriho/nvim-scrollbar",
		config = true,
		event = "BufReadPost"
	},
	{
		-- ! File explorer, but in dialogue, this is very similar to `dressing.nvim`, but has all-in-one capabilities.
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "kdheepak/lazygit.nvim" },
			{ "nvim-telescope/telescope-file-browser.nvim" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		init = function()
			local telescope = require("telescope")

			telescope.load_extension("fzf")
			telescope.load_extension("file_browser")
			telescope.load_extension("lazygit")
		end,
		lazy = false,
		opts = {
			defaults = {
				layout_config = {
					vertical = { width = 0.5 }
				}
			},
			extensions = {
				file_browser = {
					hijack_netrw = true
				},
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case"
				}
			}
		}
	},
	{
		-- ! Displays icons, more like from the `Nerd Fonts`, note that lots of plugins depend on this plugin!
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		opts = {
			color_icons = true,
			default = true
		}
	},
	{
		-- ! DAP-Equivalent for displaying code context in one sidebar.
		-- !!! This plugin displays its sidebar on the position=right.
		"simrat39/symbols-outline.nvim",
		config = true,
		event = "BufReadPre",
	},
	{
		-- ! Bottom panel that contains diagnostics.
		"folke/trouble.nvim",
		event = "BufReadPost",
		opts = {
			action_keys = {
				close = "q",
				cancel = "<ESC>",
				refresh = "r",
				jump = {"<CR>", "<TAB>"},
				open_split = "<C-s>",
				open_vsplit = "<C-S>",
				open_tab = "<C-t>",
				jump_close = "o",
				toggle_mode = "m",
				toggle_preview = "P",
				hover = "K",
				preview = "p",
				close_folds = "zc",
				open_folds = "zx",
				toggle_fold = "zz",
				previous = "k",
				next = "j"
			}
		}
	},
}
