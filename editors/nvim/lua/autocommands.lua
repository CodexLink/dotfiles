---@module 'autocommands'
---@author CodexLink <https://github.com/CodexLink>
---@license Apache-2.0

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

-- My own custom events, used to trigger some components without the need of triggering other plugins that depends on it.
local custom_event = vim.api.nvim_create_augroup("CodexGroup", { clear = true })

vim.api.nvim_create_autocmd("User",
  { pattern = "ForceLSPWakeup", callback = function() vim.notify_once("LSP Wakeup initiated!", vim.log.levels.WARN) end,
    group = custom_event })
