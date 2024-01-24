local M = {
  "mrcjkb/rustaceanvim",
  dependencies = { "neovim/nvim-lspconfig" },
  version = "^3",
  ft = { "rust" },
}

function M.config()
  vim.g.rustaceanvim = {
    tools = {},
    server = {
      on_attach = function(client, bufnr) end,
      settings = {
        ["rust-analyzer"] = {},
      },
    },
    dap = {},
  }
end

return M
