local wk = require("which-key")

require('gitsigns').setup {
  signcolumn = true,
  current_line_blame = true
}

wk.register({
  ["<leader>g"] = {
    h = { "<cmd>Gitsigns toggle_linehl<CR>", "Toggle highlights" }
  }
})
