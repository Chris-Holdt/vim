local g = require('go')

-- NOTE: LSP configuration is handled in lsp.lua
-- Inlay hints are handled in inlay-hints.lua

g.setup({
  lsp_inlay_hints = { enable = true },
})

local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require('go.format').goimports()
  end,
  group = format_sync_grp,
})

