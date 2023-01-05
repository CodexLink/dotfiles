-- plugins.lua   | Plugins with "lazy.nvim" as a package manager
-- Version 0.1.1 | Since 01/04/2023
-- @CodexLink    | https://github.com/CodexLink
-- Description: This lua file contains initializer of plugins (as well as its declaration) with `lazy.nvim`.

-- Script variables
local _lazy_path = nil; -- Add the string if we have custom path.
local v = vim
local vfn = v.fn

-- Modified version of "https://github.com/wbthomason/packer.nvim#bootstrapping"
local _construct_lazy_path = function(overriden_path)
    -- Check if `overriden_path` is given.
    if (overriden_path ~= nil) then
        -- Otherwise, check if is a string.
        if (type(overriden_path) ~= "string") then
            error("Provided parameter `overriden_path` is not a valid string as path.")
            os.exit(1)
        end
        _lazy_path = overriden_path
    else
		-- Setup the default path by `nvim` itself if `_lazy_path` is not already influenced by `overidden_path`.
        _lazy_path = vfn.stdpath("data") .. "/lazy/lazy.nvim"
    end
    return true
end

-- "check_or_install_lazy" is a function that either clones or upstreams the locally-saved `packer.nvim`.
local check_or_install_lazy = function(_lazy_path)
    _construct_lazy_path(customPath)

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
check_or_install_lazy(customPath)

-- We have no way to check whether packer is installed, with that, run require with checks.
local instantiated, lazy = pcall(require, "lazy")

if not instantiated then
    error("Lazy was not installed! Please check the folder location and try again.")
    os.exit(1)
end

-- Package manager configuration
-- Signature: plugin(string, table)
lazy.setup("plugin-configs", {
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
    install = {
        colorscheme = {""},
        missing = true
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
