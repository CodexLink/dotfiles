-- markdown-preview.lua | Plugin spec for the 'markdown-preview', used for the package manager lazy.nvim"
-- Version 0.1.1  | Since 01/08/2023
-- @CodexLink     | https://github.com/CodexLink
-- References: https://github.com/nvim-telescope/telescope.nvim#usage

local vg = vim.g

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
		{ "<leader>ca", "<cmd>MarkdownPreview<cr>", desc = "Activate 'markdown-preview'." },
		{ "<leader>C", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle 'markdown-preview'." },
		{ "<leader>cd", "<cmd>MarkdownPreviewStop<cr>", desc = "Deactivate 'markdown-preview'." }
	},
	ft = {
		"markdown",
		"text"
	}
}
