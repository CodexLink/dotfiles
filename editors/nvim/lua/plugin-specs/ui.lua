-- ui.lua 					| Plugins that renders every part of the UI of my editor, these plugins are `first-order` classified, used for the package manager lazy.nvim"
-- Version 0.1.0		| Since 01/05/2023
-- @CodexLink				| https://github.com/CodexLink
return {
	{
		-- ! Buffer file displayed as a tab.
		"akinsho/bufferline.nvim",
		event = "VeryLazy",
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" }
		},
		opts = {
			options = {
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
							highlight = { underline = true, sp = "#FFD740" },
							matcher = function(buf)
								return buf.filename:match('%.py') or buf.filename:match('%.json') or buf.filename:match('%.js') or buf.filename:match('%.ts') or buf.filename:match('%.cpp') or buf.filename:match('%.c') or buf.filename:match('%.pinescript') -- !!! TODO: To add more.
							end,
							separator = {
								style = require('bufferline.groups').separator.tab
							},
						},
						{
							name = "Docs",
							auto_close = false,
							highlight = { underline = true, sp = "#64FFDA" },
							matcher = function(buf)
								return buf.filename:match('%.md') or buf.filename:match('%.txt')
							end,
							separator = {
								style = require('bufferline.groups').separator.tab
							},
						},
						{
							name = "Test",
							auto_close = false,
							highlight = { underline = true, sp = "#FF4081" },
							matcher = function(buf)
								return buf.filename:match('%_test') or buf.filename:match('%_spec')
							end,
							separator = {
								style = require('bufferline.groups').separator.tab
							},
						}
					}
				},
				hover = {
					enabled = true,
					delay = 200,
					reveal = { "close" }
				},
				indicator = {
					style = "underline"
				},
				offsets = {
					{
							filetype = "NvimTree",
							text = "Files",
							highlight = "Directory",
							separator = true
					}
				},
				separator_style = { "", "" },
				show_close_icon = false,
				show_buffer_close_icons = false,
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
		-- ! Status bar for the editor.
		-- TODO: Requires further customization!
		"nvim-lualine/lualine.nvim",
		event = "VeryLazy",
		opts = { icons_enabled = true }
	},
	{
		-- ! Side bar equivalent of `vscode` or any other modernized text editors.
	  "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
		config = true,
    dependencies = { 
			{ "nvim-lua/plenary.nvim" },
      { "nvim-tree/nvim-web-devicons" },
      { "MunifTanjim/nui.nvim" }
    },
		event = "VeryLazy",
		keys = {
			{"<M-s>", [[ <CMD>NeoTree position=right<CR> ]], desc = "Toggle NeoTree", { noremap = true, silent = true }}
		},
	},
	{
		-- ! Literally a scrollbar, but in nvim.
		"petertriho/nvim-scrollbar",
		config = true,
		event = "BufReadPost"
	},
	{
		-- ! Displays icons, more like from the `Nerd Fonts`, note that lots of plugins depend on this plugin!
		"nvim-tree/nvim-web-devicons",
		lazy = true,
		config = {
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
	}
}
