local wk = require("which-key")

wk.add(
  {
    -- Handy things
    { "<leader>hs",  function() Snacks.notifier.show_history() end, desc = "Show notification history" },

    -- Quick fix quick navigate
    { "<A-j>",       ":cnext<CR>",                                             desc = "Quick fix next" },
    { "<A-k>",       ":cprevious<CR>",                                         desc = "Quick fix previous" },
    -- Quick fix
    { "<leader>qn",  ":cnext<CR>",                                             desc = "Quick fix next" },
    { "<leader>qp",  ":cprevious<CR>",                                         desc = "Quick fix previous" },
    { "<leader>qa",  ":caddb<CR>",                                             desc = "Quick fix add current buffer" },
    { "<leader>qp",  ":cexpr []<CR>",                                          desc = "Quick fix clear" },
    --
    -- Improved moving and similar
    { "<C-Left>",    "<CMD>vertical resize -2<CR>",                            desc = "Resize split left" },
    { "<C-Right>",   "<CMD>vertical resize +2<CR>",                            desc = "Resize split right" },
    { "<C-d>",       "<C-d>zz",                                                desc = "Down half page and center" },
    { "<C-h>",       "<C-w>h",                                                 desc = "Move to split on left" },
    { "<C-j>",       "<C-w>j",                                                 desc = "Move to split below" },
    { "<C-k>",       "<C-w>k",                                                 desc = "Move to split above" },
    { "<C-l>",       "<C-w>l",                                                 desc = "Move to split on right" },
    { "<C-u>",       "<C-u>zz",                                                desc = "Up half page and center" },
    { "N",           "Nzzzv",                                                  desc = "Previous search result and center" },
    { "n",           "nzzzv",                                                  desc = "Next search result and center" },
    { "J",           "mzJ z",                                                  desc = "Append line below to the end of current, maintain cursor pos" },
    --
    -- Buffer management
    { "<leader>b",   group = "Buffers" },
    { "<leader>bd",  group = "Delete buffer/s" },
    { "<leader>bdc", ":bd<CR>",                                                desc = "Close the current buffer" },
    { "<leader>bdo", ":%bd|e#<CR>",                                            desc = "Close all buffers except this one" },
    --
    -- File management
    { "<leader>p",   group = "File commands" },
    { "<leader>pf",  function() vim.lsp.buf.format() end,                      desc = "Format file" },
    { "<leader>pv",  vim.cmd.Ex,                                               desc = "Open explorer" },
    --
    -- Todos
    { "<leader>t",   group = "Todo" },
    { "<leader>tn",  function() require("todo-comments").jump_next() end,      desc = "Next Todo" },
    { "<leader>tp",  function() require("todo-comments").jump_prev() end,      desc = "Previous Todo" },
    --
    -- Save and format
    {
      "<leader>w",
      function()
        vim.lsp.buf.format()
        vim.cmd("w")
      end,
      desc = "Format and save"
    },
    { "<leader>s",          ":SessionSearch<CR>", desc = "Open Session picker" },
    --
    -- Copy and paste
    { "<leader>y",          '"+y',                desc = "Copy to system clipboard",                    mode = { "v", "n", "x" } },
    { "<leader>Y",          '"+yg_',              desc = "Copy to system clipboard without newline",    mode = { "v", "n", "x" } },
    { "<leader>p",          "\"_dP",              desc = "Paste over highlight without using register", mode = { "x" } },
    --
    -- Tabs
    { "<leader><leader>t",  desc = "Tabs" },
    { "<leader><leader>tn", "<C-w>T",             desc = "Move buffer to new tab" },
    { "<leader><leader>tq", ":tabc<CR>",          desc = "Close current tab" },
  })

vim.keymap.set("n", "Q", "<nop>")

-- Make current file executable
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
