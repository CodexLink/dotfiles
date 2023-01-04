-- plugins.lua   | Plugins with "lazy.nvim" as a package manager
-- Version 0.1.1 | Since 01/04/2023
-- @CodexLink    | https://github.com/CodexLink
-- Description: This lua file contains initializer of plugins (as well as its declaration) with `lazy.nvim`.

-- User-customizable
-- When your `lazy` is installed elsewhere, add the path here.
-- Please note that shell-specific environment variable identifier may not be parsed (as for what I know).
local customPath = nil;

-- Script variables
local _lazy_path = nil;
local v = vim
local vfn = v.fn

-- Modified version of "https://github.com/wbthomason/packer.nvim#bootstrapping"
local _construct_lazy_path = function (overriden_path)
	-- Check if `overriden_path` is given.
	if (not overriden_path) then
		-- Otherwise, check if is a string.
		if (type(overriden_path) != "string") then
			print("Provided parameter `overriden_path` is not a valid string as path.")
			os.exit(1)
		end
		-- If provided, assign given path to `_lazy_path`.
		_lazy_path = overriden_path
	end

	-- Setup the default path by `nvim` itself if `_lazy_path` is not already influenced by `overidden_path`.
	if (not _lazy_path) then
		_lazy_path = vfn.stdpath("data") .. "/lazy/lazy.nvim"
	end

	return true
end

-- "check_or_install_lazy" is a function that either clones or upstreams the locally-saved `packer.nvim`.
local check_or_install_lazy = function(customPath)
	_construct_lazy_path(customPath)

	-- Check if the directory and its contents exist.
	if (not v.loop.fs_stats(_construct_lazy_path)) then
		vfn.system({
			"git",
			"clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
			_lazy_path
		})
	end

	-- Add lazy path to the runtime path in prepend, instead of append.
	v.opt.rtp:prepend(lazypath)
	return nil
end

-- Run this function to self-clone or update the packer.
check_or_install_lazy(customPath)

-- We have no way to check whether packer is installed, with that, run require with checks.
local instantiated, lazy = pcall(require, "lazy")

if not instantiated then
	print("Packer was not installed! Please check the folder location and try again.")
	os.exit(1)
end

-- Package manager configuration
lazy.setup(
	opts = {
		checker = {
			concurrency = 10,
			enabled = true,
			frequency = 86400, -- Check every 24 hours instead.
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
			colorscheme = { "" },
			missing = true
		},
		performance = {
			cache = {
				enabled = true,
			}
		},
		ui = {
			browser = nil, -- To be fixed later.
			custom_keys = {
			},
			throttle = 30,
		},
	},
	plugins = {
		-- Important, 2nd-Level Module Cacher
		{
			"lewis6991/impatient.nvim",
			config = function() require("impatient") end
		},

		-- Semi-Important, Colorscheme
		{},

		-- Extras: Tracking
		{
			-- This uses the forked version which fixes the languages.lua missing comma.
			-- NOTE: This plugin requires `CODESTATS_API_KEY` from your Environment Variables!
			"NTBBloodbath/codestats.nvim",
			pin = true,
		},
		{ "wakatime/vim-wakatime" },
		-- Extras
		{
			"andweeb/presence.nvim",
			event = "VeryLazy"
		}, -- TODO

		-- Language Support and Highlighting
		{
			-- !!! Note: Used to undertand the file, not an alternative to LSP.
 			-- * This was based on `https://github.com/rafamadriz/dotfiles/commit/c1268c73bdc7da52af0d57dcbca196ca3cb5ed79`
			"nvim-treesitter/nvim-treesitter",
			build = function() require("nvim-treesitter.install").update({ with_sync = true }) end,
			config = function() require("configs.treesitter") end
		},

		-- Typing
		{
			"windwp/nvim-autopairs",
			config = function() require("configs.autopairs") end
		},
		{
		"numToStr/Comment.nvim",
		-- ! No need to modify the keybinds, therefore instantiate the module without further configurations.
		config = function() require("Comment").setup {} end
		},

		-- UI (Display, Helpers, Wrappers)
		{ -- TODO May need further customization.
			"akinsho/bufferline.nvim",
			tag = "v3.*",
			config = function() require("bufferline").setup {} end
		},
		{
			"lukas-reineke/indent-blankline.nvim",
			config = function() require("configs.indent-blankline") end
		},
		{
			"nvim-lualine/lualine.nvim",
			config = function() require("configs.lualine") end
		},
		{
			"norcalli/nvim-colorizer.lua",
			config = function() require("colorizer").config {} end,
		},
		{
			"nvim-telescope/telescope.nvim",
			branch = "0.1.x",
			config = function() require("configs.telescope") end,
			requires = {
				{ "nvim-lua/plenary.nvim", lazy = false },
				{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
				{ "nvim-telescope/telescope-ui-select.nvim" }
			}
		},
		{
			"nvim-tree/nvim-web-devicons",
			config = function() require("configs.web-devicons") end
		},
		{
			"sidebar-nvim/sidebar.nvim",
			config = function() require("configs.sidebar") end
			dependencies = {
				{ "sidebar-nvim/sections-dap.nvim", lazy = false }
			}
		},
		{
			"sindrets/diffview.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim"
			}
		}
	}
)
