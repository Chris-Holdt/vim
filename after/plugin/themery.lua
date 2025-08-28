local themery = require("themery")

local function get_available_themes()
  local themes = {}

  local vim_theme_files = vim.api.nvim_get_runtime_file("colors/*.vim", true)
  local lua_theme_files = vim.api.nvim_get_runtime_file("colors/*.lua", true)
  local all_theme_files = vim.list_extend(vim_theme_files, lua_theme_files)

  for _, file in ipairs(all_theme_files) do
    local theme_name = file:match("([^/\\]+)%.vim$")
    if theme_name then
      themes[theme_name] = true
    end
  end

  local custom_colors_dir = vim.fn.stdpath("config") .. "/colors"
  local custom_themes_vim = vim.fn.globpath(custom_colors_dir, "*.vim")
  local custom_themes_lua = vim.fn.globpath(custom_colors_dir, "*.lua")

  custom_themes_vim = type(custom_themes_vim) == "string" and custom_themes_vim ~= "" and
      { unpack(vim.split(custom_themes_vim, "\n")) } or {}
  custom_themes_lua = type(custom_themes_lua) == "string" and custom_themes_lua ~= "" and
      { unpack(vim.split(custom_themes_lua, "\n")) } or {}


  local custom_themes = vim.list_extend(custom_themes_vim, custom_themes_lua)

  for _, file in ipairs(custom_themes) do
    local theme_name = file:match("([^/\\]+)%.vim$") or file:match("([^/\\]+)%.lua$")
    if theme_name then
      themes[theme_name] = true
    end
  end

  --[[ Debugging
  print("Available themes:")
  for theme_name, _ in pairs(themes) do
    print(theme_name)
  end ]]

  local theme_list = vim.tbl_keys(themes)
  table.sort(theme_list, function(a, b)
    return a:lower() < b:lower()
  end)

  return theme_list
end

themery.setup({
  livePreview = true,
  themes = get_available_themes(),
})
