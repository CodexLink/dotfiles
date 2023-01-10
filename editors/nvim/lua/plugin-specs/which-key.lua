-- which-key.nvim	 | Plugin spec for the 'which-key', used for the package manager lazy.nvim"
-- Version 0.1.0 | Since 01/10/2023
-- @CodexLink    | https://github.com/CodexLink

return {
    "folke/which-key.nvim",
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({
				-- !!! TODO
			})
    end,
  }
