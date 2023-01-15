-- mappings.lua  | Literally anything mapping, specially keybinds and other suchs.
-- @CodexLink    | https://github.com/CodexLink

-- Info
-- [1] Some keybinds require using string instead of encapsulated [[]] context. This may be due to special handling after executing the function.
local vg = vim.g
local vkm = vim.keymap

local bind_opts = { noremap = true, silent = true }
vg.mapleader = "\\"

-- !!! General keybinds to display UI.
vkm.set("n", "<Home>", [[ <CMD>Lazy<CR> ]], { desc = "Open 'Lazy' Window", unpack(bind_opts) })
vkm.set("n", "<F12>", [[ <CMD>WhichKey<CR> ]], { desc = "Trigger 'which-key'.", unpack(bind_opts) })

-- Bufferline-related keybinds.
vkm.set("n", "<M-<>", [[ <CMD>BufferLineCyclePrev<CR> ]], { desc = "bufferline: Move to Previous Buffer.", unpack(bind_opts) })
vkm.set("n", "<M->>", [[ <CMD>BufferLineCycleNext<CR> ]], { desc = "bufferline: Move to Next Buffer.", unpack(bind_opts) })
vkm.set("n", "<M-W>", "<CMD>BufferLinePickClose<CR>", { desc = "bufferline: Pick a buffer to close.", unpack(bind_opts) }) -- [1]
vkm.set("n", "<Leader>|", "<CMD>BufferLinePick<CR>", { desc = "bufferline: Pick a buffer to display.", unpack(bind_opts) }) -- [1]
vkm.set("n", "<S-Right>", [[ <CMD>BufferLineMoveNext<CR> ]], { desc = "bufferline: Move Buffer to the Right.", unpack(bind_opts) })
vkm.set("n", "<S-Left>", [[ <CMD>BufferLineMovePrev<CR> ]], { desc = "bufferline: Move Buffer to the Left.", unpack(bind_opts) })

