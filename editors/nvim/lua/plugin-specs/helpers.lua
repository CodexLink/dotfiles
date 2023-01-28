-- helpers.lua			| Plugins that eases the operation from the editor, more likely a `shortcut` to the process; external-helpers or utilities were also included in this plugin spec file; used for the package manager lazy.nvim"
-- @CodexLink				| https://github.com/CodexLink

return {
	{
		-- ! Literally a comment creator, this can be paired with annotation plugin.
		"numToStr/Comment.nvim",
		config = true,
		event = { "BufNewFile", "BufReadPost" },
		lazy = true
	},
	{
		-- ! Alternative `git diff` viewer, supported by `lazy.nvim` (package manager).
		"sindrets/diffview.nvim",
		lazy = true,
		dependencies = { "nvim-lua/plenary.nvim" }
	},
	{
		-- ! Similar to Vimium C, jump to certain part of code, this is way similar to `leap.nvim` but it uses 2 letters to jump to certain part of code.
		-- !!! This plugin is useful when we don't want a keyword-based jump.
		"phaazon/hop.nvim",
		config = true,
		lazy = true
	},
	{
		-- ! Incremental renaming context, similar to vscode's F2 rename system but incremental in this case.
		"smjonas/inc-rename.nvim",
		config = true,
		event = "BufReadPost",
		lazy = true,
		opts = {
			input_buffer_type = "dressing"
		}
	},
	{
		-- ! External helper tool that helps visualizesa the markdown or text file to the browser.
		"iamcco/markdown-preview.nvim",
		build = function() vim.fn["mkdp#util#install"]() end,
		config = function()
			-- After installation, run other global variable configs.
			-- !!! The plugin runs in this way and not in the conventional 'config' function.

			-- Since this plugin is only loaded based on file extensiosn from 'ft' table, do not limit on markdown.
			local vg = vim.g

			vg.mkdp_command_for_global = 1
			vg.mkdp_page_title = "${name} | mkdp (live)"
			vg.mkdp_filetypes = { "markdown", "text" }
		end,
		ft = {
			"markdown",
			"text"
		}
	},
	{
		"danymat/neogen",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("neogen").setup({ snippet_engine = "luasnip" })
		end,
		lazy = true
	},
	{
		-- ! Auto-adding or wrapping from both ends of a highlighted context.
		"windwp/nvim-autopairs",
		dependencies = { { "hrsh7th/nvim-cmp" } },
		config = function(plugin, opts)
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")

			cmp.event:on(
				"confirm_done",
				cmp_autopairs.on_confirm_done()
			)

			require(plugin.name).setup(opts)
		end,
		event = { "BufAdd", "BufReadPost", "BufNewFile" },
		opts = {
			check_ts = true,
			fast_wrap = { map = "<M-w>" },
			map_c_w = true,
			map_c_h = true,
			map_cr = true
		}
	},
	{
		"mfussenegger/nvim-treehopper",
		dependencies = { { "phaazon/hop.nvim" } },
		lazy = true
	},
	{
		-- ! Structural search then replace; far more advanced than the conventional find and replace system.
		"cshuaimin/ssr.nvim",
		lazy = true,
		opts = {
			keymaps = {
				close = "q",
				next_match = "n",
				prev_match = "N",
				replace_confirm = "<cr>",
				replace_all = "<leader><cr>",
			},
		}
	},
	{
		-- ! Code Context to `One-Liner` or `Split-by-Blocks` Plugin.
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		lazy = true,
		opts = {
			max_join_length = 512
		}
	},
	{
		-- ! Outputs keybinds when pressed a key for the editor.
		"folke/which-key.nvim",
		lazy = false,
		opts = {
			layout = {
				spacing = 5,
				align = "center"
			},
			operators = { gc = "Comments" },
			popup_mappings = {
				scroll_down = "<PageDown>",
				scroll_up = "<PageUp>"
			},
			spelling = {
				enabled = true,
				suggestions = 15
			},
		}
	}
}
