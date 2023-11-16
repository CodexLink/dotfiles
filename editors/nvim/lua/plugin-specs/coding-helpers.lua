---@module 'coding-helpers'
---@author CodexLink <https://github.com/CodexLink>
---@license Apache-2.0
---@info [1] Configuration for the LSP servers or the configurator is separated, the context of this plugin spec is all about advertising the completion plugin to the LSP to display at the editor.

return {
  -- NOTE: A package manager for the external tools, such as: Debug Adapter Protocol (DAP), Linters, Formatters, etc.
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        pip = {
          upgrade_pip = true,
        },
        max_concurrent_installers = 10
      })
    end,
    lazy = false
  },
  -- NOTE: Package manager extension as an LSP provider for the "nvim-lspconfig".
  {
    "williamboman/mason-lspconfig.nvim",
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
          "ruff_lsp",
          "sqlls",
          "tsserver",
          "yamlls",
        },
        automatic_installation = true
      })
    end,
    lazy = false
  },
  -- NOTE: Dependants from the external package were done by `mason.nvim` and `null-ls.nvim`.
  {
    "hrsh7th/nvim-cmp",
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
          ["<CR>"] = cmp.mapping(cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert }), { "i", "c" }),
          ["<Down>"] = {
            i = cmp.mapping.select_next_item({ behavior = cmp_types.cmp.SelectBehavior.Select }),
          },
          ["<Up>"] = {
            i = cmp.mapping.select_prev_item({ behavior = cmp_types.cmp.SelectBehavior.Select }),
          },
          ["<M-a>"] = {
            i = { cmp.mapping.abort() },
          },
          ["<M-q>"] = cmp.mapping.scroll_docs( -3),
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
            elseif luasnip.jumpable( -1) then
              luasnip.jump( -1)
            elseif neogen.jumpable(true) then
              neogen.jump_prev()
            else
              fallback()
            end
          end, { "i", "s" }),
        },
        sources = {
          {
            name = "buffer",
            option = { keyword_length = 2 }
          },
          { name = "nvim_lsp" },
          {
            name = "luasnip",
            option = { show_autosnippets = true }
          },
          { name = "path" }
        },
        snippet = { expand = function(args) luasnip.lsp_expand(args.body) end },
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

      -- 'cmd' integration.
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } })
      })
    end,
    dependencies = {
      -- * Completion plugins
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-path" },
      { "onsails/lspkind.nvim" },
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
      { "saadparwaiz1/cmp_luasnip" },
    },
    event = "InsertEnter",
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp", "j-hui/fidget.nvim", "marilari88/twoslash-queries.nvim" },
    event = { "User", "InsertEnter" },
    config = function()
      local lspconfig = require("lspconfig")
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        vim.api.nvim_buf_set_option(
          bufnr,
          "omnifunc",
          "v:lua.vim.lsp.omnifunc"
        )
      end

      lspconfig.cssmodules_ls.setup({
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })

      lspconfig.dockerls.setup({
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })

      lspconfig.eslint.setup({
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })

      lspconfig.graphql.setup({
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })

      lspconfig.html.setup({
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })

      lspconfig.jsonls.setup({
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })

      lspconfig.marksman.setup({
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })

      lspconfig.pyright.setup({
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })

      lspconfig.ruff_lsp.setup({
        capabilities = lsp_capabilities,
        on_attach = function(client, bufnr)
          vim.api.nvim_buf_set_option(
            bufnr,
            "omnifunc",
            "v:lua.vim.lsp.omnifunc"
          )

          client.server_capabilities.hover = false
        end
      })

      lspconfig.sqlls.setup({
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })

      lspconfig.sumneko_lua.setup({
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
            hints = {
              enable = true
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

      lspconfig.svelte.setup({
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })

      lspconfig.tailwindcss.setup({
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })

      lspconfig.tsserver.setup({
        capabilities = lsp_capabilities,
        on_attach = function(client, bufnr)
          require("twoslash-queries").attach(client, bufnr)
          vim.api.nvim_buf_set_option(
            bufnr,
            "omnifunc",
            "v:lua.vim.lsp.omnifunc"
          )
        end
      })

      lspconfig.volar.setup({
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })

      lspconfig.yamlls.setup({
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })
    end,
  },
  { -- ! Linters
    "mfussenegger/nvim-lint",
    event = { "BufReadPost", "BufWritePost", "BufWritePre" },
    lazy = true,
    config = function()
      require('lint').linters_by_ft = {
        clang = { "clangtidy" },
        cpp = { "cpplint" },
        gdscript = { "gdlint" },
        gitcommit = { "commitlint" },
        javascript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        json = { "jsonlint" },
        lua = { "luacheck" },
        markdown = { "markdownlint" },
        python = { "ruff", "mypy" },
        typescript = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        sql = { "sqlfluff" }
      }

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "BufWritePre" }, { callback = function() require('lint').try_lint() end })

    end
  },
  { "mhartington/formatter.nvim", config = true, lazy = true } -- ! Formatters
}
