-- helpers.lua			| Plugins that eases the operation from the editor, more likely a `shortcut` to the process; external-helpers or utilities were also included in this plugin spec file; used for the package manager lazy.nvim"
-- @CodexLink				| https://github.com/CodexLink

local vg = vim.g
local vk = vim.keymap

return {
	{
		-- ! Literally a comment creator, this can be paired with a annotation plugin.
		"numToStr/Comment.nvim",
		config = true,
		event = "BufReadPost"
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
		config = function()
			local hop = require("hop")
			local directions = require("hop.hint").HintDirection

			vk.set("", "h", function()
				hop.hint_char1()
			end, { remap = true })

			vk.set("", "H", function()
				hop.hint_char2()
			end, { remap = true })

			vk.set("", "f", function()
				hop.hint_anywhere({ direction = directions.AFTER_CURSOR })
			end, { remap = true })

			vk.set("", "F", function()
				hop.hint_anywhere({ direction = directions.BEFORE_CURSOR })
			end, { remap = true })

			-- Do the conventional setup.
			hop.setup({})

		end,
		event = "BufReadPost"
	},
	{
		-- ! Incremental renaming context, similar to vscode's F2 rename system but incremental in this case.
		"smjonas/inc-rename.nvim",
		opts = {
			input_buffer_type = "dressing"
		},
		event = "BufReadPost"
	},
	{
		-- ! Jump the cursor from a certain region with two letters only.
		"ggandor/leap.nvim",
		config = function() require("leap").add_default_mappings() end,
		event = "BufReadPre"
	},
	{
		-- ! External helper tool that helps visualizes the markdown or text file to the browser.
		"iamcco/markdown-preview.nvim",
		build = function() vim.fn["mkdp#util#install"]() end,
		config = function()
			-- After installation, run other global variable configs.
			-- !!! The plugin runs in this way and not in the conventional 'config' function.

			-- Since this plugin is only loaded based on file extensiosn from 'ft' table, do not limit on markdown.
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
		event = "BufReadPost",
		config = function()
			require("neogen").setup({ snippet_engine = "luasnip" })
		end,
	},
	{
		-- ! Auto-adding or wrapping from both ends of a highlighted context.
		"windwp/nvim-autopairs",
		dependencies = {
			{ "hrsh7th/nvim-cmp" }
		},
		config = function()
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on(
				"confirm_done",
				cmp_autopairs.on_confirm_done()
			)
		end,
		event = "BufReadPost",
		opts = {
			check_ts = true,
			disable_filetype = { "TelescopePrompt" , "vim" },
			disable_in_macro = false,
			enable_check_bracket_line = true,
			fast_wrap = {
				map = "<M-w>",
				chars = { '{', '[', '(', '"', "'" },
				pattern = [=[[%'%"%)%>%]%)%}%,]]=],
				end_key = '$',
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "Search",
				highlight_grey="Comment"
			}
		}
	},
	{
		"mfussenegger/nvim-treehopper",
		dependencies = {
			{ "phaazon/hop.nvim" }
		},
		event = "BufReadPost"
	},
	{
	-- ! Structural search then replace; far more advanced than the conventional find and replace system.
	"cshuaimin/ssr.nvim",
	lazy = false,
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
		event = "BufReadPost",
		opts = {
			max_join_length = 512
		}
	},
	{
		-- ! Keybind guide for the editor.
		-- !!! I don't like this since I already have keybinds declared from the other plugin spec, will take consideration of this one.
    "folke/which-key.nvim",
		lazy = true, -- Lazy-loaded as `mapping.lua` will call it either way.
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
