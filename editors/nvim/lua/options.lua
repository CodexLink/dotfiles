-- options.lua   | Contains all 'set' commands which was called via 'vim.o' and any other commands or binds that is required to be declared early before the plugin manager.
-- @CodexLink    | https://github.com/CodexLink

-- Info
-- Options that were set to 'true' or when a setting has default value set to true were not included in this file!
-- Keybind for the `<Leader>` has to be declared early to ensure that the `mappings` will work.
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

vg.mapleader = "\\"
