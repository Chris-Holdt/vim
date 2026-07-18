local nt = require("neo-tree")
local wk = require("which-key")

nt.setup({
  close_if_last_window = false,
  event_handlers = {
    {
      event = "neo_tree_window_after_open",
      handler = function(args)
        vim.wo[args.winid].relativenumber = true
      end,
    },
  },
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
    },
  },
})

wk.add({
  { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "Toggle Neotree" },
})


