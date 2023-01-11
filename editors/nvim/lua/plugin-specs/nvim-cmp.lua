-- nvim-cmp.lua | Plugin spec for the 'nvim-cmp' and it's friends (that provides snippets, autocompletion, advertisement of suggestion from the server, etc), used for the package manager lazy.nvim"
-- Version 0.1.0  | Since 01/11/2023
-- @CodexLink     | https://github.com/CodexLink

-- Info
-- [1] Configuration for the LSP servers or the configurator is separated, the context of this plugin spec is all about advertising the completion plugin to the LSP to display at the editor.

return {
	"hrsh7th/nvim-cmp",
	build = function()
		-- Install dependencies.
		vim.cmd("silent !npm install -g cssmodules-language-server dockerfile-language-server-nodejs vscode-langservers-extracted graphql-language-service-cli vscode-html-language-server typescript typescript-language-server")
	end,
	config = function()
		-- Instantiations
		local cmp = require("cmp")
		local lspconfig = require("lspconfig")

		cmp.setup({
			sources = {
				{
					name = "buffer",
					option = {
						keyword_length = 1,
					}
				},
				{
					name = "nvim_lsp"
				},
				{
					name = "luasnip",
					option = {
						show_autosnippets = true
					}
				},
				{
					name = "path"
				}
			},
			snippet = {
				expand = function(args)
					cmp.lsp_expand(args.body)
				end
			}
		})

		-- Setup keybinds, specifically required by `lspconfig`.
		-- TODO: Customize this later, I cannot right now due to absurd amount of plugins for me to change.
		-- !!! This was copied from the `nvim-lspconfig`.

		local opts = { noremap = true, silent = true }
		vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
		vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
		vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
		vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

		-- Use an on_attach function to only map the following keys
		-- after the language server attaches to the current buffer
		local on_attach = function(client, bufnr)
			-- Enable completion triggered by <c-x><c-o>
			vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

			-- Mappings.
			-- See `:help vim.lsp.*` for documentation on any of the below functions
			local bufopts = { noremap=true, silent=true, buffer=bufnr }
			vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
			vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
			vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
			vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
			vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
			vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
			vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
			vim.keymap.set('n', '<space>wl', function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, bufopts)
			vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
			vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
			vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
			vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
			vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
		end

		-- Setup the LSP Config.
		local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

		local html_json_capabilities = vim.lsp.protocol.make_client_capabilities()
		html_json_capabilities.textDocument.completion.completionItem.snippetSupport = true

		lspconfig["cssmodules_ls"].setup({
			capabilities = lsp_capabilities,
			on_attach = on_attach
		})

		lspconfig["dockerls"].setup({
			capabilities = lsp_capabilities,
			on_attach = on_attach
		})

		lspconfig["eslint"].setup({
			capabilities = lsp_capabilities,
			on_attach = on_attach
		})

		lspconfig["graphql"].setup({
			capabilities = lsp_capabilities,
			on_attach = on_attach
		})
		
		lspconfig["html"].setup({
			capabilities = html_json_capabilities,
			on_attach = on_attach
		})

		lspconfig["jsonls"].setup({
			capabilities = html_json_capabilities,
			on_attach = on_attach
		})

		lspconfig["luau_lsp"].setup({
			capabilities = lsp_capabilities,
			on_attach = on_attach
		})

		lspconfig["pyright"].setup({
			capabilities = lsp_capabilities,
			on_attach = on_attach
		})

		lspconfig["tsserver"].setup({
			capabilities = lsp_capabilities,
			on_attach = on_attach
		})

	end,
	dependencies = {
		{ "neovim/nvim-lspconfig" },
		{ "hrsh7th/cmp-buffer" },
		{ "hrsh7th/cmp-nvim-lsp" },
		{ "hrsh7th/cmp-path" },
		{ "L3MON4D3/LuaSnip" },
		{ "rafamadriz/friendly-snippets" },
		{ "saadparwaiz1/cmp_luasnip" },
	},
	lazy = false,
}
