vim.opt.termguicolors = true
vim.opt.number = true                                  -- Print line numbers
vim.opt.relativenumber = true                          -- Print line number relative to the cursor

vim.opt.tabstop = 2                                    -- Number of spaces that a tab takes up
vim.opt.softtabstop = 2                                -- Number of spaces a tab counts for while performing editing operations
vim.opt.shiftwidth = 2                                 -- Number of spaces to use for each step of (auto)indent
vim.opt.expandtab = true                               -- Spaces will be used to fill the amount whitespace of the tab.

vim.opt.smartindent = true                             -- Do smart autoindenting when starting a new line

vim.opt.wrap = false                                   -- Displayed lines will not wrap

vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- List of dirs for undo files
vim.opt.undofile = true                                -- Auto save undo history to an undo file when writing a buffer to a file

vim.opt.hlsearch = false                               -- Highlight previous search matches
vim.opt.incsearch = true                               -- While typing a search, show where the pattern, as so far typed, matches.
vim.opt.smartcase = true                               -- A tab in front of a line inserts blanks according to shiftwidth

vim.opt.scrolloff = 8                                  -- Minimal number of screen lines to keep above and below the cursor
vim.opt.signcolumn = "yes"                             -- Always draw the signcolumn

vim.opt.updatetime = 50                                -- Swap file write time after inactivity

vim.opt.colorcolumn = "80"                             -- A comma separated list of screen columns that are highlighted
vim.opt.cursorline = true                              -- Highlight the text line of the cursor

vim.g.mapleader = " "                                  -- The leader key

-- NETRW config
vim.g.netrw_liststyle = 3 -- Use tree mode of netrw
vim.g.netrw_banner = 0    -- Hide the banner

-- Folding options (UFO)
vim.o.foldcolumn = "1"    -- Number of fold columns to display
vim.o.foldlevel = 99      -- Folds with higherr level will be closed
vim.o.foldlevelstart = 99 -- Sets foldlevel when starting to edit another buffer in a window
vim.o.foldenable = true   -- All folds are closed
vim.o.fillchars = [[foldopen:,foldclose:]]
