vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('user_lsp_attach', {clear = true}),
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('n', '<leader>vws', function() vim.lsp.buf.workspace_symbol() end, opts)
    vim.keymap.set('n', '<leader>vd', function() vim.diagnostic.open_float() end, opts)
    vim.keymap.set('n', '[d', function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set('n', ']d', function() vim.diagnostic.goto_prev() end, opts)
    vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', '<leader>vrr', function() vim.lsp.buf.references() end, opts)
    vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)
    vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
  end,
})

local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

require('mason').setup({})
require('mason-lspconfig').setup({
  ensure_installed = {'tsserver', 'rust_analyzer'},
  handlers = {
    function(server_name)
      require('lspconfig')[server_name].setup({
        capabilities = lsp_capabilities,
      })
    end,
    lua_ls = function()
      require('lspconfig').lua_ls.setup({
        capabilities = lsp_capabilities,
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT'
            },
            diagnostics = {
              globals = {'vim'},
            },
            workspace = {
              library = {
                vim.env.VIMRUNTIME,
              }
            }
          }
        }
      })
    end,
  }
})

local cmp = require('cmp')
local cmp_select = {behavior = cmp.SelectBehavior.Select}

-- this is the function that loads the extra snippets to luasnip
-- from rafamadriz/friendly-snippets
require('luasnip.loaders.from_vscode').lazy_load()

cmp.setup({
  sources = {
    {name = 'path'},
    {name = 'nvim_lsp'},
    {name = 'luasnip', keyword_length = 2},
    {name = 'buffer', keyword_length = 3},
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
})

--[[ local lsp = require('lsp-zero')

lsp.on_attach(function(client, bufnr)
 lsp.default_keymaps({ buffer = bufnr })
end)--]]


-- lsp.configure('templ_ls', {
--   cmd = { 'templ-language-server' },
--   filetypes = { 'templ', 'tmpl' },
-- })
-- 
--[[ local cmp = require('cmp')
cmp.setup({
  snippet = {
  expand = function(args)
    require('luasnip').lsp_expand(args.body)
  end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<Tab>'] = nil,
    ['<S-Tab>'] = nil,
  })
})--]]

-- lsp.setup_nvim_cmp()

-- local cmp_select = { behavior = cmp.SelectBehavior.Select }
-- local cmp_mappings = lsp.defaults.cmp_mappings({
  --[[ ['<C-j>'] = cmp.mapping.select_prev_item(cmp_select),
  ['<C-k>'] = cmp.mapping.select_next_item(cmp_select), ]]
--  ['<C-y>'] = cmp.mapping.confirm({ select = true }),
--  ["<C-Space>"] = cmp.mapping.complete(),
-- })

--[[ cmp_mappings['<Tab>'] = nil
cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
 mapping = cmp_mappings
})

lsp.setup() ]]
--[[ lsp.configure('lua_ls', {
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
}) ]]

-- lsp.setup()

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
