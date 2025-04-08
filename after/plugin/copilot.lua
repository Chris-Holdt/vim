local wk = require("which-key")

wk.add({
  { "<M-[>", "<Plug>(copilot-previous)",    desc = "Cycle to previous copilot suggestion" },
  { "<M-]>", "<Plug>(copilot-next)",        desc = "Cycle to next copilot suggestion" },
  { "<M-l>", "<Plug>(copilot-accept-line)", desc = "Accept the next line of the current suggestion" },
  { "<M-.>", "<Plug>(copilot-accept-word)", desc = "Accept the next word of the current suggestion" },
})

vim.g.copilot_filetypes = {
  ["*"] = false,
  typescript = true,
  lua = true,
  javascript = true,
  go = true,
  c = true,
  cpp = true,
  scala = true,
  haskell = true,
  templ = true,
  html = true,
}
