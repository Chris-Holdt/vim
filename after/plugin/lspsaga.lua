local wk = require("which-key")
local saga = require("lspsaga")

saga.setup({
  outline = {
    auto_preview = false,
  }
})

wk.add({
  { "K",  "<cmd>Lspsaga hover_doc<CR>",   desc = "Hover definition" },
  { "ga", "<cmd>Lspsaga code_action<CR>", desc = "Code action" },
  { "go", "<cmd>Lspsaga outline<CR>",     desc = "Outline" }
})
