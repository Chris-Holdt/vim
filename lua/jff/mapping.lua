local wk = require("which-key")

wk.register({
  ["<C-h>"] = { "<C-w>h", "Move to split on left" },
  ["<C-j>"] = { "<C-w>j", "Move to split below" },
  ["<C-k>"] = { "<C-w>k", "Move to split above" },
  ["<C-l>"] = { "<C-w>l", "Move to split on right" },
  ["<C-Left>"] = { "<CMD>vertical resize -2<CR>", "Resize split left" },
  ["<C-Right>"] = { "<CMD>vertical resize +2<CR>", "Resize split right" },
  ["<leader>"] = {
    b = {
      name = "Buffers",
      d = {
        name = "Delete buffer/s",
        c = { ":bd<CR>", "Close the current buffer" },
        o = { ":%bd|e#<CR>", "Close all buffers except this one" },
      }
    },
    c = {
      name = "Colourscheme quick switch",
      d = {
        ":colorscheme catppuccin-latte <CR>",
        "Day mode: Catppuccin Latte"
      },
      n = { ":colorscheme spacerain <CR>", "Night mode: Spacerain" },
    },
    d = {
      name = "Database",
      b = {
        "<CMD>DBUIToggle<CR>",
        "Open Dadbod UI"
      }
    },
    s = {
      function()
        require("code-shot").shot()
      end,
      "Screenshot"
    },
    p = {
      name = "File commands",
      v = { vim.cmd.Ex, "Open explorer" },
      f = {
        function()
          vim.lsp.buf.format()
        end,
        "Format file"
      },
    },
    w = {
      function()
        vim.lsp.buf.format()
        vim.cmd("w")
      end,
      "Format and save"
    },
    t = {
      name = "Tabs",
      N = { ":tabNext<CR>", "Previous Tab" },
      n = { ":tabnext<CR>", "Next Tab" },
      c = { ":tabclose<CR>", "Close Tab" },
      t = { ":tabnew", "New Tab" },
    }
  },
  J = {
    "mzJ z",
    "Append line below to the end of current, maintain cursor pos"
  },
  ["<A-k>"] = { ":m .-2<CR>==", "Move highlight up" },
  ["<A-j>"] = { ":m .+1<CR>==", "Move highlight down" },
  ["<C-u>"] = { "<C-u>zz", "Up half page and center" },
  ["<C-d>"] = { "<C-d>zz", "Down half page and center" },
  n = { "nzzzv", "Next search result and center" },
  N = { "Nzzzv", "Previous search result and center" },
}, {
  mode = "n",
})

wk.register({
  name = "Screenshot",
  ["<leader>s"] = {
    mode = "v",
    function()
      require("code-shot").shot()
    end,
    "Take a Screenshot of the current selection"
  },
  {
    mode = "v",
  }
})

wk.register({
  name = "Highlight moving",
  ["<A-k>"] = { "<-2<CR>gv=gv", "Move highlight up" },
  ["<A-j>"] = { ">+1<CR>gv=gv", "Move highlight down" },
}, {
  mode = "v",
})

wk.register({
  name = "Paste over",
  ["<leader>p"] = {
    mode = "x",
    "\"_dP",
    "Paste over highlight without using register" },
}, {
  mode = "x"
})

vim.keymap.set("n", "Q", "<nop>")

-- Make current file executable
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
