function MakePrettyColours(colour)
  colour = colour or "spacerain"
  vim.cmd.colorscheme(colour)


  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

MakePrettyColours()
