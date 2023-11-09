local highlight = {
  "RainbowRed",
  "RainbowYellow",
  "RainbowBlue",
  "RainbowOrange",
  "RainbowGreen",
  "RainbowViolet",
  "RainbowCyan",
}

local hooks = require "ibl.hooks"
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#FF576D" })
  vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#F7E37E" })
  vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#6296f0" })
  vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#F5A742" })
  vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#9EED73" })
  vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#BB8AFF" })
  vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#8AEFFF" })
  vim.api.nvim_set_hl(0, "IblScope", { fg = "#BB8AFF" })
end)

vim.g.rainbow_delimiters = { highlight = highlight }

require("ibl").setup {
  indent = {
    -- highlight = highlight
  },
  scope = {
    -- highlight = highlight,
    enabled = true,
    show_start = true,
    show_end = false,
    show_exact_scope = false,
    priority = 128,
  }
}

hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
