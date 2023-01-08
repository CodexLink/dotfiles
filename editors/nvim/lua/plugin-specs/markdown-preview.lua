-- markdown-preview.lua | Plugin spec for the 'markdown-preview', used for the package manager lazy.nvim"
-- Version 0.1.2  | Since 01/08/2023
-- @CodexLink     | https://github.com/CodexLink
-- References: https://github.com/nvim-telescope/telescope.nvim#usage

local vg = vim.g
local vc = vim.cmd

return {
	"iamcco/markdown-preview.nvim",
	build = function() vim.fn["mkdp#util#install"]() end,
	lazy = true,
	config = function()
		-- After installation, run other global variable configs.
		-- !!! The plugin runs in this way and not in the conventional 'config' function.
		
		-- Since this plugin is only loaded based on file extensiosn from 'ft' table, do not limit on markdown.
		vg.mkdp_command_for_global = 1
		vg.mkdp_page_title = "${name} | mkdp (live)"
		vg.mkdp_filetypes = { "markdown", "text" }
	end,
	keys = {
		{ "<leader>ca", function () vc("MarkdownPreview") print("Markdown Preview activated!") end, desc = "Activate 'markdown-preview'." },
		{ "<leader>C", function () vc("MarkdownPreviewToggle") print("Markdown Preview toggled.") end, desc = "Toggle 'markdown-preview'." },
		{ "<leader>cd", function () vc("MarkdownPreviewStop") print("Markdown Preview deactivated!") end, desc = "Deactivate 'markdown-preview'." }
	},
	ft = {
		"markdown",
		"text"
	}
}
