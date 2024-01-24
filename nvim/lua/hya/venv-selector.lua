local M = {
  "linux-cultist/venv-selector.nvim",
  dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
  event = "VeryLazy",
}

function M.config()
  require("venv-selector").setup {
    auto_refresh = true,
    name = { "venv", ".venv" },
  }
end

M.keys = {
  { "<leader>vs", "<cmd>VenvSelect<cr>" },
  { "<leader>vc", "<cmd>VenvSelectCached<cr>" },
}

return M
