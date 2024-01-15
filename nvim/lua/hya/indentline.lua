local M = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {},
}

function M.config()
  local icons = require "hya.icons"
  local highlight = {
    "RainbowViolet",
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowCyan",
  }
  local hooks = require "ibl.hooks"

  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#EBA0AC" })
    vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#F9E2AF" })
    vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#B4BEFE" })
    vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#FAB387" })
    vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#A6E3A1" })
    vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#CBA6F7" })
    vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#89DCEB" })
  end)

  vim.g.rainbow_delimiters = { highlight = highlight }

  require("ibl").setup {
    indent = {
      char = icons.ui.DashedLineMiddle,
    },
    exclude = {
      filetypes = {
        "help",
        "startify",
        "dashboard",
        "lazy",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "text",
      },
    },
    scope = {
      enabled = true,
      show_start = false,
      show_end = false,
      highlight = highlight,
    },
  }

  hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
end

return M
