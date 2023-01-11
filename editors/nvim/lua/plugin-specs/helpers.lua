-- helpers.lua			| Plugins that eases the operation from the editor, more likely a `shortcut` to the process; external-helpers or utilities were also included in this plugin spec file; used for the package manager lazy.nvim"
-- Version 0.1.0		| Since 01/12/2023
-- @CodexLink				| https://github.com/CodexLink

local vg = vim.g

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
