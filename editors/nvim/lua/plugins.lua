-- plugins.lua   | Plugins with "lazy.nvim" as a package manager
-- @CodexLink    | https://github.com/CodexLink
-- Description: This lua file necessary configuration for the package manager "lazy.nvim".

-- Script variables
local _lazy_path = nil; -- Add the string if we have custom path.
local v = vim
local vfn = v.fn

-- Modified version of "https://github.com/wbthomason/packer.nvim#bootstrapping"
local _construct_lazy_path = function()
    -- Check if `_lazy_path` is given.
    if (_lazy_path ~= nil) then
        -- Otherwise, check if is a string.
        if (type(_lazy_path) ~= "string") then
            error("Provided parameter `_lazy_path` is not a valid string as path.")
            os.exit(1)
        end
    else
	-- Setup the default path by `nvim` itself if `_lazy_path` is not already influenced by `overidden_path`.
        _lazy_path = vfn.stdpath("data") .. "/lazy/lazy.nvim"
    end
    return true
end

-- "update_or_prep_lazy" is a function that either clones or upstreams the locally-saved `packer.nvim`.
local update_or_prep_lazy = function()
    -- Evaluate the lazy path first before operation.
    _construct_lazy_path()

    -- Check if the directory and its contents exist.
    if (not v.loop.fs_stat(_lazy_path)) then
        vfn.system({"git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable",
                    _lazy_path})
    end

    -- Add lazy path to the runtime path in prepend, instead of append.
    v.opt.rtp:prepend(_lazy_path)
    return nil
end

-- Run this function to self-clone or update the packer.
update_or_prep_lazy()

-- Load the packager and check whether it was really installed or not.
local instantiated, lazy = pcall(require, "lazy")

if not instantiated then
    error("Lazy was not installed! Please check the folder location and try again.")
    os.exit(1)
end


-- Package manager configuration
-- Signature arguments: (string, table)
lazy.setup("plugin-specs", {
    checker = {
        concurrency = 10,
        enabled = true,
        frequency = 86400 -- Check every 24 hours instead.
    },
    concurrency = 5,
    defaults = {
        lazy = true,
        version = "*"
    },
    diff = {
        cmd = "diffview.nvim"
    },
    performance = {
        cache = {
            enabled = true
        }
    },
    ui = {
        browser = nil, -- To be fixed later.
        throttle = 30
    }
})
