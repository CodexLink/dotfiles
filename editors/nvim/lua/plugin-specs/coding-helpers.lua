-- coding-helpers.lua | Plugin declaration for that provides snippets, autocompletion, advertisement of suggestion from the server, etc), used for the package manager lazy.nvim"
-- @CodexLink     | https://github.com/CodexLink

-- Info
-- [1] Configuration for the LSP servers or the configurator is separated, the context of this plugin spec is all about advertising the completion plugin to the LSP to display at the editor.

return {
	{
		-- !!! Dependants from the external package were done by `mason.nvim` and `null-ls.nvim`.
		"hrsh7th/nvim-cmp",
		config = function()
			-- Instantiations
			local cmp = require("cmp")
			local lspconfig = require("lspconfig")
			local null_ls = require("null-ls")

			-- * Setup for the completion.
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

			-- * Setup for the external tool pakage manager.
			require("mason").setup({ pip = { upgrade_pip = true }, max_concurrent_installers = 10 })

			-- * Setup for the package manager connector for the `lspconfig`.
			-- !!! null-ls will be used for the DAPs, Linters, and Formatters.
			require("mason-lspconfig").setup({
				ensure_installed = {
					"cssmodules_ls",
					"dockerls",
					"eslint",
					"graphql",
					"html",
					"jsonls",
					"marksman",
					"pyright",
					"sqlls",
					"sumneko_lua",
					"svelte",
					"tailwindcss",
					"tsserver",
					"volar",
					"yamlls",
				},
				automatic_installation = true
			})

			null_ls.setup({
				sources = {
					-- * Formatters
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.clang_format,
					null_ls.builtins.diagnostics.cppcheck,
					null_ls.builtins.formatting.fixjson,
					null_ls.builtins.formatting.isort,
					null_ls.builtins.formatting.lua_format,
					null_ls.builtins.formatting.prettierd,
					null_ls.builtins.formatting.remark,
					null_ls.builtins.formatting.reorder_python_imports,
					null_ls.builtins.formatting.sql_formatter,
					-- * Linters
					null_ls.builtins.diagnostics.cpplint,
					null_ls.builtins.formatting.eslint_d,
					null_ls.builtins.formatting.markdownlint,
					null_ls.builtins.diagnostics.mypy
				}
			})

			-- ! Setup the code actions, formatters and linters via `null-ls`.
			-- Note that we have to use the packages that is namespaced by `null-ls` to ensure no conflicts during setup.
			require("mason-null-ls").setup({
				ensured_installed = nil,
				automatic_installation = true,
				automatic_setup = true
			})

			-- Require every LSP via lspconfig["lsp_name"].setup({<setup_table>})
			local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

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
				capabilities = lsp_capabilities,
				on_attach = on_attach
			})

			lspconfig["jsonls"].setup({
				capabilities = lsp_capabilities,
				on_attach = on_attach
			})

			lspconfig["marksman"].setup({
				capabilities = lsp_capabilities,
				on_attach = on_attach
			})

			lspconfig["pyright"].setup({
				capabilities = lsp_capabilities,
				on_attach = on_attach
			})

			lspconfig["sqlls"].setup({
				capabilities = lsp_capabilities,
				on_attach = on_attach
			})

			lspconfig["sumneko_lua"].setup({
				capabilities = lsp_capabilities,
				on_attach = on_attach,
				settings = {
					Lua = {
						telemetry = {
							enable = false
						}
					}
				}
			})

			lspconfig["svelte"].setup({
				capabilities = lsp_capabilities,
				on_attach = on_attach
			})

			lspconfig["tailwindcss"].setup({
				capabilities = lsp_capabilities,
				on_attach = on_attach
			})

			lspconfig["tsserver"].setup({
				capabilities = lsp_capabilities,
				on_attach = on_attach
			})

			lspconfig["volar"].setup({
				capabilities = lsp_capabilities,
				on_attach = on_attach
			})

			lspconfig["yamlls"].setup({
				capabilities = lsp_capabilities,
				on_attach = on_attach
			})

		end,
		dependencies = {
			-- ! A package manager for the external tools, such as: Debug Adapter Protocol (DAP), Linters, Formatters, etc.
			{ "williamboman/mason.nvim" },
			-- Package manager extension as an LSP provider for the "nvim-lspconfig".
			{ "williamboman/mason-lspconfig.nvim" },
			-- ! Primary plugins that is naturally dependant by these extension plugins.
			{ "neovim/nvim-lspconfig" }, -- For the LSP.
			{ "jose-elias-alvarez/null-ls.nvim", dependency = { "nvim-lua/plenary.nvim" } }, -- For the Code Actions, Formatters and Linters.
			{ "jay-babu/mason-null-ls.nvim" }, -- Declared before the dependant.
			-- * Completion plugins
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
			{ "saadparwaiz1/cmp_luasnip" },
		},
		lazy = false,
	}
}
