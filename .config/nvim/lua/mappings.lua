---@module 'mappings'
---@author CodexLink <https://github.com/CodexLink>
---@license Apache-2.0
-- @info * I cannot do keybinds for LSP as they are required to be fed from the setup function argument `on_attach` on every LSP installed.
-- @info [1] Some keybinds require using string instead of encapsulated [[]] context. This may be due to special handling after executing the function.
-- @info [2] APIs for the plugins leveraging `telescope` are most likely not documented in terms of accessing them through APIs, the following is the command used to identify them: 'lua vim.inspect(print(require("telescope.extensions")))`
-- @info [3] To reduce telescope startup time, require("telescope").load_extension was declared from the keybinds instead before initializing them.

local wk = require("which-key")
local notifier = require("utils").NotifyAfterExecution
local require_input_on_fn_call = require("utils").HandleInputToFn
local mapping_default_opts = { animate = true, timeout = 1250, title = "Mapping-to-Execution" }

wk.add({
  {
    mode = "v",
    { "<A-j>", ":m '>+1<CR>gv=gv", desc = "code: shift highlighted to bottom" },
    { "<A-k>", ":m '<-2<CR>gv=gv", desc = "code: shift highlighted to top" }
  },
  { "<F1>", function() require("search").open({ collection = "essentials" }) end, desc = "Telescope Seach: Essentials Collection opened." },
  { "<F2>", function() require("trouble").toggle("diagnostics") end,              desc = "trouble.nvim (Diagnostics): Toggle" },
  { "<F3>", function() require("aerial").toggle({ focus = false }) end,           desc = "aerial.nvim: Toggle (Unfocused)" },
  -- { "<F4>", function () print end, desc = "DAP"},
  { "<F5>", function() require("lazy").home() end,                                desc = "lazy.nvim: Opens UI window" },
  { "<F6>", function() require("which-key").show() end,                           desc = "which-key.nvim: Opens UI window for hinting keybinds" },
  { "<F7>", function() require("mason.ui").open() end,                            desc = "mason.nvim: Opens UI window" },
  {
    "<Leader>d",
    function()
      notifier({
        cmd = function() require("cord.api.command").toggle_presence() end,
        message = "cord.nvim: Toggle Discord Presence",
        opts = mapping_default_opts
      })
    end,
    desc = "`diffthis` on whole file"
  },
  { "<Leader>G", group = "gitsigns.nvim" },
  {
    "<Leader>GD",
    function()
      notifier({
        cmd = function() require("gitsigns").diffthis("~") end,
        message = "gitsigns: Diff view (at whole file) activated.",
        opts = mapping_default_opts
      })
    end,
    desc = "`diffthis` on whole file"
  },
  {
    "<Leader>GH",
    function()
      notifier({
        cmd = require("gitsigns").preview_hunk_inline,
        message = "gitsigns: Hunk on current line preview, activated",
        opts = mapping_default_opts
      })
    end,
    desc = "Preview hunk (Inlined)"
  },
  {
    "<Leader>Gb",
    function()
      notifier({
        cmd = require("gitsigns").toggle_current_line_blame,
        message = "gitsigns: Line blame toggled.",
        opts = mapping_default_opts
      })
    end,
    desc = "Toggle line blame"
  },
  {
    "<Leader>Gd",
    function()
      notifier({
        cmd = require("gitsigns").diffthis,
        message = "gitsigns: Diff view (at current line) activated.",
        opts = mapping_default_opts
      })
    end,
    desc = "'diffthis' on current line"
  },
  {
    "<Leader>Gh",
    function()
      notifier({
        cmd = require("gitsigns").preview_hunk,
        message = "gitsigns: Hunk on current line preview, activated",
        opts = mapping_default_opts
      })
    end,
    desc = "Preview hunk"
  },
  {
    "<Leader>L",
    function()
      require("telescope").load_extension("lazygit")
      require("lazygit").lazygit()
    end,
    desc = "lazygit.nvim: Toggle window"
  },
  {
    "<Leader>T",
    function()
      notifier({
        cmd = require("twilight").toggle,
        message = "twilight: Code dimming toggled.",
        opts = mapping_default_opts
      })
    end,
    desc = "twilight.nvim: Toggle code dimming"
  },
  {
    "<Leader>a",
    function()
      notifier({
        cmd = require("neogen").generate,
        message = "neogen: Code annotation added!",
        opts = mapping_default_opts
      })
    end,
    desc = "neogen: Annotate code context"
  },
  { "<Leader>h", function() require("tsht").nodes() end, desc = "nvim-treehopper: Hop to highlight context" },
  {
    "<Leader>m",
    function()
      notifier({
        cmd = [[ MarkdownPreviewToggle ]],
        message = "Markdown Preview toggled!",
        opts = mapping_default_opts
      })
    end,
    desc = "markdown-preview.nvim: Toggle"
  },
  { "<Leader>s", group = "possession.nvim: Session Management" },
  {
    "<Leader>sd",
    function()
      require_input_on_fn_call({
        fn_reference = require("possession").delete,
        input_options = { prompt = "Session name to delete." }
      })
    end,
    desc = "possession.nvim: Delete session by name"
  },
  {
    "<Leader>sl",
    function()
      require_input_on_fn_call({
        fn_reference = require("possession").load,
        input_options = { prompt = "Session name to load. (Note: Use `telescope` to retrieve a list of sessions!)" }
      })
    end,
    desc = "possession.nvim: Load saved session (dialogue)"
  },
  {
    "<Leader>ss",
    function()
      require_input_on_fn_call({
        fn_reference = require("possession").save,
        input_options = { prompt = "Session name to save." }
      })
    end,
    desc = "possession.nvim: Save current session"
  },
  {
    "<Leader>t",
    function()
      notifier({
        cmd = require("tint").toggle,
        message = "tint: Inactive window dimming toggled.",
        opts = mapping_default_opts
      })
    end,
    desc = "twilight.nvim: Toggle inactive window dimming"
  },
  { "<Leader>r", function() require("ssr").open() end,         desc = "ssr.nvim: Do 'Structural Search and Replace'", mode = { "n", "x" } },
  {
    mode = { "i", "n", "v" },
    { "<M-F1>", function() require("search").open({ collection = "extras" }) end, desc = "Telescope Seach: Extras Collection opened." },
    { "<M-q>",  function() require("hop").hint_char1() end,                       desc = "hop.nvim: Hop 1 char" },
    { "<M-Q>",  function() require("hop").hint_char2() end,                       desc = "hop.nvim: Hop 2 chars" }
  },
  {
    "<M-w>",
    function() require("hop").hint_anywhere({ direction = require("hop.hint").HintDirection.AFTER_CURSOR }) end,
    desc = "hop.nvim: hop below anywhere"
  },
  {
    "<M-W>",
    function() require("hop").hint_anywhere({ direction = require("hop.hint").HintDirection.BEFORE_CURSOR }) end,
    desc = "hop.nvim: hop above anywhere"
  },
  {
    "<M-e>",
    function()
      notifier({
        cmd = require("treesj").toggle,
        message = "treesj: toggled to wrap/one-line.",
        opts = mapping_default_opts
      })
    end,
    desc = "treesj: Toggle 'One-Liner/Splitted' Style."
  },
  { "<M-a>", function() require("illuminate").goto_prev_reference() end, desc = "vim-illuminate: Jump to previous reference" },
  { "<M-s>", function() require("illuminate").goto_next_reference() end, desc = "vim-illuminate: Jump to next reference" },
  {
    "<M-d>",
    function()
      notifier({
        cmd = [[ set wrap! ]],
        message = "Code wrapping toggled.",
        opts = mapping_default_opts
      })
    end,
    desc = "builtin: Toggle wrap"
  },
  {
    "<M-f>",
    function()
      notifier({
        cmd = function() vim.lsp.buf.format({ async = true, bufnr = vim.fn.bufnr(), timeout = 5000 }) end,
        message = "Formatting done!",
        opts = mapping_default_opts
      })
    end,
    desc = "utils: Code Format"
  },
  {
    mode = "i",
    { "<M-h>", "<C-o>h", desc = "cursor (on insert): move left" },
    { "<M-H>", "<C-o>B", desc = "cursor (on insert): move left (by word)" },
    { "<M-j>", "<C-o>j", desc = "cursor (on insert): move down" },
    { "<M-k>", "<C-o>k", desc = "cursor (on insert): move up" },
    { "<M-l>", "<C-o>l", desc = "cursor (on insert): move right" },
    { "<M-L>", "<C-o>W", desc = "cursor (on insert): move right (by word)" },
  },
  {
    mode = { "n", "v" },
    { "<M-z>", function() vim.cmd [[ bprev ]] end,   desc = "buffer: previous" },
    { "<M-x>", function() vim.cmd [[ bnext ]] end,   desc = "buffer: next" },
    { "<M-c>", function() vim.cmd [[ bdelete ]] end, desc = "buffer: delete current buffer" },
    { "<M-n>", function() vim.cmd [[ enew ]] end,    desc = "buffer: new" }
  },
  { "<S-F3>",  function() require("aerial").toggle({ focus = true }) end, desc = "aerial.nvim: Toggle (Focused)" },
  { "<Space>", group = "LSP + LSP-Related Actions" },
  {
    "<Space>c",
    function()
      notifier({
        cmd = vim.lsp.buf.code_action,
        opts = mapping_default_opts
      })
    end,
    desc = "lsp: seek code action"
  },
  {
    "<Space>d",
    function()
      notifier({
        cmd = vim.lsp.buf.declaration,
        opts = mapping_default_opts
      })
    end,
    desc = "lsp: seek declaration"
  },
  {
    "<Space>D",
    function()
      notifier({
        cmd = function() require("glance").open("definitions") end,
        opts = mapping_default_opts,
      })
    end,
    desc = "lsp: seek definitions"
  },
  {
    "<Space>h",
    function()
      notifier({
        cmd = vim.lsp.buf.hover,
        opts = mapping_default_opts
      })
    end,
    desc = "lsp: hover for context"
  },
  {
    "<Space>i",
    function()
      notifier({
        cmd = function() require("glance").open("implementations") end,
        opts = mapping_default_opts
      })
    end,
    desc = "lsp: seek implementations"
  },
  {
    "<Space>o",
    function()
      notifier({
        cmd = vim.diagnostic.open_float,
        opts = mapping_default_opts
      })
    end,
    desc = "lsp: float context"
  },
  {
    "<Space>r",
    function()
      notifier({
        cmd = vim.lsp.buf.rename,
        opts = mapping_default_opts
      })
    end,
    desc = "lsp: rename context"
  },
  { "<Space>R", ":IncRename ", desc = "inc-rename.nvim: Rename on cursor" },
  {
    "<Space>s",
    function()
      notifier({
        cmd = vim.lsp.buf.signature_help,
        opts = mapping_default_opts
      })
    end,
    desc = "lsp: seek signature help"
  },
  {
    "<Space>S",
    function()
      notifier({
        cmd = function() require("glance").open("references") end,
        opts = mapping_default_opts
      })
    end,
    desc = "lsp: seek references"
  },
  {
    "<Space>t",
    function()
      notifier({
        cmd = function() require("glance").open("type_definitions") end,
        opts = mapping_default_opts
      })
    end,
    desc = "lsp: seek type definitions"
  },
  {
    "<Space>x",
    function()
      notifier({
        cmd = vim.diagnostic.goto_prev,
        opts = mapping_default_opts
      })
    end,
    desc = "lsp: go to previous"
  },
  {
    "<Space>z",
    function()
      notifier({
        cmd = vim.diagnostic.goto_next,
        opts = mapping_default_opts
      })
    end,
    desc = "lsp: go to next"
  }
})
