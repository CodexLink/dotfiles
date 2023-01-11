-- neo-tree.lua | Plugin spec for the 'neo-tree', used for the package manager lazy.nvim"
-- Version 0.1.0  | Since 01/11/2023
-- @CodexLink     | https://github.com/CodexLink

return {
	  "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = { 
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
		keys = {
			{"<C-b>", [[ <CMD>NeoTree position=right<CR> ]], { noremap = true, silent = true }}
		},
		lazy = false
}
