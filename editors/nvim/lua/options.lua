-- options.lua   | Contains all 'set' commands which was called via 'vim.o'.
-- @CodexLink    | https://github.com/CodexLink

-- Info
-- [1] Options that were set to 'true' or when a setting has default value set to true were not included in this file!

local vo = vim.o

vo.cursorline = true
vo.clipboard = "unnamedplus"
vo.mousemoveevent = true
vo.number = true
vo.shiftwidth = 2
vo.showmatch = true
vo.tabstop = 2
vo.termguicolors = true
vo.syntax = "on"
