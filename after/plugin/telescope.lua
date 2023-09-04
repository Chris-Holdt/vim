local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local toggle_preview = require('telescope.actions.layout').toggle_preview

require('telescope').load_extension('fzf')

require('telescope').setup {
  defaults = {
    winblend = 30,

    preview = {
      hide_on_startup = true,
      file_ignore_patters = { ".git/", "node_modules" },
    },

    layout_config = {
      height = 80,
      width = 0.9,
    },

    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<M-p>"] = toggle_preview
      },
      n = {
        ["<M-p>"] = toggle_preview
      },
    }
  },

  -- pickers = {
  --   diagnostics = {
  --     theme = "ivy",
  --   },
  --   quickfix = {
  --     theme = "ivy",
  --   },
  --   keymaps = {
  --     theme = "ivy",
  --   },
  -- }
}

local wk = require("which-key")

wk.register({
  ["<leader>"] = {
    u = { "<Cmd> Telescope undo theme=dropdown<CR>", "Show undo tree" },
    f = {
      name = "Telescopy",
      k = { builtin.keymaps, "List keymaps" },
      p = { builtin.find_files, "List local project files" },
      o = { builtin.oldfiles, "List previosuly open files" },
      g = { builtin.git_files, "List git project files, ignores files in gitignore" },
      s = { builtin.live_grep, "Grep search in files" },
      c = { builtin.grep_string, "Grep search for string under cursor in CWD" },
      b = { builtin.buffers, "List open buffers" },
      l = { builtin.lsp_references, "LSP References, lists defs and uses" },
      d = { builtin.diagnostics, "Show diagnostics" },
      q = { builtin.quickfix, "Show quickfix items" },
      r = { builtin.registers, "Show registers" },
      f = { builtin.current_buffer_fuzzy_find, "Fuzzy find across the current buffer" },
      m = { ":make!<CR>:Telescope quickfix<CR>", "Run make and show quickfix list" },
      ["<CR>"] = { builtin.resume, "Resume last search" }
    }
  }
})
