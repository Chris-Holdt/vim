-- Orgmode config
require('orgmode').setup({
  org_agenda_files = '~/orgfiles/**/*',
  org_default_notes_file = '~/orgfiles/refile.org',
})

-- Using telescope with orgmode
require("telescope").load_extension("orgmode")

local wk = require("which-key")
local tele = require("telescope")

local function refile_heading()
  tele.extensions.orgmode.refile_heading()
end

local function search_headings()
  tele.extensions.orgmode.search_headings()
end

local function insert_link()
  tele.extensions.orgmode.insert_link()
end

wk.add({
  { "<leader>o",  group = "Orgmode" },
  { "<leader>oo", refile_heading,   desc = "Refile heading",  mode = "n" },
  { "<leader>oh", search_headings,  desc = "Search headings", mode = "n" },
  { "<leader>ol", insert_link,      desc = "Insert link",     mode = "n" },
})
