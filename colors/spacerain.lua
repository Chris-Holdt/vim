-- You probably always want to set this in your vim file

local colors = {
    -- PATCH_OPEN
Normal = {fg = "#F6F4FB", bg = "#2D2541"},
Boolean = {fg = "#D6FF5C"},
Comment = {fg = "#597882"},
Conceal = {bg = "#4B5558"},
Constant = {fg = "#F7E37E"},
Cursor = {fg = "#2D2541", bg = "#F6F4FB"},
CursorLine = {bg = "#4F4171"},
CursorLineNr = {fg = "#F6F4FB"},
DiagnosticError = {fg = "#F31630"},
DiagnosticHint = {fg = "#F6F4FB"},
DiagnosticInfo = {fg = "#8AEFFF"},
DiagnosticUnderlineError = {fg = "#F31630", underline = true},
DiagnosticUnderlineHint = {fg = "#F6F4FB", underline = true},
DiagnosticUnderlineInfo = {fg = "#8AEFFF", underline = true},
DiagnosticUnderlineWarn = {fg = "#F5A742", underline = true},
DiagnosticWarn = {fg = "#F5A742"},
DiffAdd = {bg = "#426BFF"},
DiffChange = {bg = "#61508B"},
DiffDelete = {bg = "#FF576D"},
DiffText = {bg = "#F31630"},
Directory = {fg = "#8AEFFF"},
ErrorMsg = {fg = "#FFFFFF", bg = "#F31630"},
Function = {fg = "#9EED73"},
Identifier = {fg = "#FF576D", bold = true},
Label = {},
LineNr = {fg = "#A08573"},
MatchParen = {fg = "#8AEFFF", bg = "#BB8AFF"},
ModeMsg = {fg = "#BB8AFF"},
NonText = {fg = "#426BFF"},
NormalFloat = {fg = "#F6F4FB", bg = "#61508B"},
Number = {fg = "#8AEFFF"},
Pmenu = {fg = "#F6F4FB", bg = "#61508B"},
PreProc = {fg = "#BB8AFF"},
Question = {fg = "#9EED73"},
QuickFixLine = {fg = "#1C1717", bg = "#F7E37E"},
Search = {fg = "#1C1717", bg = "#F7E37E"},
Special = {fg = "#BB8AFF", bold = true},
SpecialChar = {fg = "#9EED73", italic = true},
SpecialKey = {fg = "#8AEFFF"},
Statement = {fg = "#FF576D"},
StatusLine = {fg = "#F6F4FB", bg = "#61508B"},
Substitute = {fg = "#1C1717", bg = "#F7E37E"},
TabLine = {fg = "#1C1717", bg = "#F7E37E"},
TabLineFill = {fg = "#1C1717", bg = "#F7E37E"},
TabLineSel = {bg = "#8AEFFF"},
Title = {fg = "#BB8AFF"},
Todo = {fg = "#4B5558", bg = "#F5A742"},
Type = {fg = "#8AEFFF"},
VertSplit = {fg = "#8AEFFF", bg = "#8AEFFF"},
Visual = {fg = "#F5A742", bg = "#4F4171"},
WarningMsg = {fg = "#F31630"},
Whitespace = {fg = "#61508B"},
WildMenu = {fg = "#4B5558", bg = "#F7E37E"},
Winseparator = {fg = "#BB8AFF", bg = "#483C68"},
goFormatSpecifier = {fg = "#BB8AFF"},
goFunctionCall = {fg = "#BB8AFF"},
lCursor = {fg = "#2D2541", bg = "#F6F4FB"},
    -- PATCH_CLOSE
}

vim.cmd("highlight clear")
vim.cmd("set t_Co=256")
vim.cmd("let g:colors_name='spacerain'")

for group, attrs in pairs(colors) do
    vim.api.nvim_set_hl(0, group, attrs)
end

-- vim.opt.background = 'dark'
-- vim.g.colors_name = 'spacerain'

-- By setting our module to nil, we clear lua's cache,
-- which means the require ahead will *always* occur.
--
-- This isn't strictly required but it can be a useful trick if you are
-- incrementally editing your config a lot and want to be sure your themes
-- changes are being picked up without restarting neovim.
--
-- Note if you're working in on your theme and have :Lushify'd the buffer,
-- your changes will be applied with our without the following line.
--
-- The performance impact of this call can be measured in the hundreds of
-- *nanoseconds* and such could be considered "production safe".
-- package.loaded['lush_theme.spacerain'] = nil

-- include our theme file and pass it to lush to apply
-- require('lush')(require('lush_theme.spacerain'))
