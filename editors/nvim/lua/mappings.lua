-- mappings.lua  | Literally anything mapping, specially keybinds and other suchs.
-- @CodexLink    | https://github.com/CodexLink

local vg = vim.g
local vkm = vim.keymap

vg.mapleader = "\\"

vkm.set("n", "<Home>", "<cmd>Lazy<cr>", { desc = "Open Lazy Window" })
