local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

local wk = require("which-key")

wk.register({
  ["<leader>h"] = {
    name = "Harpoon",
    a = { mark.add_file, "Add file to Harpoon" },
    m = { ui.toggle_quick_menu, "Open Harpoon Quick menu" },
  },
  ["<A-m>"] = { ui.toggle_quick_menu, "Open Harpoon Quick menu" },
  ["<A-y>"] = { function() ui.nav_file(1) end, "Switch to Harpoon marker 1" },
  ["<A-u>"] = { function() ui.nav_file(2) end, "Switch to Harpoon marker 2" },
  ["<A-i>"] = { function() ui.nav_file(3) end, "Switch to Harpoon marker 3" },
  ["<A-o>"] = { function() ui.nav_file(4) end, "Switch to Harpoon marker 4" },
  ["<A-p>"] = { function() ui.nav_file(5) end, "Switch to Harpoon marker 5" },
})
