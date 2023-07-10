local wk = require("which-key")

wk.register({
  ["<leader>x"] = {
    name = "Trouble",
    x = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "Toggle Trouble Quickfix" }
  }
})
