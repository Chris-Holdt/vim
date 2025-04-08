local wk = require("which-key")

require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    wk.add({
      { "{", desc = "Aerial Previous" },
      { "}", desc = "Aerial Next" },
    })
  end,
})

wk.add({
  { "<leader>a", group = "Aerial" },
  { "<leader>a", "<cmd>AerialToggle!<CR>", desc = "Toggle Aerial Symbol outline" },
})
