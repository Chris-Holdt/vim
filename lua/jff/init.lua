require("jff.plugin-manager")
require("jff.set")
require("lazy").setup("jff.plugins")
require("jff.mapping")

require 'lspconfig'.gdscript.setup {}

vim.filetype.add({ extension = { templ = "templ" } })

require 'lspconfig'.html.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "templ", "tmpl" },
})

require 'lspconfig'.htmx.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "html", "templ", "tmpl" },
})

require 'lspconfig'.tailwindcss.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "tmpl", "html", "templ", "javascript", "typescript" },
  init_options = { userLanguages = { templ = "html" } },
})
