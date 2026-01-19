---@module 'lsp-helpers'
---@author CodexLink <https://github.com/CodexLink>
---@license Apache-2.0
---@info [1] Configuration for the LSP servers or the configurator is separated, the context of this plugin spec is all about advertising the completion plugin to the LSP to display at the editor.

return {
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", config = true },
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
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" }
  },
  {
    "hrsh7th/cmp-nvim-lsp",
    lazy = true
  },
  {
    "hrsh7th/cmp-buffer",
    lazy = true
  },
  {
    "hrsh7th/cmp-path",
    lazy = true
  },
  {
    "hrsh7th/cmp-cmdline",
    lazy = true
  },
  {
    "onsails/lspkind.nvim",
    lazy = true
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
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies =
    "saadparwaiz1/cmp_luasnip",
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
          keyword_length = 4
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


      -- ! Setup `lspconfig`
      local lspconfig = vim.lsp.config
      local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(_, bufnr)
        vim.api.nvim_buf_set_option(
          bufnr,
          "omnifunc",
          "v:lua.vim.lsp.omnifunc"
        )
      end

      lspconfig("cssmodules_ls", {
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })
      vim.lsp.enable({ "cssmodules_ls" })

      lspconfig("dockerls", {
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })
      vim.lsp.enable({ "dockerls" })

      lspconfig("eslint", {
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })
      vim.lsp.enable({ "eslint" })

      lspconfig("graphql", {
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })
      vim.lsp.enable({ "graphql" })

      lspconfig("html", {
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })
      vim.lsp.enable({ "html" })

      lspconfig("jsonls", {
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })
      vim.lsp.enable({ "jsonls" })

      lspconfig("marksman", {
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })
      vim.lsp.enable({ "marksman" })

      lspconfig("pyright", {
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })
      vim.lsp.enable({ "pyright" })

      lspconfig("ruff", {
        capabilities = lsp_capabilities,
        on_attach = function(client, bufnr)
          vim.api.nvim_buf_set_option(
            bufnr,
            "omnifunc",
            "v:lua.vim.lsp.omnifunc"
          )

          client.server_capabilities.hoverProvider = false
        end
      })
      vim.lsp.enable({ "ruff" })

      lspconfig("sqlls", {
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })
      vim.lsp.enable({ "sqlls" })

      lspconfig("lua_ls", {
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
      vim.lsp.enable({ "lua_ls" })

      lspconfig("svelte", {
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })
      vim.lsp.enable({ "svelte" })

      lspconfig("tailwindcss", {
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })
      vim.lsp.enable({ "tailwindcss" })

      lspconfig("ts_ls", {
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
      vim.lsp.enable({ "ts_ls" })

      lspconfig("vue_ls", {
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })
      vim.lsp.enable({ "vue_ls" })

      lspconfig("yamlls", {
        capabilities = lsp_capabilities,
        on_attach = on_attach
      })
      vim.lsp.enable({ "yamlls" })
    end,
  },
  { "j-hui/fidget.nvim",   event = "LspAttach", opts = {} },
  { "dgagn/diagflow.nvim", event = "LspAttach", config = true },
}
