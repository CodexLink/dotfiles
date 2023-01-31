-- utils.lua  | Anything created by me.
-- @CodexLink    | https://github.com/CodexLink

-- ! Code Formatting
-- !!! Reference: https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
-- TODO: Do multiple protected calls for all cases + abstraction + DRY principles. (Reference: https://www.lua.org/pil/8.4.html)

local F = {}

-- Wrapper function for the `mapping.lua` that notifies the user after hitting the command for the sake of receiving the feedback.
function F.NotifyAfterExecution(props)
	-- Do type checking before proceeding.
	-- REFACTORME: If we can create a blueprint of table for us to validate the context of the table without the need of extrenous amount of if-else statement.

	local is_cmd_a_function = nil

	if type(props.cmd) == "string" then
		is_cmd_a_function = false
	elseif type(props.cmd) == "function" then
		is_cmd_a_function = true
	else
		return error("`cmd` parameter contains an invalid string or an invalid function, please pass a proper context.")
	end

	-- This one is optional as we might just be repeating ourselves at some point in the future.
	if type(props.level) ~= "nil" then
		if type(props.level) ~= "number" then
			return error("`level` parameter contains an invalid level (integer from `vim.logs.levels`), please pass a proper context.")
		end
	end

	if type(props.message) ~= "string" then
		return error("`message` is not a valid string, please pass a proper context.")
	end

	if type(props.opts) ~= "table" then
		return error("Passed contents to variable `opts` at function `F.NotifyAfterExecution` is not a table! Received: ")
	end

	-- ! Import required dependencies
	local async_provider = require("plenary.async")
	local notify_async = require("notify").async

	-- Call the `cmd` or the function given from the `cmd`.
	if is_cmd_a_function then props.cmd() else vim.cmd(props.cmd) end

	-- Then call `notify` in async.
	async_provider.run(
		function()
			notify_async(props.message, props.level or vim.log.levels.INFO, props.opts or {})
		end
	)
end

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
	{ callback = function() vim.highlight.on_yank({ higroup = "HighlightedYank", timeout = 1250 }) end }
)


return F
