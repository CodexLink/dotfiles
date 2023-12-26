--@module 'utils'
---@author CodexLink <https://github.com/CodexLink>
---@license Apache-2.0

local F = {}

local uv = require("luv")

F.WakaTimeToday = ""

-- NOTE: Reference for this function: https://github.com/wakatime/vim-wakatime/issues/110.
-- NOTE: though I typed all of it to better understand how `uv` works.
local function SetFnInterval(interval_minutes, callback)
  local uv_timer = uv.new_timer()

  local has_interval_cb_started = false
  local evaluated_interval = interval_minutes * 60000

  uv_timer:start(not has_interval_cb_started and 0 or evaluated_interval, evaluated_interval, function() callback() end)
end

local function WakaTimeCLITodayProcessor()
  local process_stdout = uv.new_pipe()
  local _, __ = uv.spawn("wakatime", { args = { "--today" }, stdio = { nil, process_stdout, nil } },
    function(code, signal)
      if (code > 1) then
        require("notify")("WakaTime CLI returned an error code of " .. code .. " | Signal:" .. signal)
        return
      end
      process_stdout:close()
    end)

  process_stdout:read_start(
    function(err, data)
      assert(not err, err)

      if data then
        F.WakaTimeToday = string.gsub(data, "\n", "")
      end
    end
  )
end

SetFnInterval(5, WakaTimeCLITodayProcessor)

--- DRY caller for the asynchronous notification.
---@params ctx, a table that contains the following: [ message<string>, level<number>, opts<table<string, any>>]
local function _call_async_notifier(ctx)
  local _async_provider = require("plenary.async")
  local _notify_async = require("notify").async

  _async_provider.run(function()
    _notify_async(ctx.message or "Notification has been called without further context.",
      ctx.level or vim.log.levels.INFO, ctx.opts or {})
  end)
end

-- TODO: Implement case string + argument concatenation until actual use-case has been identified.
-- IMPLEMENT-ME: Multiple arguments to a referenced function or a table composed of the fields.
---@params ctx, contains a table with the following attributes: [fn_reference<function>, message_success<optional | string>, message_failed<optional | string>, input_options<table<string, any>>, do_not_modify<boolean>]
function F.HandleInputToFn(ctx)
  -- Argument type checking
  local state_messages_both_empty = false

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

  if ctx.message_failed == nil and ctx.message_success == nil then
    state_messages_both_empty = true
  else
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
  end

  if type(ctx.input_options) ~= "table" then
    return error("Argument `input_options` is not a table!")
  end

  -- Handle input.
  vim.ui.input(ctx.input_options, function(input)
    -- Initialize options for the `notifier`.
    local _notifier_opts = { animate = true, timeout = 1500, title = "Input Handler to Function Argument" }

    if not state_messages_both_empty then
      if not input then
        _call_async_notifier({
          message = "Operation has been cancelled. Passed parameter is empty.",
          level = vim.log.levels.WARN,
          opts = _notifier_opts
        })
        return
      end
    end
    -- Execute the function along with the input with pcall() in place.
    local _is_success, _err = pcall(function() ctx.fn_reference(input) end)

    -- Then call a notifier in async.
    if not state_messages_both_empty then
      _call_async_notifier({
        message = _is_success and ctx.message_success or ctx.message_failed .. " | Error Code: " .. _err,
        level = _is_success and vim.log.levels.INFO or vim.log.levels.ERROR,
        opts = _notifier_opts
      })
    end
  end)
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
      return error(
        "`level` parameter contains an invalid level (integer from `vim.logs.levels`), please pass a proper context.")
    end
  end

  if ctx.message ~= nil then
    if type(ctx.message) ~= "string" then
      return error("`message` is not a valid string, please pass a proper context.")
    end
  end

  if type(ctx.opts) ~= "table" then
    return error("Passed contents to variable `opts` at function `F.NotifyAfterExecution` is not a table! Received: ")
  end

  -- Call the `cmd` or the function given from the `cmd`.
  if is_cmd_a_function then ctx.cmd() else vim.cmd(ctx.cmd) end

  -- Then call `notify` in async.
  if ctx.message then
    _call_async_notifier({ message = ctx.message, level = ctx.level or vim.log.levels.INFO, opts = ctx.opts or {} })
  end
end

return F
