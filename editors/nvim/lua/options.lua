-- options.lua   | Contains all 'set' commands which was called via 'vim.o' and any other commands or binds that is required to be declared early before the plugin manager.
-- @CodexLink    | https://github.com/CodexLink

-- Info
-- * Options that were set to 'true' or when a setting has default value set to true were not included in this file!
-- [1] Keybind for the `<Leader>` has to be declared early to ensure that the `mappings` will work and is recognized by the plugin manager.
-- [2] Declared context is a required configuration for the `which-key.nvim`.
-- [3] This configuration might be working, or not, this does not work on my configuration as I use `Windows Terminal` + `pwsh` which is extremely annoying, I tried changing the highlight `TermCursor` but it doesn't change it.

local vo = vim.opt
local vg = vim.g

vo.cursorline = true
vo.clipboard = "unnamedplus"
vo.guicursor = "n-v:block-CursorToNavigation,i-ci-ve:ver50-CursorToInsertion,r-c-cr-o:hor50-CursorToReplacement,a:blinkwait50-blinkoff25-blinkon25-CursorToNavigation,sm:ver50-CursorToNavigation-blinkwait25-blinkoff50-blinkon50" -- [3]
vo.number = true
vo.shiftwidth = 2
vo.showmatch = true
vo.tabstop = 2
vo.termguicolors = true
vo.syntax = "on"
vo.timeout = true -- [2]
vo.timeoutlen = 300 -- [2]
vg.mapleader = "\\" -- [1]
