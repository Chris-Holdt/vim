local builtin = require('telescope.builtin')
local actions = require('telescope.actions')
local toggle_preview = require('telescope.actions.layout').toggle_preview
local extensions = require('telescope').extensions


require('telescope').setup {
  defaults = {
    winblend = 30,

    preview = {
      hide_on_startup = false,
      file_ignore_patterns = { ".git/", "node_modules", "*_templ.go" },
    },

    layout_config = {
      height = 80,
      width = 0.9,
    },

    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<M-p>"] = toggle_preview,
      },
      n = {
        ["<M-p>"] = toggle_preview
      },
    }
  },

  pickers = {
    lsp_references = {
      previewer = true,
      theme = "cursor",
      layout_config = {
        height = 30,
        width = 0.4,
      },
      jump_type = "never",
    },
    lsp_definitions = {
      previewer = true,
      theme = "cursor",
      layout_config = {
        height = 30,
        width = 0.4,
      },
    },
    buffers = {
      show_all_buffers = true,
      previewer = true,
      mappings = {
        i = {
          ["<C-b>"] = actions.delete_buffer,
        },
        n = {
          ["<C-b>"] = actions.delete_buffer,
        }
      }
    }
  }

}

pcall(require('telescope').load_extension, 'fzf')
pcall(require('telescope').load_extension, 'live_grep_args')
-- require('telescope').load_extension('undo')
local wk = require("which-key")

-- local symbols = "<cmd>:Telescope lsp_document_symbols theme=dropdown symbols={'function', 'method'}<CR>"
local function showSymbols()
  local opts = {
    symbols = { "function", "method" },
    symbol_width = 80,
    layout_config = {
      height = 0.8,
      width = 0.9,
    },
  }
  local theme = require("telescope.themes").get_ivy(opts)

  builtin.lsp_document_symbols(theme)
end

wk.add({
  { "<leader>f",     group = "Telescopy" },
  { "<leader>f<CR>", builtin.resume,                            desc = "Resume last search" },
  { "<leader>fb",    builtin.buffers,                           desc = "List open buffers" },
  { "<leader>fc",    builtin.grep_string,                       desc = "Grep search for string under cursor in CWD" },
  { "<leader>fd",    builtin.diagnostics,                       desc = "Show diagnostics" },
  { "<leader>ff",    builtin.current_buffer_fuzzy_find,         desc = "Fuzzy find across the current buffer" },
  { "<leader>fg",    builtin.git_files,                         desc = "List git project files, ignores files in gitignore" },
  { "<leader>fk",    builtin.keymaps,                           desc = "List keymaps" },
  { "<leader>fl",    builtin.lsp_references,                    desc = "LSP References, lists defs and uses" },
  { "<leader>fm",    ":make!<CR>:Telescope quickfix<CR>",       desc = "Run make and show quickfix list" },
  { "<leader>fo",    builtin.oldfiles,                          desc = "List previosuly open files" },
  { "<leader>fp",    builtin.find_files,                        desc = "List local project files" },
  { "<leader>fq",    builtin.quickfix,                          desc = "Show quickfix items" },
  { "<leader>fr",    builtin.registers,                         desc = "Show registers" },
  { "<leader>fj",    showSymbols,                               desc = "Show Symbols" },
  { "<leader>fs",    extensions.live_grep_args.live_grep_args,  desc = "Grep search in files" },
  { "<leader>ft",    ":TodoTelescope<CR>",                      desc = "List Todos" },
  { "<leader>u",     "<Cmd> Telescope undo theme=dropdown<CR>", desc = "Show undo tree" },
  { "gd",            builtin.lsp_definitions,                   desc = "[G]oto [D]efinitions" },
  { "gr",            builtin.lsp_references,                    desc = "[G]oto [R]eference" },
})
