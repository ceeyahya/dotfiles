return {
  -- Mason core
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

  -- Mason LSP integration - ONLY for installation, not setup
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup {
        ensure_installed = {
          "lua_ls",
          "html",
          "ts_ls",
          "cssls",
          "tailwindcss",
          "astro",
          "gopls",
          "jsonls",
          "yamlls",
          "emmet_ls",
          "tinymist",
        },
        automatic_installation = true,
        automatic_enable = {
          exclude = {
            "gopls",
            "tinymist",
            "templ",
          },
        },
      }
    end,
  },

  -- Mason none-ls integration
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
        },
        automatic_installation = true,
      }
    end,
  },

  -- Mason tool installer
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
        },
        auto_update = false,
        run_on_start = true,
      }
    end,
  },
}
