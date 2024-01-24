local M = {
  "NeogitOrg/neogit",
  event = "VeryLazy",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",

    "nvim-telescope/telescope.nvim",
  },
  config = true,
}

function M.config()
  local icons = require "hya.icons"
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  keymap("n", "<leader>gg", "<cmd>Neogit<CR>", opts)

  require("neogit").setup {
    auto_refresh = true,
    disable_builtin_notifications = false,
    use_magit_keybindings = false,
    kind = "vsplit",
    signs = {
      section = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
      item = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
      hunk = { "", "" },
    },
  }
end

return M
