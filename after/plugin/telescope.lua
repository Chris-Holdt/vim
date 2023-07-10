
local builtin = require('telescope.builtin')

require('telescope').load_extension('fzf')

-- Show undo tree
vim.keymap.set('n', '<leader>u', "<Cmd> Telescope undo <CR>", {})

-- If I can't remember what this does, I shouldn't be allowed to touch
-- a computer again
vim.keymap.set('n', '<leader>fk', builtin.keymaps, {})

-- Project local files
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})

-- Previously open files
vim.keymap.set('n', '<leader>fo', builtin.oldfiles, {})

-- Files in git project, excluding any in gitignore
vim.keymap.set('n', '<leader>gf', builtin.git_files, {})

-- Grep for files
vim.keymap.set('n', '<leader>sf', builtin.live_grep, {})

-- Open buffers
vim.keymap.set('n', '<leader>bf', builtin.buffers, {})

-- LSP References, shows definition and usages
vim.keymap.set('n', '<leader>lf', builtin.lsp_references, {})

-- LSP Diagnostics, errors, warnings, suggestions
vim.keymap.set('n', '<leader>df', builtin.diagnostics, {})

-- Run make and open telescope quickfix
vim.keymap.set("n", "<A-m>", ":make!<CR>:Telescope quickfix<CR>")
-- Shows quickfix items
vim.keymap.set('n', '<leader>qf', builtin.quickfix, {})

-- Items in registers
vim.keymap.set('n', '<leader>rf', builtin.registers, {})

-- Fuzzy find across the current buffer
vim.keymap.set('n', '<leader>ff', builtin.current_buffer_fuzzy_find, {})
