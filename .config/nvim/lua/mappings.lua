---@module 'mappings'
---@author CodexLink <https://github.com/CodexLink>
---@license Apache-2.0
-- @info * I cannot do keybinds for LSP as they are required to be fed from the setup function argument `on_attach` on every LSP installed.
-- @info [1] Some keybinds require using string instead of encapsulated [[]] context. This may be due to special handling after executing the function.
-- @info [2] APIs for the plugins leveraging `telescope` are most likely not documented in terms of accessing them through APIs, the following is the command used to identify them: 'lua vim.inspect(print(require("telescope.extensions")))`
-- @info [3] To reduce telescope startup time, require("telescop").load_extension was declared from the keybinds instead before initializing them.

local wk = require("which-key")
local notifier = require("utils").NotifyAfterExecution
local require_input_on_fn_call = require("utils").HandleInputToFn
local mapping_default_opts = { animate = true, timeout = 1250, title = "Mapping-to-Execution" }

wk.register({
  ["<A-j>"] = { ":m '>+1<CR>gv=gv", "code: shift highlighted to bottom", mode = { "v" } },
  ["<A-k>"] = { ":m '<-2<CR>gv=gv", "code: shift highlighted to top", mode = { "v" } },
  ["<F1>"] = { function() require("telescope.builtin").builtin() end, "telescope.nvim: Toggle 'builtin'" },
  ["<F2>"] = { function() require("trouble").toggle() end, "trouble.nvim (Diagnostics): Toggle" },
  ["<F3>"] = { function() require("aerial").toggle({ focus = false }) end, "aerial.nvim: Toggle (Unfocused)" },
  -- ["<F4>"] = { function () print end, "DAP"},
  ["<F5>"] = { function() require("lazy").home() end, "lazy.nvim: Opens UI window" },
  ["<F6>"] = { function() require("which-key").show() end, "which-key.nvim: Opens UI window for hinting keybinds" },
  ["<F7>"] = { function() require("mason.ui").open() end, "mason.nvim: Opens UI window" },
  ["<F8>"] = { function()
    notifier({
      cmd = function()
        require("telescope").load_extension("possession")
        require("telescope")
            .extensions.possession.list()
      end,
      message = "Session-to-load selection displayed.",
      opts = mapping_default_opts
    })
  end,
    "possession.nvim: session-to-load selection" },
  ["<F9>"] = { function() vim.cmd([[ TodoTelescope ]]) end, "todo-comments.nvim: Check TODO with Telescope." },
  ["<Leader>"] = {
    a = { function()
      notifier({
        cmd = require("neogen").generate,
        message = "neogen: Code annotation added!",
        opts = mapping_default_opts
      })
    end, "neogen: Annotate code context" },
    G = {
      name = "gitsigns.nvim",
      b = { function()
        notifier({
          cmd = require("gitsigns").toggle_current_line_blame,
          message = "gitsigns: Line blame toggled.",
          opts = mapping_default_opts
        })
      end, "Toggle line blame" },
      d = { function()
        notifier({
          cmd = require("gitsigns").diffthis,
          message = "gitsigns: Diff view (at current line) activated.",
          opts = mapping_default_opts
        })
      end,
        "'diffthis' on current line" },
      D = { function()
        notifier({
          cmd = function() require("gitsigns").diffthis("~") end,
          message = "gitsigns: Diff view (at whole file) activated.",
          opts = mapping_default_opts
        })
      end,
        "`diffthis` on whole file" },
      h = { function()
        notifier({
          cmd = require("gitsigns").preview_hunk,
          message = "gitsigns: Hunk on current line preview, activated",
          opts = mapping_default_opts
        })
      end, "Preview hunk" },
      H = { function()
        notifier({
          cmd = require("gitsigns").preview_hunk_inline,
          message = "gitsigns: Hunk on current line inline-preview, activated",
          opts = mapping_default_opts
        })
      end,
        "Preview hunk (Inlined)" },
    },
    L = { function()
      require("telescope").load_extension("lazygit")
      require("lazygit").lazygit()
    end,
      "lazygit.nvim: Toggle window" },
    m = { function()
      notifier({
        cmd = [[ MarkdownPreviewToggle ]],
        message = "Markdown Preview toggled!",
        opts = mapping_default_opts
      })
    end, "markdown-preview.nvim: Toggle" },
    n = { function() require("telescope").extensions.notify.notify() end,
      "nvim-notify: Check notifications via 'Telescope'" },
    r = { function() require("ssr").open() end, "ssr.nvim: Do 'Structural Search and Replace'", mode = { "n", "x" } },
    s = {
      name = "possession.nvim: Session Management",
      d    = { function()
        require_input_on_fn_call({
          fn_reference = require("possession").delete,
          input_options = { prompt = "Session name to delete." }
        })
      end, "possession.nvim: Delete session by name" },
      s    = { function()
        require_input_on_fn_call({
          fn_reference = require("possession").save,
          input_options = { prompt = "Session name to save." }
        })
      end, "possession.nvim: Save current session" },
      l    = { function()
        require_input_on_fn_call({
          fn_reference = require("possession").load,
          input_options = { prompt = "Session name to load. (Note: Use `telescope` to retrieve a list of sessions!)" }
        })
      end,
        "possession.nvim: Load saved session (dialogue)" },
    },
    t = { function() require("tsht").nodes() end, "nvim-treehopper: Hop to highlight context" },
    T = { function()
      notifier({
        cmd = require("twilight").toggle,
        message = "twilight: Code dimming toggled.",
        opts = mapping_default_opts
      })
    end, "twilight.nvim: Toggle code dimming" },
  },

  ["<M-1>"] = { function() require("telescope.builtin").buffers() end, "telescope.nvim: Toggle buffers", mode = { "n", "v" } },
  ["<M-2>"] = { function() require("telescope.builtin").live_grep() end, "telescope.nvim: Toggle live grep ('ripgrep')", mode = { "n", "v" } },
  ["<M-3>"] = { function() require("telescope.builtin").find_files() end, "telescope.nvim: Toggle file search", mode = { "n", "v" } },
  ["<M-F1>"] = { function()
    require("telescope").load_extension("file_browser")
    require("telescope").extensions.file_browser
        .file_browser()
  end,
    "telescope.nvim: Toggle 'file browser'" },
  ["<M-F2>"] = { function() require("telescope.builtin").diagnostics() end, "telescope.nvim: Toggle 'diagnostics'" },
  ["<M-F3>"] = { function()
    require("telescope").load_extension("aerial")
    require("telescope").extensions.aerial.aerial()
  end,
    "telescope.nvim: Toggle 'aerial'" },
  ["<M-q>"] = { function() require("hop").hint_char1() end, "hop.nvim: Hop 1 char", mode = { "n", "v" } },
  ["<M-Q>"] = { function() require("hop").hint_char2() end, "hop.nvim: Hop 2 chars", mode = { "n", "v" } },
  ["<M-w>"] = { function() require("hop").hint_anywhere({ direction = require("hop.hint").HintDirection.AFTER_CURSOR }) end,
    "hop.nvim: hop below anywhere" },
  ["<M-W>"] = { function() require("hop").hint_anywhere({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR }) end,
    "hop.nvim: hop above anywhere" },
  ["<M-e>"] = { function()
    notifier({
      cmd = require("treesj").toggle,
      message = "treesj: toggled to wrap/one-line.",
      opts = mapping_default_opts
    })
  end,
    "treesj: Toggle 'One-Liner/Splitted' Style." },
  ["<M-a>"] = { function() require("illuminate").goto_prev_reference() end, "vim-illuminate: Jump to previous reference" },
  ["<M-s>"] = { function() require("illuminate").goto_next_reference() end, "vim-illuminate: Jump to next reference" },
  ["<M-d>"] = { function()
    notifier({
      cmd = [[ set wrap! ]],
      message = "Code wrapping toggled.",
      opts = mapping_default_opts
    })
  end, "builtin: Toggle wrap" },
  ["<M-f>"] = { function()
    notifier({
      cmd = function() vim.lsp.buf.format({ async = true, bufnr = vim.fn.bufnr(), timeout = 5000 }) end,
      message = "Formatting done!",
      opts = mapping_default_opts
    })
  end, "utils: Code Format" },
  ["<M-h>"] = { function() vim.cmd [[ normal h ]] end, mode = { "i" }, "cursor (on insert): move left" },
  ["<M-j>"] = { function() vim.cmd [[ normal j ]] end, mode = { "i" }, "cursor (on insert): move down" },
  ["<M-k>"] = { function() vim.cmd [[ normal k ]] end, mode = { "i" }, "cursor (on insert): move up" },
  ["<M-l>"] = { function() vim.cmd [[ normal l ]] end, mode = { "i" }, "cursor (on insert): move right" },

  ["<M-z>"] = { function() vim.cmd [[ bprev ]] end, mode = { "n", "v" }, "buffer: previous" },
  ["<M-x>"] = { function() vim.cmd [[ bnext ]] end, mode = { "n", "v" }, "buffer: next" },
  ["<M-c>"] = { function() vim.cmd [[ bdelete ]] end, mode = { "n", "v" }, "buffer: delete current buffer" },
  ["<M-n>"] = { function() vim.cmd [[ enew ]] end, mode = { "n", "v" }, "buffer: new" },
  ["<S-F3>"] = { function() require("aerial").toggle({ focus = true }) end, "aerial.nvim: Toggle (Focused)" },
  ["<Space>"] = {
    name = "LSP + LSP-Related Actions",
    c = { function()
      notifier({
        cmd = vim.lsp.buf.code_action,
        opts = mapping_default_opts
      })
    end, "lsp: seek code action" },
    d = { function()
      notifier({
        cmd = vim.lsp.buf.declaration,
        opts = mapping_default_opts
      })
    end, "lsp: seek declaration" },
    D = { function()
      notifier({
        cmd = function() require("glance").open("definitions") end,
        opts = mapping_default_opts,
      })
    end, "lsp: seek definitions" },
    h = { function()
      notifier({
        cmd = vim.lsp.buf.hover,
        opts = mapping_default_opts
      })
    end, "lsp: hover for context" },
    i = { function()
      notifier({
        cmd = function() require("glance").open("implementations") end,
        opts = mapping_default_opts
      })
    end, "lsp: seek implementations" },
    o = { function()
      notifier({
        cmd = vim.diagnostic.open_float,
        opts = mapping_default_opts
      })
    end, "lsp: float context" },
    r = { function()
      notifier({
        cmd = vim.lsp.buf.rename,
        opts = mapping_default_opts
      })
    end, "lsp: rename context" },
    R = { ":IncRename ", "inc-rename.nvim: Rename on cursor" },
    s = { function()
      notifier({
        cmd = vim.lsp.buf.signature_help,
        opts = mapping_default_opts
      })
    end, "lsp: seek signature help" },
    S = { function()
      notifier({
        cmd = function() require("glance").open("references") end,
        opts = mapping_default_opts
      })
    end, "lsp: seek references" },
    t = { function()
      notifier({
        cmd = function() require("glance").open("type_definitions") end,
        opts = mapping_default_opts
      })
    end, "lsp: seek type definitions" },
    x = { function()
      notifier({
        cmd = vim.diagnostic.goto_prev,
        opts = mapping_default_opts
      })
    end, "lsp: go to previous" },
    z = { function()
      notifier({
        cmd = vim.diagnostic.goto_next,
        opts = mapping_default_opts
      })
    end, "lsp: go to next" }
  }
})
