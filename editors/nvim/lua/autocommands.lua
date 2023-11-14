---@module 'autocommands'
---@author CodexLink <https://github.com/CodexLink>
---@license Apache-2.0

-- Highlight yank for a short time period.
vim.api.nvim_create_autocmd("TextYankPost",
  { callback = function() vim.highlight.on_yank({ higroup = "HighlightedYank", timeout = 1250 }) end }
)

-- My own custom events, used to trigger some components without the need of triggering other plugins that depends on it.
local custom_event = vim.api.nvim_create_augroup("CodexGroup", { clear = true })

vim.api.nvim_create_autocmd("User",
  { pattern = "ForceLSPWakeup", callback = function() vim.notify_once("LSP Wakeup initiated!", vim.log.levels.WARN) end,
    group = custom_event })
