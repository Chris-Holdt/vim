local wk = require("which-key")

wk.register({
  ["<leader>x"] = {
    name = "Trouble",
    x = { "<cmd>TroubleToggle<cr>", "Toggle Trouble" },
    q = { "<cmd>TroubleToggle quickfix<cr>", "Toggle Trouble Quickfix" },
    d = { "<cmd>TroubleToggle document_diagnostics<cr>", "Toggle Trouble for this Doc" },
    w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Toggle Trouble for this Workspace" },
    r = { "<cmd>TroubleRefresh", "Refresh Trouble" },
    t = { ":TodoTrouble<cr>", "Toggle Trouble Todos" }
  }
})
