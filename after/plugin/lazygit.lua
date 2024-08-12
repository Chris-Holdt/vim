local wk = require("which-key")

wk.add({
  { "<leader><leader>g",  group = "git",      name = "Git" },
  { "<leader><leader>gg", "<Cmd>LazyGit<CR>", { group = "git", name = "Open LazyGit" } }
})
