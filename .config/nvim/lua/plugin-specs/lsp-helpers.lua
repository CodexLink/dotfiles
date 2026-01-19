---@module 'lsp-helpers'
---@author CodexLink <https://github.com/CodexLink>
---@license Apache-2.0
---@info [1] Configuration for the LSP servers or the configurator is separated, the context of this plugin spec is all about advertising the completion plugin to the LSP to display at the editor.

return {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", build = ":MasonUpdate", cmd = "Mason", config = true },
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "cssmodules_ls",
          "dockerls",
          "eslint",
          "html",
          "jsonls",
          "lua_ls",
          "marksman",
          "pyright",
          "ruff",
          "sqlls",
          "ts_ls",
          "yamlls",
        },
        automatic_installation = false
      })
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function() require("mason-null-ls").setup({ ensure_installed = nil, automatic_installation = false }) end,
    dependencies = {
      "williamboman/mason.nvim",
      {
        "nvimtools/none-ls.nvim",
        dependencies = "nvim-lua/plenary.nvim",
        config = function()
          local nls = require("null-ls")
          nls.setup({
            sources = {
              nls.builtins.completion.luasnip,
              nls.builtins.completion.spell,
              nls.builtins.formatting.markdownlint,
              nls.builtins.formatting.prettierd,
              nls.builtins.formatting.remark,
              nls.builtins.formatting.sql_formatter,
              nls.builtins.formatting.uncrustify,
            }
          })
        end,
      }
    },
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = "rafamadriz/friendly-snippets",
    lazy = true,
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
    end
  },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = "hrsh7th/cmp-nvim-lsp",
    config = function()
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        vim.api.nvim_buf_set_option(
          bufnr,
          "omnifunc",
          "v:lua.vim.lsp.omnifunc"
        )
      end

      local lspconfig = vim.lsp.config

      -- List of all LSP servers with their configurations
      local servers = {
        { "cssmodules_ls", { capabilities = lsp_capabilities, on_attach = on_attach } },
        { "dockerls",      { capabilities = lsp_capabilities, on_attach = on_attach } },
        { "eslint",        { capabilities = lsp_capabilities, on_attach = on_attach } },
        { "graphql",       { capabilities = lsp_capabilities, on_attach = on_attach } },
        { "html",          { capabilities = lsp_capabilities, on_attach = on_attach } },
        { "jsonls",        { capabilities = lsp_capabilities, on_attach = on_attach } },
        { "marksman",      { capabilities = lsp_capabilities, on_attach = on_attach } },
        { "pyright",       { capabilities = lsp_capabilities, on_attach = on_attach } },
        {
          "ruff",
          {
            capabilities = lsp_capabilities,
            on_attach = function(client, bufnr)
              vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
              client.server_capabilities.hoverProvider = false
            end
          }
        },
        { "sqlls",       { capabilities = lsp_capabilities, on_attach = on_attach } },
        {
          "lua_ls",
          {
            capabilities = lsp_capabilities,
            on_attach = on_attach,
            settings = {
              Lua = {
                completion = {
                  callSnippet = "Replace",
                  displayContext = 1
                },
                defaultConfig = {
                  indent_style = "tab",
                  indent_size = "2",
                },
                diagnostics = { globals = { "vim" } },
                hints = { enable = true },
                runtime = { version = "Lua 5.4" },
                telemetry = { enable = true }
              }
            }
          }
        },
        { "svelte",      { capabilities = lsp_capabilities, on_attach = on_attach } },
        { "tailwindcss", { capabilities = lsp_capabilities, on_attach = on_attach } },
        {
          "ts_ls",
          {
            capabilities = lsp_capabilities,
            on_attach = function(client, bufnr)
              -- Only attach twoslash if available
              local has_twoslash, twoslash = pcall(require, "twoslash-queries")
              if has_twoslash then
                twoslash.attach(client, bufnr)
              end
              vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
            end
          }
        },
        { "vls",    { capabilities = lsp_capabilities, on_attach = on_attach } },
        { "yamlls", { capabilities = lsp_capabilities, on_attach = on_attach } },
      }

      -- Configure and enable all LSP servers using vim.lsp.config() and vim.lsp.enable()
      for _, server in ipairs(servers) do
        local name = server[1]
        local config = server[2]

        -- Use vim.lsp.config() to configure the server
        vim.lsp.config(name, config)

        -- Use vim.lsp.enable() to enable the server
        vim.lsp.enable(name)
      end
    end
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "onsails/lspkind.nvim",
      "neovim/nvim-lspconfig"
    },
    config = function()
      -- Instantiations
      local cmp_types = require("cmp.types")
      local luasnip = require("luasnip")

      -- NOTE: This function is provided from the advanced configuration of `nvim-cmp`.
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      local neogen = require("neogen")

      -- * Setup for the completion.
      cmp.setup({
        completion = {
          completeopt = "menu,menuone,noinsert",
          keyword_length = 1,
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
          ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }),
            { "i", "c" }),
          ["<Down>"] = {
            i = cmp.mapping.select_next_item({ behavior = cmp_types.cmp.SelectBehavior.Select }),
          },
          ["<Up>"] = {
            i = cmp.mapping.select_prev_item({ behavior = cmp_types.cmp.SelectBehavior.Select }),
          },
          ["<M-a>"] = {
            i = { cmp.mapping.abort() },
          },
          ["<M-q>"] = cmp.mapping.scroll_docs(-3),
          ["<M-e>"] = cmp.mapping.scroll_docs(3),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
              luasnip.expand_or_jump()
            elseif neogen.jumpable() then
              neogen.jump_next()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<C-Tab>"] = cmp.mapping.complete(),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            elseif neogen.jumpable(true) then
              neogen.jump_prev()
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = {
          { name = "nvim_lsp", priority = 1000, group_index = 1 },
          { name = "buffer",   priority = 750,  option = { keyword_length = 3 },       group_index = 2 },
          { name = "path",     priority = 500,  group_index = 3 },
          { name = "luasnip",  priority = 250,  option = { show_autosnippets = true }, group_index = 4 },
        },
        -- Additional sorting to prefer LSP
        sorting = {
          priority_weight = 2,
          comparators = {
            cmp.config.compare.offset,
            cmp.config.compare.exact,
            cmp.config.compare.score,
            cmp.config.compare.recently_used,
            cmp.config.compare.locality,

            function(entry1, entry2)
              local kind1 = entry1:get_kind()
              local kind2 = entry2:get_kind()
              local types = require("cmp.types")

              local deprioritized_kinds = {
                types.lsp.CompletionItemKind.Snippet,
                types.lsp.CompletionItemKind.Text,
              }

              local kind1_deprioritized = vim.tbl_contains(deprioritized_kinds, kind1)
              local kind2_deprioritized = vim.tbl_contains(deprioritized_kinds, kind2)

              -- If only kind1 is deprioritized, it should come after kind2
              if kind1_deprioritized and not kind2_deprioritized then
                return false
              end
              -- If only kind2 is deprioritized, it should come after kind1
              if kind2_deprioritized and not kind1_deprioritized then
                return true
              end

              -- Otherwise, no preference
              return nil
            end,
            cmp.config.compare.sort_text,
            cmp.config.compare.length,
            cmp.config.compare.order,
          },
        },
        window = {
          completion = cmp.config.window.bordered({
            border = "rounded",
            scrollbar = false,
            winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None"
          }),
          documentation = cmp.config.window.bordered({ border = "rounded" })
        }
      })

      -- 'nvim-autopairs' integration.
      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done()
      )
    end,
  },
  { "j-hui/fidget.nvim",   event = "LspAttach", opts = {} },
  { "dgagn/diagflow.nvim", event = "LspAttach", config = true },
}
