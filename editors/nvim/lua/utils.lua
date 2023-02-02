-- utils.lua  | Anything created by me.
-- @CodexLink    | https://github.com/CodexLink

-- ! Code Formatting
-- !!! Reference: https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Avoiding-LSP-formatting-conflicts
-- TODO: Do multiple protected calls for all cases + abstraction + DRY principles. (Reference: https://www.lua.org/pil/8.4.html)

local F = {}

--- DRY caller for the asynchronous notification.
---@params ctx, a table that contains the following: [ message<string>, level<number>, opts<table<string, any>>]
local function _call_async_notifier(ctx)
	local _async_provider = require("plenary.async")
	local _notify_async = require("notify").async

	_async_provider.run(function() _notify_async(ctx.message, ctx.level, ctx.opts) end)
end

-- TODO: Implement case string + argument concatenation until actual use-case has been identified.
-- IMPLEMENT-ME: Multiple arguments to a referenced function or a table composed of the fields.
---@params ctx, contains a table with the following attributes: [fn_reference<function>, message_success<optional | string>, message_failed<optional | string>, input_options<table<string, any>>]
function F.HandleInputToFn(ctx)
	-- Argument type checking
	if type(ctx) == "table" then
		if next(ctx) == nil then
			return error("Argument `ctx` should contain a key and value as a table!")
		end
	else
		return error("Argument `ctx` should be a table!")
	end

	if type(ctx.fn_reference) ~= "function" then
		return error("Argument `fn_reference` is not a function or a string!")
	end

	if ctx.message_success ~= nil then
		if type(ctx.message_success) ~= "string" then
			return error("Argument `message_success` is not a string!")
		end
	else
		ctx.message_success = "Passed input to the referenced function has been executed succesfully."
	end

	if ctx.message_failed ~= nil then
		if type(ctx.message_failed) ~= "string" then
			return error("Argument `message_failed` is not a string!")
		end
	else
		ctx.message_failed = "Passed input to the referenced function has been failed to execute."
	end

	if type(ctx.input_options) ~= "table" then
		return error("Argument `input_options` is not a table!")
	end

	-- Initialize options for the `notifier`.
	local _notifier_opts = { animate = true, timeout = 1500, title = "Input Handler to Function Argument" }

	-- Handle input.
	local _input = vim.ui.input(ctx.input_options, function(input)
		if not input then
			_call_async_notifier({ message = "Operation has been cancelled. Passed parameter is empty.",
				level = vim.log.levels.WARN, opts = _notifier_opts })
			return
		end
	end)

	-- Execute the function along with the input with pcall() in place.
	-- TODO: Do we even need these arguments?
	local _is_success, _err = pcall(function() ctx.fn_reference(_input) end)

	-- Then call a notifier in async.
	_call_async_notifier({
		messasge = _is_success and ctx.message_success or ctx.message_failed .. " | Error Code: " .. _err,
		level = _is_success and vim.log.levels.INFO or vim.log.levels.ERROR,
		opts = _notifier_opts
	})
end

-- Wrapper function for the `mapping.lua` that notifies the user after hitting the command for the sake of receiving the feedback.
---@params ctx, contains a table with the following attributes: [cmd<string|function>, message<string>, level<number>, opts<table<string, any>>]
function F.NotifyAfterExecution(ctx)
	-- Do type checking before proceeding.
	-- REFACTORME: If we can create a blueprint of table for us to validate the context of the table without the need of extrenous amount of if-else statement.

	local is_cmd_a_function = nil

	if type(ctx) == "table" then
		if next(ctx) == nil then
			return error("Argument `ctx` should contain a key and value as a table!")
		end
	else
		return error("Argument `ctx` should be a table!")
	end

	if type(ctx.cmd) == "string" then
		is_cmd_a_function = false
	elseif type(ctx.cmd) == "function" then
		is_cmd_a_function = true
	else
		return error("`cmd` parameter contains an invalid string or an invalid function, please pass a proper context.")
	end

	-- This one is optional as we might just be repeating ourselves at some point in the future.
	if ctx.level ~= nil then
		if type(ctx.level) ~= "number" then
			return error("`level` parameter contains an invalid level (integer from `vim.logs.levels`), please pass a proper context.")
		end
	end

	if type(ctx.message) ~= "string" then
		return error("`message` is not a valid string, please pass a proper context.")
	end

	if type(ctx.opts) ~= "table" then
		return error("Passed contents to variable `opts` at function `F.NotifyAfterExecution` is not a table! Received: ")
	end

	-- Call the `cmd` or the function given from the `cmd`.
	if is_cmd_a_function then ctx.cmd() else vim.cmd(ctx.cmd) end

	-- Then call `notify` in async.
	_call_async_notifier({ message = ctx.message, level = ctx.level or vim.log.levels.INFO, opts = ctx.opts or {} })
end

-- ! Lazy-load 'windows.nvim' when more buffer has been displayed.
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
