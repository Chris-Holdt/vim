local wk = require("which-key")

wk.register({
  ["<leader>"] = {
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
    ["/"] = {
      function()
        require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
      end,
      "Comment line"
    },
    b = {
      name = "Buffers",
      d = { ":bd<CR>", "Close the current buffer" }
    }
  },
  J = { "mzJ z", "Append line below to the end of current, maintain cursor pos" },
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
  name = "Highlight moving",
  ["<A-k>"] = { "<-2<CR>gv=gv", "Move highlight up" },
  ["<A-j>"] = { ">+1<CR>gv=gv", "Move highlight down" }
}, {
  mode = "v",
})

wk.register({
  name = "Paste over",
  ["<leader>p"] = { mode = "x", "\"_dP", "Paste over highlight without using register" },
}, {
  mode = "x"
})

vim.keymap.set("n", "Q", "<nop>")

-- Make current file executable
-- vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
