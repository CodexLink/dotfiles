---@module 'plugins'
---@author CodexLink <https://github.com/CodexLink>
---@license Apache-2.0

-- Script variables
local v = vim
local vfn = v.fn
local lazy_path = vfn.stdpath("data") .. "/lazy/lazy.nvim"; -- Add the string if we have custom path.

if (not v.loop.fs_stat(lazy_path)) then
  vfn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazy_path })
end

-- Add lazy path to the runtime path in prepend, instead of append.
v.opt.rtp:prepend(lazy_path)

-- Package manager configuration
require("lazy").setup("plugin-specs", {})
