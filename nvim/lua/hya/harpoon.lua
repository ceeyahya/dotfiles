local M = {
  "ThePrimeagen/harpoon",
  event = "VeryLazy",
  dependencies = { { "nvim-lua/plenary.nvim" } },
}

function M.config()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  keymap("n", "<S-m>", "<cmd>lua require('hya.harpoon').mark_file()<CR>", opts)
  keymap("n", "<TAB>", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", opts)

  require("harpoon").setup {
    save_on_toggle = true,
  }
end

function M.mark_file()
  require("harpoon.mark").add_file()
  vim.notify "󱡅  Marked File"
end

return M
