-- Open explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Save file
vim.keymap.set("n", "<leader>w", "<Cmd>w<CR>")

-- Quick add comment
vim.keymap.set("n", "<leader>/",
function()
    require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
end)

-- vim.keymap.set("n", "", "")

-- Append line below to end of this line, maintain cursor position
vim.keymap.set("n", "J", "mzJ`z")

-- Paste over highlight without losing date in register
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Enter system register mode for easy copying 
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

vim.keymap.set("n", "Q", "<nop>")

vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end)

-- Make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true } )

-- Center on big moves
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Move lines up and down
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==")
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==")
vim.keymap.set("v", "<A-k>", "<-2<CR>gv=gv")
vim.keymap.set("v", "<A-j>", ">+1<CR>gv=gv")
