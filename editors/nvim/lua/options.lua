-- options.lua   | Contains all 'set' commands which was called via 'vim.o' and any other commands or binds that is required to be declared early before the plugin manager.
-- @CodexLink    | https://github.com/CodexLink

-- Info
-- * Options that were set to 'true' or when a setting has default value set to true were not included in this file!
-- [1] Keybind for the `<Leader>` has to be declared early to ensure that the `mappings` will work and is recognized by the plugin manager.
-- [2] Declared context is a required configuration for the `which-key.nvim`.

local vo = vim.o
local vg = vim.g

vo.cursorline = true
vo.clipboard = "unnamedplus"
vo.mousemoveevent = true
vo.number = true
vo.shiftwidth = 2
vo.showmatch = true
vo.tabstop = 2
vo.termguicolors = true
vo.syntax = "on"

vg.mapleader = "\\" -- [1]

vo.timeout = true		-- [2]
vo.timeoutlen = 300 -- [2]
