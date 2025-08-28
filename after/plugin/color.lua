function MakePrettyColours(colour)
  -- colour = colour or "spacerain"
  colour = colour or "catppuccin-macchiato"
  vim.cmd.colorscheme(colour)
end

-- Using Themery now, this isn't needed right now
-- MakePrettyColours()
