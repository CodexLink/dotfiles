-- helpers.lua			| Plugins that eases the operation from the editor, more likely a `shortcut` to the process; external-helpers or utilities were also included in this plugin spec file; used for the package manager lazy.nvim"
-- Version 0.1.0		| Since 01/12/2023
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

			vk.set("", "f", function()
				hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
			end, { remap = true })

			vk.set("", "F", function()
				hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
			end, { remap = true })

			vk.set("", "t", function()
				hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
			end, { remap = true })

			vk.set("", "T", function()
				hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
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
		event = "BufReadPost",
		keys = {
			{ "<S-F2>", ":IncRename ", desc = "Incremental renaming by typing the name." },
			{ "<F2>", function() return ":IncRename " .. vim.fn.expand("<CWORD>") end, desc = "Incremental renaming by typing the name.", { expr = true }},
		},
	},
	{
		-- ! Jump the cursor from a certain region with two letters only.
		"ggandor/leap.nvim",
		config = function() require("leap").add_default_mappings() end,
		event = "EventBufPre"
	}
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
		keys = {
			{ "<leader>mp", [[ <CMD>MarkdownPreview<CR> ]], desc = "Activate 'markdown-preview'." },
			{ "<leader>mP", [[ <CMD>MarkdownPreviewToggle<CR> ]], desc = "Toggle 'markdown-preview'." },
			{ "<leader>mS", [[ <CMD>MarkdownPreviewStop<CR> ]], desc = "Deactivate 'markdown-preview'." }
		},
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
		keys = {
			{ "<Leader>ag", [[ <CMD>require("neogen").generate()<CR> ]],  { noremap = true, silent = true } }
		}
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
		event = "BufReadPost",
		keys = {
			{ "<Leader>th", function() require("tsht").nodes() end, desc = "Toggle nodes to region highlight." },
		},
	},
	{
		-- ! Session loader from each time `nvim` was opened.
		"folke/persistence.nvim",
		config = true,
		event = "VeryLazy",
		keys = {
			{"<LEADER>plc", [[ <CMD>lua require("persistence").load()<CR> ]], desc = "Persistence: Load session from the current directory."},
			{"<LEADER>pls", [[ <CMD>lua require("persistence").load({ last = true})<CR> ]], desc = "Persistence: Load session from the last session."},
			{"<LEADER>pq", [[ <CMD>lua require("persistence").stop()<CR> ]], desc = "Persistence: Stop saving current session on exit."},
		}
	},
	{
	-- ! Structural search then replace; far more advanced than the conventional find and replace system.
	"cshuaimin/ssr.nvim",
	keys = {
		{ "<leader>SR", function () require("ssr").open() end, mode={ "n", "x" }, desc = "Do 'Structural Search and Replace'." },
	},
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
		keys = {
			{ "<M->t", [[ <CMD>TSJToggle<CR> ]], desc = "Toggle 'One-Liner or Splitted Context' Code." },
		},
		opts = {
			max_join_length = 512
		}
	},
	{
		-- ! Extends the nvim's % motion by allowing code context to jump through other than brackets, parenthesis and any other identifiers that is made of symbols.
		"andymass/vim-matchup",
		config = true,
		event = "VeryLazy"
	}
	{
		-- ! Keybind guide for the editor.
		-- !!! I don't like this since I already have keybinds declared from the other plugin spec, will take consideration of this one.
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
				-- !!! TODO
			})
    end,
		lazy = false,
  }
}
