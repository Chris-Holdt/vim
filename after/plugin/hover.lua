--[[ local wk = require("which-key")
local hover = require("hover")

hover.setup {
  init = function()
    require("hover.providers.lsp")
    require("hover.providers.gh")
    require("hover.providers.gh_user")
    require("hover.providers.dap")
    require("hover.providers.dictionary")
  end,
  preview_opts = {
    border = nil,
  },
  preview_window = false,
  title = true,
  keymaps = {
    scroll_down = "<C-d>",
    scroll_up = "<C-u>",
  },
}

wk.add({
  { "K",  hover.hover,        desc = "Hover" },
  { "gK", hover.hover_select, desc = "Hover Select" },
}) ]]
