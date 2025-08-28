-- Harpoon V2 configuration

local harpoon = require("harpoon")
local harpoon_extensions = require("harpoon.extensions")

local wk = require("which-key")

harpoon:setup()
harpoon:extend(harpoon_extensions.builtins.highlight_current_file())

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
  local file_paths = {}

  for _, item in ipairs(harpoon_files.items) do
    table.insert(file_paths, item.values)
  end

  require("telescope.pickers").new({}, {
    prompt_title = "Harpoon",
    finder = require("telescope.finders").new_table({
      results = file_paths,
    }),
    previewer = conf.file_previewer({}),
    sorter = conf.generic_sorter({}),
  }):find()
end

wk.add({
  { "<A-m>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, desc = "Open Harpoon Quick menu" },

  { "<A-n>", function() harpoon:list():add() end,                         desc = "Add file to Harpoon" },

  { "<A-y>", function() harpoon:list():select(1) end,                     desc = "Switch to Harpoon marker 1" },
  { "<A-u>", function() harpoon:list():select(2) end,                     desc = "Switch to Harpoon marker 2" },
  { "<A-i>", function() harpoon:list():select(3) end,                     desc = "Switch to Harpoon marker 3" },
  { "<A-o>", function() harpoon:list():select(4) end,                     desc = "Switch to Harpoon marker 4" },
  { "<A-p>", function() harpoon:list():select(5) end,                     desc = "Switch to Harpoon marker 5" },

  { "<A-,>", function() harpoon:list():prev() end,                        desc = "Previous Harpoon marker" },
  { "<A-.>", function() harpoon:list():next() end,                        desc = "Next Harpoon marker" },
})




-- Harpoon V1 configuration
--[[ local mark = require("harpoon.mark")
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
}) ]]
