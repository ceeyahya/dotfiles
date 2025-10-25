return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup {
        ui = {
          border = "single",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      }
    end,
  },

  {
    "jay-babu/mason-null-ls.nvim",
    lazy = false,
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup {
        ensure_installed = {
          "stylua",
          "prettierd",
          "gofumpt",
          "goimports",
          "clang-format",
        },
        automatic_installation = true,
      }
    end,
  },

  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-tool-installer").setup {
        ensure_installed = {
          "stylua",
          "prettierd",
          "gofumpt",
          "goimports",
          "clangd",
          "clang-format",
        },
        auto_update = false,
        run_on_start = true,
      }
    end,
  },
}
