local snipe = require("snipe")

local function snipe_open()
  snipe.open_buffer_menu()
end

local wk = require("which-key")
wk.add({
  { "gs", snipe_open, desc = "Open Snipe buffer menu" },
})
