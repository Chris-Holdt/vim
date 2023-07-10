local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

local wk = require("which-key")

wk.register({
  ["<leader>aa"] = { mark.add_file, "Add file to Harpoon" },
  ["<A-m>"] = { ui.toggle_quick_menu, "Open Harpoon Quick menu" },
  ["<A-q>"] = { function() ui.nav_file(1) end, "Switch to Harpoon marker 1" },
  ["<A-w>"] = { function() ui.nav_file(2) end, "Switch to Harpoon marker 2" },
  ["<A-e>"] = { function() ui.nav_file(3) end, "Switch to Harpoon marker 3" },
  ["<A-r>"] = { function() ui.nav_file(4) end, "Switch to Harpoon marker 4" },
})
