local wk = require("which-key")

require('gitsigns').setup {
  signcolumn = true,
  current_line_blame = true
}

wk.add(
  {
    { "<leader><leader>g",  group = "git",                     name = "Git" },
    { "<leader><leader>gh", "<Cmd>Gitsigns toggle_linehl<CR>", group = "git", name = "Toggle highlights" }
  }
)
