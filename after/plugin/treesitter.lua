require('nvim-treesitter').setup()

require('nvim-treesitter').install({
  "gomod", "html", "json", "javascript", "typescript",
  "go", "haskell", "rust", "c", "lua", "vim", "vimdoc", "query",
}, { skip_installed = true })

-- Treesitter-based syntax highlighting
vim.api.nvim_create_autocmd("FileType", {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

-- Treesitter-based indentation (experimental)
vim.api.nvim_create_autocmd("FileType", {
  callback = function(ev)
    vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})
