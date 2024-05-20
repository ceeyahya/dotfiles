local M = {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    {
      "folke/neodev.nvim",
    },
  },
}

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true }
  local keymap = vim.api.nvim_buf_set_keymap

  keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
  keymap(bufnr, "n", "gl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  keymap(bufnr, "n", "<leader>ll", "<cmd>lua vim.lsp.codelens.run()<CR>", opts)
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
end

function M.common_capabilities()
  local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
  if status_ok then
    return cmp_nvim_lsp.default_capabilities()
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  }

  return capabilities
end

function M.config()
  local lspconfig = require "lspconfig"
  local icons = require "hya.icons"

  local servers = {
    "lua_ls",
    "cssls",
    "html",
    "tsserver",
    "astro",
    "pyright",
    "bashls",
    "jsonls",
    "yamlls",
    "marksman",
    "tailwindcss",
    "gopls",
    "eslint",
    "rust_analyzer",
    "emmet_ls",
    "prismals",
    "htmx",
    "templ",
  }

  local default_diagnostic_config = {
    signs = {
      active = true,
      values = {
        { name = "DiagnosticSignError", text = icons.diagnostics.Error },
        { name = "DiagnosticSignWarn",  text = icons.diagnostics.Warning },
        { name = "DiagnosticSignHint",  text = icons.diagnostics.Hint },
        { name = "DiagnosticSignInfo",  text = icons.diagnostics.Information },
      },
    },
    virtual_text = true,
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "single",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(default_diagnostic_config)

  for _, sign in ipairs(vim.tbl_get(vim.diagnostic.config(), "signs", "values") or {}) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = sign.name })
  end

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })
  require("lspconfig.ui.windows").default_options.border = "single"

  for _, server in pairs(servers) do
    local opts = {
      on_attach = M.on_attach,
      capabilities = M.common_capabilities(),
    }

    local require_ok, settings = pcall(require, "hya.lspsettings." .. server)
    if require_ok then
      opts = vim.tbl_deep_extend("force", settings, opts)
    end

    if server == "htmx" then
      lspconfig.htmx.setup {
        on_attach = M.on_attach,
        capabilities = M.capabilities,
        filetypes = { "html", "templ" },
      }
    end

    if server == "tailwindcss" then
      lspconfig.tailwindcss.setup {
        on_attach = M.on_attach,
        capabilities = M.capabilities,
        filetypes = { "templ", "astro", "javascript", "typescript", "react" },
        init_options = { userLanguages = { templ = "html" } },
      }
    end

    if server == "gopls" then
      lspconfig.gopls.setup {
        on_attach = M.on_attach,
        capabilities = M.capabilities,
        cmd = {
          "gopls",
        },
        filetypes = { "go", "gomod", "gowork", "gotempl" },
        root_dir = lspconfig.util.root_pattern("go.work", "go.mod", ".git"),
        settings = {
          gopls = {
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
          },
        },
      }
    end

    if server == "lua_ls" then
      require("neodev").setup {}
    end

    lspconfig[server].setup(opts)
  end
end

return M
