-- coding-helpers.lua | Plugin declaration for that provides snippets, autocompletion, advertisement of suggestion from the server, etc), used for the package manager lazy.nvim"
-- @CodexLink     | https://github.com/CodexLink

-- Info
-- [1] Configuration for the LSP servers or the configurator is separated, the context of this plugin spec is all about advertising the completion plugin to the LSP to display at the editor.

return {
  -- ! A package manager for the external tools, such as: Debug Adapter Protocol (DAP), Linters, Formatters, etc.
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
    lazy = false,
    priority = 800,
  },
  -- ! Package manager extension as an LSP provider for the "nvim-lspconfig".
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
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
    end,
    lazy = false,
    priority = 750,
  },
  -- ! Package manager extension as an LSP provider for the "null-ls".
  -- * Note that we have to use the packages that is namespaced by `null-ls` to ensure no conflicts during setup.
  {
    "jay-babu/mason-null-ls.nvim",
    config = function(
    ) require("mason-null-ls").setup(
        {
          ensured_installed = nil,
          automatic_installation = true,
          automatic_setup = true
        }
      )
    end,
    lazy = false,
    priority = 700,
  },
  -- !!! Dependants from the external package were done by `mason.nvim` and `null-ls.nvim`.
  {
    "hrsh7th/nvim-cmp",
    config = function()
      -- Instantiations
      local cmp_types = require("cmp.types")
      local lspconfig = require("lspconfig")
      local luasnip = require("luasnip")

      -- ! This function is provided from the advanced configuration of `nvim-cmp`.
      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")

      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done()
      )
      -- * Setup for the completion.
      cmp.setup({
        completion = {
          keyword_length = 2
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
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
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

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } })
      })

      -- Require every LSP via lspconfig["lsp_name"].setup({<setup_table>})
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

      -- Use an on_attach function to only map the following keys
      -- after the language server attaches to the current buffer
      local on_attach = function(_, bufnr)
        vim.api.nvim_buf_set_option(
          bufnr,
          "omnifunc",
          "v:lua.vim.lsp.omnifunc"
        )
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
      -- * Completion plugins
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-path" },
      { "onsails/lspkind.nvim" },
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
      { "saadparwaiz1/cmp_luasnip" },
    },
    event = { "BufRead", "BufNewFile", "InsertEnter" },
    lazy = true
  },
  { "neovim/nvim-lspconfig", dependencies = { "hrsh7th/nvim-cmp" }, lazy = true, priority = 640 }, -- For the LSP.
  -- ! For the Code Actions, Formatters and Linters.
  {
    "jose-elias-alvarez/null-ls.nvim",
    config = function()
      -- !!! null-ls will be used for the DAPs, Linters, and Formatters.
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.diagnostics.cppcheck,
          null_ls.builtins.diagnostics.cpplint,
          null_ls.builtins.diagnostics.mypy,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.clang_format,
          null_ls.builtins.formatting.fixjson,
          null_ls.builtins.formatting.eslint_d,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.markdownlint,
          null_ls.builtins.formatting.prettierd,
          null_ls.builtins.formatting.remark,
          null_ls.builtins.formatting.reorder_python_imports,
          null_ls.builtins.formatting.sql_formatter
        }
      })
    end,
    dependencies = { "nvim-lua/plenary.nvim" },
    lazy = false
  }
}
