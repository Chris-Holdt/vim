local wk = require("which-key")

require("aerial").setup({
  -- optionally use on_attach to set keymaps when aerial has attached to a buffer
  on_attach = function(bufnr)
    -- Jump forwards/backwards with '{' and '}'
    vim.keymap.set("n", "{", "<cmd>AerialPrev<CR>", { buffer = bufnr })
    vim.keymap.set("n", "}", "<cmd>AerialNext<CR>", { buffer = bufnr })
    wk.add({
      { "{", desc = "Aerial Previous" },
      { "}", desc = "Aerial Next" },
    })


    -- vim.api.nvim_set_option_value("relativenumber", true, { buf = bufnr })
    -- vim.opt_local.set(bufnr, { relativenumber = true })

    -- vim.opt_local.set(bufnr, { relativenumber = true })
    --
    --[[ vim.wo.relativenumber = true

    for _, win in ipairs(vim.api.nvim_list_wins()) do
      if vim.api.nvim_win_get_buf(win) == bufnr then
        print("Setting relative number for window: " .. win)
        vim.api.nvim_set_option_value("relativenumber", true, { win = win })
        -- vim.opt.relativenumber = true
      end
    end ]]
  end,

  highlight_mode = "full_width"
})

wk.add({
  -- { "<leader>a", group = "Aerial" },
  { "<leader>a", "<cmd>AerialToggle!<CR>", desc = "Toggle Aerial Symbol outline" },
})
