return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "williamboman/mason.nvim",
  },
  config = function()
    local null_ls = require "null-ls"

    null_ls.setup {
      border = "single",
      sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.formatting.prettierd.with {
          filetypes = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",
            "html",
            "css",
            "astro",
            "json",
            "yaml",
            "markdown",
          },
        },
        null_ls.builtins.formatting.goimports,
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.rustywind,
        null_ls.builtins.formatting.clang_format.with {
          filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
        },
      },

      on_attach = function(client, bufnr)
        client.server_capabilities.completionProvider = false
        client.server_capabilities.diagnosticProvider = false

        if client.supports_method "textDocument/formatting" then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format {
                bufnr = bufnr,
                filter = function(c)
                  return c.name == "null-ls"
                end,
              }
            end,
          })
        end
      end,
    }
  end,
}
