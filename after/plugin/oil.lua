local oil = require("oil")
local wk = require("which-key")

oil.setup({
  default_file_explorer = false,
  -- Id is automatically added at the beginning of the list
  columns = {
    "icon",
    "permissions",
    "size",
    "mtime",
  },
  -- Buffer-local options to use for oil buffers
  buf_options = {
    buflisted = false,
    modifiable = false,
    swapfile = false,
  },
  -- Window-local options to use for oil buffers
  win_options = {
    wrap = false,
    signcolumn = "no",
    cursorcolumn = true,
    foldcolumn = "0",
    spell = false,
    list = false,
  },
})

wk.add({
  { "<leader>o", "<cmd>Oil<cr>", desc = "Open Oil" },
})
