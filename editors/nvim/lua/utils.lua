-- utils.lua  | Anything created by me.
-- @CodexLink    | https://github.com/CodexLink


-- ! Code Formatting
-- !!! Reference: https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts

local lsp_formatting = function()
	local async_provider = require("plenary.async")
	local notify_async = require("notify").async_provider

	vim.lsp.buf.format({ async = true })
	async_provider.run(function() notify_async("Formatting done!") end)
end
vim.api.nvim_create_user_command("LSPCodeFormat", lsp_formatting, {})
