local wk = require("which-key")

wk.add(
  {
    { "<A-j>",       ":cnext<CR>",                                                       desc = "Quick fix next" },
    { "<A-k>",       ":cprevious<CR>",                                                   desc = "Quick fix previous" },
    { "<C-Left>",    "<CMD>vertical resize -2<CR>",                                      desc = "Resize split left" },
    { "<C-Right>",   "<CMD>vertical resize +2<CR>",                                      desc = "Resize split right" },
    { "<C-d>",       "<C-d>zz",                                                          desc = "Down half page and center" },
    { "<C-h>",       "<C-w>h",                                                           desc = "Move to split on left" },
    { "<C-j>",       "<C-w>j",                                                           desc = "Move to split below" },
    { "<C-k>",       "<C-w>k",                                                           desc = "Move to split above" },
    { "<C-l>",       "<C-w>l",                                                           desc = "Move to split on right" },
    { "<C-u>",       "<C-u>zz",                                                          desc = "Up half page and center" },
    { "<leader>b",   group = "Buffers" },
    { "<leader>bd",  group = "Delete buffer/s" },
    { "<leader>bdc", ":bd<CR>",                                                          desc = "Close the current buffer" },
    { "<leader>bdo", ":%bd|e#<CR>",                                                      desc = "Close all buffers except this one" },
    { "<leader>c",   group = "Colourscheme quick switch" },
    { "<leader>cd",  ":colorscheme catppuccin-latte <CR>",                               desc = "Day mode: Catppuccin Latte" },
    { "<leader>cn",  ":colorscheme spacerain <CR>",                                      desc = "Night mode: Spacerain" },
    { "<leader>cc",  ":colorscheme catppuccin-macchiato <CR>",                           desc = "Night mode: Catppuccin Macchiato" },
    --[[ { "<leader>d",   group = "Database" },
    { "<leader>db",  "<CMD>DBUIToggle<CR>",                                              desc = "Open Dadbod UI" }, ]]

    { "<leader>e",   group = "Window setup" },
    { "<leader>ee",  "<C-w>=",                                                           desc = "Equalise" },
    { "<leader>eb",  "<C-w>v<C-w>v<C-w>h<C-w>h<C-w>=26<C-w><<C-w>l<C-w>l26<C-w><<C-w>h", desc = "Open and Big center" },
    { "<leader>es",  "<C-w>h<C-w>h<C-w>=26<C-w><<C-w>l<C-w>l26<C-w><<C-w>h",             desc = "Big center, smaller left and right" },

    { "<leader>p",   group = "File commands" },
    { "<leader>pf",  function() vim.lsp.buf.format() end,                                desc = "Format file" },
    { "<leader>pv",  vim.cmd.Ex,                                                         desc = "Open explorer" },
    { "<leader>t",   group = "Todo" },
    { "<leader>tn",  function() require("todo-comments").jump_next() end,                desc = "Next Todo" },
    { "<leader>tp",  function() require("todo-comments").jump_prev() end,                desc = "Previous Todo" },
    {
      "<leader>w",
      function()
        vim.lsp.buf.format()
        vim.cmd("w")
      end,
      desc = "Format and save"
    },
    { "J",                  "mzJ z",              desc = "Append line below to the end of current, maintain cursor pos" },
    { "N",                  "Nzzzv",              desc = "Previous search result and center" },
    { "n",                  "nzzzv",              desc = "Next search result and center" },
    { "<leader>s",          ":SessionSearch<CR>", desc = "Open Session picker" },

    { "<leader>y",          '"+y',                desc = "Copy to system clipboard",                                    mode = { "v", "n", "x" } },

    { "<leader>Y",          '"+yg_',              desc = "Copy to system clipboard without newline",                    mode = { "v", "n", "x" } },
    --[[ { "<A-k>",              "<-2<CR>gv=gv",       desc = "Move highlight up",                                           mode = { "v", "n", "x" } },
    { "<A-j>",              ">+1<CR>gv=gv",       desc = "Move highlight down",                                         mode = { "v", "n", "x" } }, ]]

    { "<leader>p",          "\"_dP",              desc = "Paste over highlight without using register",                 mode = { "x" } },
    { "<leader><leader>t",  desc = "Tabs" },
    { "<leader><leader>tn", "<C-w>T",             desc = "Move buffer to new tab" },
    { "<leader><leader>tq", ":tabc<CR>",          desc = "Close current tab" },
    --[[ { "<leader><leader>q",  desc = "Quick Fix" },
    { "<leader><leader>qn", ":cnext<CR>",          desc = "Next quick fix item" },
    { "<leader><leader>qp", ":cprevious<CR>",          desc = "Previous quick fix item" }, ]]
  })

vim.keymap.set("n", "Q", "<nop>")

-- Make current file executable
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
