-- utils.lua  | Anything created by me.
-- @CodexLink    | https://github.com/CodexLink

-- ! Code Formatting
-- !!! Reference: https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
local F = {}

function F.LSPCodeFormat()
	local async_provider = require("plenary.async")
	local notify_async = require("notify").async

	vim.lsp.buf.format({ async = true })
	async_provider.run(function() notify_async("Formatting done!") end)
end

vim.api.nvim_create_user_command("LSPCodeFormat", F.LSPCodeFormat, {})

-- ! Lazy-load windows.nvim when more buffer has been displayed.
local is_window_lazy_loaded = false
vim.api.nvim_create_autocmd("BufEnter", {
	callback = function()
		-- Reference for counting the number of existing buffers: https://stackoverflow.com/questions/17931507/vimscript-number-of-listed-buffers
		-- Problem with this autocmd was, this won't work when a single buffer has a split view.
		local existing_buffers_count = vim.fn.len(vim.fn.filter(vim.fn.range(1, vim.fn.bufnr('$')), 'buflisted(v:val)'))
		if (not is_window_lazy_loaded and existing_buffers_count > 1) then require("windows.commands").equalize() end
	end
})

-- Highlight yank for a short time period.
vim.api.nvim_create_autocmd("TextYankPost",
	{ callback = function() vim.highlight.on_yank({ higroup = "HighlightedYank", timeout = 1250 }) end })


return F
