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
			local cmp_types = require("cmp.types")
			local lspconfig = require("lspconfig")
			local luasnip = require("luasnip")
			local null_ls = require("null-ls")

			-- ! This function is provided from the advanced configuration of `nvim-cmp`.
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
			end

			-- * Setup for the completion.
			cmp.setup({
				completion = {
					keyword_length = 1
				},
				experimental = {
					ghost_text = true
				},
			  formatting = {
					expandable_indicator = true,
					fields = { "kind", "abbr", "menu" },
					format = function(entry, vim_item)
						local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
						local strings = vim.split(kind.kind, "%s", { trimempty = true })
						kind.kind = " " .. (strings[1] or "") .. " "
						kind.menu = "    (" .. (strings[2] or "") .. ")"

						return kind
					end,
				},
				mapping = {
					["<Down>"] = {
						i = cmp.mapping.select_next_item({ behavior = cmp_types.cmp.SelectBehavior.Select }),
					},
					["<Up>"] = {
						i = cmp.mapping.select_prev_item({ behavior = cmp_types.cmp.SelectBehavior.Select }),
					},
					["<C-c>"] = cmp.mapping.complete(),
					["<C-C>"] = cmp.mapping.confirm({ select = true }),
					["<C-a>"] = cmp.mapping.abort(),
					["<M-q>"] = cmp.mapping.scroll_docs(-3),
					["<M-e>"] = cmp.mapping.scroll_docs(3),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_locally_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},
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
				},
			  window = {
					completion = {
						winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
						bordered = true
					},
					documentation = cmp.config.window.bordered()
				},
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

			-- Setup keybinds, specifically required by `lspconfig`.
			-- NOTE: I cannot bind these keybinds on "which-key" that is due to lspconfig requiring to bind these to every lsp, which was then wrapped as a function to be passed on the argument "on_attach".
			-- TODO: Customize this later, I cannot right now due to absurd amount of plugins for me to change.

			local opts = { noremap = true, silent = true }

			vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
			vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
			vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
			vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

			-- Use an on_attach function to only map the following keys
			-- after the language server attaches to the current buffer
			local on_attach = function(_, bufnr)
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
						diagnostics = {
							globals = { "vim" }
						},
						runtime = {
							version = "Lua 5.4"
						},
						telemetry = {
							enable = true
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
			{ "jose-elias-alvarez/null-ls.nvim", dependencies = { "nvim-lua/plenary.nvim" } }, -- For the Code Actions, Formatters and Linters.
			{ "jay-babu/mason-null-ls.nvim" }, -- Declared before the dependant.
			-- * Completion plugins
			{ "hrsh7th/cmp-buffer" },
			{ "hrsh7th/cmp-nvim-lsp" },
			{ "hrsh7th/cmp-path" },
			{ "onsails/lspkind.nvim" },
			{ "L3MON4D3/LuaSnip" },
			{ "rafamadriz/friendly-snippets" },
			{ "saadparwaiz1/cmp_luasnip" },
		},
		lazy = false,
	}
}
