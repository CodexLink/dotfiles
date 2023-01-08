-- options.lua   | Contains all 'set' commands which was called via 'vim.o'.
-- Version 0.1.0 | Since 01/08/2023
-- @CodexLink    | https://github.com/CodexLink

-- Info
-- [1] Options that were set to 'true' or from its default value were not included in this file!

local vo = vim.o

vo.cursorline = true
vo.clipboard = "unnamedplus"
vo.number = true
vo.shiftwidth = 2
vo.showmatch = true
vo.tabstop = 2
vo.termguicolors = true
vo.syntax = "on"
