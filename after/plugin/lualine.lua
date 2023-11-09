require('lualine').setup({
  options = {
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diff', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'fileformat', 'filetype', 'filesize' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  },
})
