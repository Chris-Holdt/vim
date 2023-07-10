local builtin = require('telescope.builtin')

require('telescope').load_extension('fzf')

local wk = require("which-key")

wk.register({
  ["<leader>"] = {
    u = { "<Cmd> Telescope undo <CR>", "Show undo tree" },
    f = {
      name = "Telescopy",
      k = { builtin.keymaps, "List keymaps" },
      p = { builtin.find_files, "List local project files" },
      o = { builtin.oldfiles, "List previosuly open files" },
      g = { builtin.git_files, "List git project files, ignores files in gitignore" },
      s = { builtin.live_grep, "Grep search in files" },
      b = { builtin.buffers, "List open buffers" },
      l = { builtin.lsp_references, "LSP References, lists defs and uses" },
      d = { builtin.diagnostics, "Show diagnostics" },
      q = { builtin.quickfix, "Show quickfix items" },
      r = { builtin.registers, "Show registers" },
      f = { builtin.current_buffer_fuzzy_find, "Fuzzy find across the current buffer" },
      m = { ":make!<CR>:Telescope quickfix<CR>", "Run make and show quickfix list" },
    }
  }
})
