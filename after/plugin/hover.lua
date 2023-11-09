local wk = require("which-key")
local hover = require("hover")

hover.setup {
  init = function()
    require("hover.providers.lsp")
  end,
  preview_opts = {
    border = nil,
  },
  preview_window = false,
  title = true
}

wk.register({
  name = "Hover",
  K = {
    function()
      hover.hover()
    end,
    "Hover"
  },
  gK = {
    function()
      hover.hover_select()
    end,
    "Hover Select"
  },
  mode = "n"
})
