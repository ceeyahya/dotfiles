local M = {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "nvim-lua/plenary.nvim",
  },
}

function M.config()
  require("mason").setup {
    ui = {
      border = "single",
    },
  }
  require("mason-lspconfig").setup {}
end

return M
