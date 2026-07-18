require("gh-actions-notify").setup({
  poll_interval = 30000,
  limit         = 15,
})

require("which-key").add({
  { "<leader>g",  group = "GitHub Actions" },
  { "<leader>ga", "<cmd>GhActionsFloat<cr>",  desc = "Show runs" },
  { "<leader>gA", "<cmd>GhActionsNotify<cr>", desc = "Toggle notifications" },
  { "<leader>gc", "<cmd>GhActionsClear<cr>",  desc = "Clear notifications" },
  { "<leader>gl", "<cmd>GhActionsPeek<cr>",   desc = "Peek latest" },
})
