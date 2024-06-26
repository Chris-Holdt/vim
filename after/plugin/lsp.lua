local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({ buffer = bufnr })
end)

lsp.configure('lua_ls', {
  cmd = { 'lua-language-server' },
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = vim.split(package.path, ';'),
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = {
          [vim.fn.expand('$VIMRUNTIME/lua')] = true,
          [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
        },
      },
    },
  },
})

lsp.configure('templ_ls', {
  cmd = { 'templ-language-server' },
  filetypes = { 'templ', 'tmpl' },
})

local cmp = require('cmp')
-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
  --[[ ['<C-j>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-k>'] = cmp.mapping.select_next_item(cmp_select), ]]
  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
  ["<C-Space>"] = cmp.mapping.complete(),
})

cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

lsp.setup()

-- lsp.new_server({
--   name = "godot",
--   force_setup = true,
--   single_file_support = false,
--   cmd = {
--     "ncat", "127.0.0.1", "6008"
--   },
--   root_dir = require("lspconfig.util").root_pattern("project.godot", ".git"),
--   filetypes = {
--     "gd", "gdscript", "gdscript3"
--   },
-- })
