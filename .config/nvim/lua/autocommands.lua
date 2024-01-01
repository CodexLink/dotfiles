---@module 'autocommands'
---@author CodexLink <https://github.com/CodexLink>
---@license Apache-2.0

-- Highlight yank for a short time period.
vim.api.nvim_create_autocmd("TextYankPost",
  {
    callback = function()
      vim.highlight.on_yank({ higroup = "HighlightedYank", timeout = 1250 })
    end
  }
)

vim.api.nvim_create_autocmd({ "InsertLeave" },
  {
    callback = function()
      local ok, l = pcall(require, "lint")
      if ok then l.try_lint() end
    end
  })
