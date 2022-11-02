-- telescope.lua | Plugin configuration for `nvim-telescope/telescope.nvim` plus extra plugins.
-- Version 0.1.0  | Since 11/02/2022
-- @CodexLink     | https://github.com/CodexLink
-- References: https://github.com/nvim-telescope/telescope.nvim#usage

local instantiated, tls_configurator = pcall(require, "telescope")
if not instantiated then
	print("Plugin configuration for `telescope` has failed to load. The module itself may not be installed properly.")
end

tls_configurator.setup {
  defaults = {
    layout_config = {
      vertical = { width = 0.5 }
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}

-- Load extensions.
tfzf_configurator.load_extension("fzf")       -- nvim-telescope/telescope-ui-select.nvim
tfzf_configurator.load_extension("ui-select") -- nvim-telescope/telescope-ui-select.nvim
