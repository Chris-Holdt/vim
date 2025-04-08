local wk = require("which-key")

wk.add({
  { "<leader>x",  group = "Trouble" },
  { "<leader>xd", "<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",                                     desc = "Toggle Trouble for this Doc" },
  { "<leader>xq", "<cmd>Trouble quickfix toggle<cr>",                                                                desc = "Toggle Trouble Quickfix" },
  { "<leader>xs", "<cmd>Trouble symbols toggle pineed=true results.win.relative=win results.win.position=right<cr>", desc = "Toggle Trouble Symbols" },
  { "<leader>xx", "<cmd>Trouble diagnostics toggle focus=true<cr>",                                                  desc = "Toggle Trouble" },
})
