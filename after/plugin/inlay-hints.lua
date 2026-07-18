vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
  end,
})

local toggle_inlay = function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
end

local disable = function()
  vim.lsp.inlay_hint.enable(false)
end

local enable = function()
  vim.lsp.inlay_hint.enable(true)
end

local wk = require("which-key")

wk.add({
  { "<leader>pd", disable,      desc = "Disable Inlay Hints" },
  { "<leader>pe", enable,       desc = "Enable Inlay Hints" },
  { "<leader>pt", toggle_inlay, desc = "Toggle Inlay Hints" },

})

vim.lsp.config('gopls', {
  settings = {
    gopls = {
      hints = {
        rangeVariableTypes = true,
        parameterNames = true,
        constantValues = true,
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        functionTypeParameters = true,
      },
    }
  }
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = { "vim", "use", "Snacks" },
      },
      hint = {
        enable = true
      }
    }
  }
})

vim.lsp.config('svelte', {
  settings = {
    typescript = {
      inlayHints = {
        parameterNames = { enabled = 'all' },
        parameterTypes = { enabled = true },
        variableTypes = { enabled = true },
        propertyDeclarationTypes = { enabled = true },
        functionLikeReturnTypes = { enabled = true },
        enumMemberValues = { enabled = true },
      },
    },
  },
})

vim.lsp.config('kotlin_language_server', {
  settings = {
    kotlin = {
      hints = {
        typeHints = true,
        parameterHints = true,
        chaineHints = true,
      },
    },
  }
})

vim.lsp.config('zls', {
  settings = {
    zls = {
      enable_inlay_hints = true,
      inlay_hints_show_builtin = true,
      inlay_hints_exclude_single_argument = true,
      inlay_hints_hide_redundant_param_names = false,
      inlay_hints_hide_redundant_param_names_last_token = false,
    },
  }
})

vim.lsp.config('csharp_ls', {
  settings = {
    csharp = {
      inlayHints = {
        parameterNames = "all",
        parameterTypes = true,
        variableTypes = true,
        propertyDeclarationTypes = true,
        functionLikeReturnTypes = true,
        enumMemberValues = true,
      },
    },
  }
})

vim.lsp.config('ts_ls', {
  settings = {
    ['ts_ls'] = {},
  }
})

vim.lsp.config('htmx', {
  filetypes = { "templ" },
})
