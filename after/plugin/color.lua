function MakePrettyColours(colour)
  colour = colour or "sonokai"
  vim.cmd.colorscheme(colour)
end

-- Default fallback; Themery will override with its saved theme when it runs
MakePrettyColours()
