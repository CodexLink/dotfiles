-- hop.nvim.lua | Plugin spec for the "hop.nvim", used for the package manager lazy.nvim"
-- Version 0.1.0  | Since 01/11/2023
-- @CodexLink     | https://github.com/CodexLink

local vk = vim.keymap
return {
	"phaazon/hop.nvim",
	config = function()
		local hop = require("hop")
		local directions = require("hop.hint").HintDirection

		vk.set("", "f", function()
			hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
		end, { remap = true })

		vk.set("", "F", function()
			hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
		end, { remap = true })

		vk.set("", "t", function()
			hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
		end, { remap = true })

		vk.set("", "T", function()
			hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
		end, { remap = true })
	end,
	lazy = false
}
