local wk = require("which-key")

require('aerial').setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
    vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })

    layout = {
      max_width = 60,
      min_width = 30
    }
  end
})

wk.register({
  ["<leader>a"] = {
    name = "Aerial",
    t = { "<cmd>AerialToggle!<CR>", "Toggle Aerial Symbol outline" } }
})
