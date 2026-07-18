local wk = require("which-key")

vim.opt.list = true
vim.opt.listchars = {
  space = "•",
  tab = "→ ",
  trail = "·",
  extends = "»",
  precedes = "«",
  nbsp = "␣",
}

local toggle_spacechars = function()
  local lcs = vim.opt.listchars:get()
  if lcs.space then
    vim.opt.listchars:remove("space")
  else
    vim.opt.listchars:append({ space = "•" })
  end

  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      vim.api.nvim_buf_call(buf, function()
        vim.opt_local.listchars = vim.opt.listchars:get()
      end)
    end
  end
end

wk.add({
  { "<leader>hl", toggle_spacechars, desc = "Toggle Space Chars" },
})
