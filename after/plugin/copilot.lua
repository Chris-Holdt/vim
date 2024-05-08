local wk = require("which-key")

wk.register({
  ["<M-]>"] = { "<Plug>(copilot-next)", "Cycle to next copilot suggestion" },
  ["<M-[>"] = { "<Plug>(copilot-previous)", "Cycle to previous copilot suggestion" },
  ["<M-w>"] = { "<Plug>(copilot-accept-word)", "Accept the next word of the current suggestion" },
  ["<M-l>"] = { "<Plug>(copilot-accept-line)", "Accept the next line of the current suggestion" },
})
