local wk = require("which-key")

wk.register({
  ["<leader>x"] = {
    name = "Trouble",
    x = { "<cmd>Trouble diagnostics toggle focus=true<cr>", "Toggle Trouble" },
    q = { "<cmd>Trouble quickfix toggle<cr>", "Toggle Trouble Quickfix" },
    d = { "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>", "Toggle Trouble for this Doc" },
    -- w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "Toggle Trouble for this Workspace" },
    -- r = { "<cmd>TroubleRefresh", "Refresh Trouble" },
    -- t = { ":TodoTrouble<cr>", "Toggle Trouble Todos" }
    s = { "<cmd>Trouble symbols toggle pineed=true results.win.relative=win results.win.position=right"}
  }
})
