local wk = require("which-key")

wk.register({
  ["<leader>g"] = {
    name = "Git",
    g = { "<Cmd>LazyGit<CR>", "Open LazyGit" }
  }
})
