---@module 'options'
---@author CodexLink <https://github.com/CodexLink>
---@license Apache-2.0
-- @info * Options that were set to 'true' or when a setting has default value set to true were not included in this file!
-- @info [1] Keybind for the `<Leader>` has to be declared early to ensure that the `mappings` will work and is recognized by the plugin manager.
-- @info [2] Declared context is a required configuration for the `which-key.nvim`.
-- @info [3] This configuration might be working, or not, this does not work on my configuration as I use `Windows Terminal` + `pwsh` which is extremely annoying, I tried changing the highlight `TermCursor` but it doesn't change it.

local vo = vim.opt
local vg = vim.g

vo.cursorline = true
vo.expandtab = true
vo.hlsearch = false
vo.guicursor =
"n-v:block-CursorToNavigation,i-ci-ve:ver50-CursorToInsertion,r-c-cr-o:hor50-CursorToReplacement,a:blinkwait50-blinkoff25-blinkon25-CursorToNavigation,sm:ver50-CursorToNavigation-blinkwait25-blinkoff50-blinkon50" -- [3]
vo.number = true
vg.mapleader =
"\\" -- [1]
vo.smartindent = true
vo.shiftwidth = 2
vo.showmatch = true
vo.softtabstop = 2
vo.tabstop = 2
vo.termguicolors = true
vo.shortmess = "I"
vo.syntax = "on"
vo.shell = "pwsh"
vim.o.shellcmdflag =
'-NoLogo -NoProfile -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
vim.o.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
vim.o.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
vim.o.shellquote = ''
vim.o.shellxquote = ''
vo.timeout = true   -- [2]
vo.timeoutlen = 300 -- [2]
vo.updatetime = 50
