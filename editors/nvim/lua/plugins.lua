-- plugins.lua   | Plugins with packer.nvim as Plugin Initializer
-- Version 0.1.0 | Since 11/01/2022
-- @CodexLink    | https://github.com/CodexLink
-- Description: This lua file contains initializer of plugins (as well as its declaration) with `packer.nvim`.

-- User-customizable
-- When your `packer` is installed elsewhere, add the path here.
-- Please note that shell-specific environment variable identifier may not be parsed (as for what I know).
local customPath = nil;

-- Script variables
local _packer_path = nil;
local packer_cloned = false;
local v = vim
local vfn = v.fn

-- Modified version of "https://github.com/wbthomason/packer.nvim#bootstrapping"
local _construct_packer_path = function (overriden_path)
	-- Check if `overriden_path` is given.
	if not overriden_path then
		-- Otherwise, check if is a string.
		if type(overriden_path) != "string" then
			error("Provided parameter `overriden_path` is not a valid string as path.")
			return false
		end
		-- If provided, assign given path to `_packer_path`.
		_packer_path = overriden_path
	end

	-- Setup the default path by `nvim` itself if `_packer_path` is not already influenced by `overidden_path`.
	if not _packer_path then
		_packer_path = vfn.stdpath('data') .. '/site/pack/loader/start/packer.nvim/plugin/packer.lua'
	end

	return true
end

-- `_upstream_packer` is a function that allows for an existing `packer.nvim` to update itself as possible.
local _upstream_packer = function()
		vfn.chdir(_packer_path)
		vfn.system({
			'git',
			'pull',
		})
end

-- 'check_packer' is a function that either clones or upstreams the locally-saved `packer.nvim`.
local check_packer = function()
	if (not _construct_packer_path) then
		return nil
		--
	-- Check if the directory and its contents exist.
	if vfn.empty(vfn.glob(install_path)) > 0 then
    fn.system({
			'git',
			'clone',
			'--depth',
			'1',
			'https://github.com/wbthomason/packer.nvim',
			_packer_path
		})

		packer_cloned = true
	else
		-- This assumes that the directory has contents, with that, just update the repository.
		_upstream_packer()
	end

	v.cmd [[packadd packer.nvim]]
	return nil
end

-- Run this function to self-clone or update the packer.
check_packer(customPath)

-- We have no way to check whether packer is installed, with that, run require with checks.
local instantiated, packer = pcall(require, "packer")

if not instantiated then
	error("Packer was not installed! Please check the folder location and try again.")
end

packer.startup(
	function(use)
		-- Packer itself
		use 'wbthomason/packer.nvim'

		-- Extras
		use 'andweeb/presence.nvim' -- TODO
		-- Extras: Tracking
		use { -- NOTE: This plugin requires `CODESTATS_API_KEY` from your Environment Variable!
			'YannickFricke/codestats.nvim',
			rocks = "lunajson",
			config = function() require('codestats-nvim').setup() end,
			requires = {{'nvim-lua/plenary.nvim'}}
		}
		use 'wakatime/vim-wakatime'

		-- Language Support and Highlighting
		use {
			'nvim-treesitter/nvim-treesitter', -- Note: Used to undertand the file, not an alternative to LSP.

				-- This was based on `https://github.com/rafamadriz/dotfiles/commit/c1268c73bdc7da52af0d57dcbca196ca3cb5ed79`
      run = function() require("nvim-treesitter.install").update({ with_sync = true }) end,
      config = function() require("configs.treesitter") end
		}

		-- Typing
	use {
		"windwp/nvim-autopairs",
    config = function() require("configs.autopairs") end
	}
		
		-- UI (Helpers Included)
		use 'norcalli/nvim-colorizer.lua',
		use {
			'lukas-reineke/indent-blankline.nvim',
			config = function() require("configs.indent-blankline") end
		},
		use {
			'nvim-tree/nvim-web-devicons',
			config = function() require("configs.web-devicons") end
		}
		
		-- Utilities
		use { -- TODO: Ensure that we can install the node.js app from this module.
			"iamcco/markdown-preview.nvim"
			run = "cd app && npm install",
			setup = function() vim.g.mkdp_filetypes = { "markdown" } end,
			ft = { "markdown" }
		}

		-- When cloned for the first time, ensure to sync all plugins added.
		 if packer_cloned then
			packer.sync()
		 end
	end,
	config = {
		display = {
			open_fn = require('packer.util').float({ border = 'single' }),
		}
	}
)
