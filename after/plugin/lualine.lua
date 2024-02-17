-- Show macro recording status in statusline
local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return "Recording @" .. recording_register
  end
end

-- Show/hide recording message faster
vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function()
    require('lualine').refresh({
      place = { "statusline" }
    })
  end
})

vim.api.nvim_create_autocmd("RecordingLeave", {
  callback = function()
    local timer = vim.loop.new_timer()
    timer:start(
      50,
      0,
      vim.schedule_wrap(function()
        require('lualine').refresh({
          place = { "statusline" }
        })
      end)
    )
  end
})

local function get_current_file()
  local current_file = vim.fn.split(
    vim.api.nvim_buf_get_name(0), "/"
  )
  current_file = current_file[#current_file]

  return current_file
end

local function harpoon_file()
  local harpoon = require("harpoon")

  local mark_table = harpoon.get_mark_config()["marks"]
  local current_file = get_current_file()

  local resp = {}

  table.insert(resp, "⇁ ")
  for k, v in pairs(mark_table) do
    local file = vim.fn.split(v['filename'], "/")
    file = file[#file]
    file = file == current_file and file .. "*" or file .. " "
    table.insert(resp, " " .. k .. " " .. file)
  end
  table.insert(resp, " ↽")

  return table.concat(resp)
end



require('lualine').setup({
  options = {
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics', show_macro_recording },
    lualine_c = { 'filename', harpoon_file },
    lualine_x = { 'fileformat', 'filetype', 'filesize' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
})
