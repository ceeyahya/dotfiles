local M = {
  "j-hui/fidget.nvim",
}

function M.config()
  local icons = require "hya.icons"

  require("fidget").setup {
    integration = {
      ["nvim-tree"] = {
        enable = true,
      },
    },

    progress = {
      display = {
        render_limit = 16,
        done_icon = icons.ui.Check,
      },
    },

    notification = {
      override_vim_notify = true,
      window = {
        normal_hl = "CursorLineNr",
        winblend = 0,
        border = "none",
        zindex = 45,
        max_width = 0,
        max_height = 0,
        x_padding = 2,
        y_padding = 2,
        align = "bottom",
        relative = "editor",
      },
    },
  }
end

return M
