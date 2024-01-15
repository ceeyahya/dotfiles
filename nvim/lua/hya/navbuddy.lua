local M = {
  "SmiteshP/nvim-navbuddy",
  dependencies = { "neovim/nvim-lspconfig", "SmiteshP/nvim-navic", "MunifTanjim/nui.nvim" },
}

function M.config()
  local opts = { noremap = true, silent = true }

  require("nvim-navbuddy").setup {
    window = {
      border = "single",
    },
    icons = require("hya.icons").kind,
    lsp = { auto_attach = true },
  }

  vim.keymap.set("n", "<leader>o", "<cmd>Navbuddy<CR>", opts)
  vim.keymap.set("n", "<m-s>", ":silent only | Navbuddy<CR>", opts)
  vim.keymap.set("n", "<m-o>", ":silent only | Navbuddy<CR>", opts)
end

return M
