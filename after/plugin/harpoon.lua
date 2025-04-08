local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

local wk = require("which-key")

wk.add({
  { "<leader>h",  group = "Harpoon" },
  { "<leader>ha", mark.add_file,                 desc = "Add file to Harpoon" },
  { "<leader>hm", ui.toggle_quick_menu,          desc = "Open Harpoon Quick menu" },
  { "<A-m>",      ui.toggle_quick_menu,          desc = "Open Harpoon Quick menu" },
  { "<A-y>",      function() ui.nav_file(1) end, desc = "Switch to Harpoon marker 1" },
  { "<A-u>",      function() ui.nav_file(2) end, desc = "Switch to Harpoon marker 2" },
  { "<A-i>",      function() ui.nav_file(3) end, desc = "Switch to Harpoon marker 3" },
  { "<A-o>",      function() ui.nav_file(4) end, desc = "Switch to Harpoon marker 4" },
  { "<A-p>",      function() ui.nav_file(5) end, desc = "Switch to Harpoon marker 5" },
})
