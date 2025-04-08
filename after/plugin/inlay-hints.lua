if not vim.lsp.inlay_hint.is_enabled() then
  vim.lsp.inlay_hint.enable(true)
end

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

require("lspconfig").lua_ls.setup({
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = { "vim", "use" },
      },
      hint = {
        enable = true
      }
    }
  }
})

require("lspconfig").gopls.setup({
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

require("lspconfig").ts_ls.setup({
  settings = {
    typescript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
    javascript = {
      inlayHints = {
        includeInlayParameterNameHints = "all",
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  }
})

require('lspconfig').svelte.setup {
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
}

require("lspconfig").kotlin_language_server.setup({
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

require("lspconfig").zls.setup({
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

require("lspconfig").csharp_ls.setup({
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

--[[ require("lspconfig").omnisharp.setup({
  settings = {
    RoslynExtensionsOptions = {
      InlayHintsOptions = {
        EnableForParameters = true,
        ForLiteralParameters = true,
        ForIndexerParameters = true,
        ForObjectCreationParameters = true,
        ForOtherParameters = true,
        SuppressForParametersThatDifferOnlyBySuffix = false,
        SuppressForParametersThatMatchMethodIntent = false,
        SuppressForParametersThatMatchArgumentName = false,
        EnableForTypes = true,
        ForImplicitVariableTypes = true,
        ForLambdaParameterTypes = true,
        ForImplicitObjectCreatio = true,
      },
    },
  }
}) ]]


require("lspconfig").htmx.setup({
  filetypes = { "templ" },
})
