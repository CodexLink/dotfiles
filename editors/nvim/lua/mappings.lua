-- mappings.lua  | Literally anything mapping, specially keybinds and other suchs.
-- @CodexLink    | https://github.com/CodexLink

-- Info
-- [1] Some keybinds require using string instead of encapsulated [[]] context. This may be due to special handling after executing the function.
local vkm = vim.keymap

local bind_opts = { noremap = true, silent = true }

-- !!! General keybinds to display UI.
-- TODO: M-3 is reserved for DAP.
vkm.set("n", "<F1>", [[ <CMD>Neotree action=show position=left reveal=true toggle=true<CR> ]], { desc = "neotree.nvim: Toggle.", unpack(bind_opts) })
vkm.set("n", "<F2>", [[ <CMD>TroubleToggle<CR> ]], { desc = "trouble.nvim (Diagnostics): Toggle.", unpack(bind_opts) }),
vkm.set("n", "<F4>", [[ <CMD>WhichKey<CR> ]], { desc = "which-key.nvim: Opens UI window for hinting keybinds.", unpack(bind_opts) })
vkm.set("n", "<F5>", [[ <CMD>Lazy<CR> ]], { desc = "lazy.nvim: Opens UI window.", unpack(bind_opts) })
vkm.set("n", "<F6>", [[ <CMD>Mason<CR> ]], { desc = "mason.nvim: Opens UI window.", unpack(bind_opts) })

-- Bufferline-related keybinds.
vkm.set("n", "<M-<>", [[ <CMD>BufferLineCyclePrev<CR> ]], { desc = "bufferline: Move to Previous Buffer.", unpack(bind_opts) })
vkm.set("n", "<M->>", [[ <CMD>BufferLineCycleNext<CR> ]], { desc = "bufferline: Move to Next Buffer.", unpack(bind_opts) })
vkm.set("n", "<M-W>", "<CMD>BufferLinePickClose<CR>", { desc = "bufferline: Pick a buffer to close.", unpack(bind_opts) }) -- [1]
vkm.set("n", "<Leader>|", "<CMD>BufferLinePick<CR>", { desc = "bufferline: Pick a buffer to display.", unpack(bind_opts) }) -- [1]
vkm.set("n", "<S-Right>", [[ <CMD>BufferLineMoveNext<CR> ]], { desc = "bufferline: Move Buffer to the Right.", unpack(bind_opts) })
vkm.set("n", "<S-Left>", [[ <CMD>BufferLineMovePrev<CR> ]], { desc = "bufferline: Move Buffer to the Left.", unpack(bind_opts) })


		-- [[ 	{ "<C-G>h", [[ <CMD>Gitsigns preview_hunk<CR> ]], desc = "gitsigns.nvim: Preview hunk (changes on certain code line)." },
		-- [[ { "<C-G>b", [[ <CMD>Gitsigns toggle_current_line_blame<CR> ]], desc = "gitsigns.nvim: Toggle line blame." },
		-- { "<C-G>d", [[ <CMD>Gitsigns diffthis<CR> ]], desc = "gitsigns.nvim: Activate 'diffthis' on current line." },
		-- { "<C-G>D", function() require("gitsigns").diffthis("~") end, desc = "gitsigns.nvim: Activate `diffthis` on whole file." }


			-- { "<C-W>m", [[ <CMD>WindowsMaximize ]], desc = "windows.nvim: Maximize the focused window." },
			--  { "<C-W>|", [[ <CMD>WindowsMaximizeVertically<CR> ]], desc = "windows.nvim: Maximize vertical side of the focused window." },
			-- { "<C-W>-", [[ <CMD>WindowsMaximizeHorizontally<CR> ]], desc = "windows.nvim: Maximize horizontal side of the focused window." },
			-- { "<C-W>=", [[ <CMD>WindowsEqualize<CR> ]], desc = "windows.nvim: Equalize all windows." }
			--
	
			-- { "<S-F2>", ":IncRename ", desc = "inc-rename.nvim: Incremental renaming by typing the name." },
			-- { "<F2>", function() return ":IncRename " .. vim.fn.expand("<CWORD>") end, desc = "inc-rename.nvim: Incremental renaming by typing the name.", { expr = true }},
			--
			--
			-- { "<leader>mp", [[ <CMD>MarkdownPreview<CR> ]], desc = "markdown-preview.nvim: Activate." },
			-- { "<leader>mP", [[ <CMD>MarkdownPreviewToggle<CR> ]], desc = "markdown-preview.nvim: Toogle." },
			-- { "<leader>mS", [[ <CMD>MarkdownPreviewStop<CR> ]], desc = "markdown-preview.nvim: Deactivate." }
			-- { "<Leader>ag", [[ <CMD>lua require("neogen").generate()<CR> ]],  desc= "neogen: Annotate code context.", { noremap = true, silent = true } }
			--
			--
			-- { "<Leader>th", function() require("tsht").nodes() end, desc = "nvim-treehopper: Toggle context to hoppable." },
			--
			-- { "<leader>SR", function () require("ssr").open() end, mode={ "n", "x" }, desc = "ssr.nvim: Do 'Structural Search and Replace'." },
			--
			-- { "<M->t", [[ <CMD>TSJToggle<CR> ]], desc = "treesj: Toggle 'One-Liner or Splitted Context' Code." },
			-- {"<Leader>Tce", "<CMD>TSContextEnable<CR>", desc = "Enable `treesitter-context`."},
			-- {"<Leader>Tcd", "<CMD>TSContextDisable<CR>", desc = "Disable `treesitter-context`."},
			-- {"<Leader>Tct", "<CMD>TSContextToggle<CR>", desc = "Toggle `treesitter-context`."}
			--
			--
						-- Setup keybinds, specifically required by `lspconfig`.
			-- TODO: Customize this later, I cannot right now due to absurd amount of plugins for me to change.
			-- !!! This was copied from the `nvim-lspconfig`.
--[[ 
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
			end ]]
