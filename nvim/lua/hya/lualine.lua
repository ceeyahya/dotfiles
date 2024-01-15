local M = {
  "nvim-lualine/lualine.nvim",
}

function M.config()
  local icons = require "hya.icons"

  require("lualine").setup {
    options = {
      theme = "catppuccin",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      ignore_focus = { "NvimTree" },
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { "filename", { "branch", icon = icons.git.Branch } },
      lualine_c = { "diagnostics" },
      lualine_x = { "location", "encoding" },
      lualine_y = { "filetype", "diff" },
      lualine_z = { "progress" },
    },
    extensions = { "quickfix", "man" },
  }
end

return M
