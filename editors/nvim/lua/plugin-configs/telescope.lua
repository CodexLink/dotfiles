-- telescope.lua | Plugin spec for the 'telescope' and its friends, used for the package manager lazy.nvim"
-- Version 0.1.0  | Since 01/05/2023
-- @CodexLink     | https://github.com/CodexLink
-- References: https://github.com/nvim-telescope/telescope.nvim#usage
return {
	 "nvim-telescope/telescope.nvim",
        branch = "0.1.x",
	lazy = true,
	config = {
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
	},
	dependencies = {{
            "nvim-lua/plenary.nvim",
            lazy = false
        }, {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make"
        }, {"nvim-telescope/telescope-ui-select.nvim"}}
}

-- Load extensions.
local instantiated, tls_configurator = pcall(require, "telescope")
if not instantiated then
	print("Plugin configuration for `telescope` has failed to load. The module itself may not be installed properly.")
end

tfzf_configurator.load_extension("fzf")       -- nvim-telescope/telescope-ui-select.nvim
tfzf_configurator.load_extension("ui-select") -- nvim-telescope/telescope-ui-select.nvim
