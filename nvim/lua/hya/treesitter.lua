local M = {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
}

function M.config()
  require("nvim-treesitter.configs").setup {
    ensure_installed = {
      "lua",
      "markdown",
      "markdown_inline",
      "bash",
      "python",
      "go",
      "javascript",
      "typescript",
      "tsx",
      "html",
      "astro",
      "svelte",
    },
    ignore_install = { "" },
    sync_install = false,
    highlight = {
      enable = true,
      vim_regex_highlighting = false,
    },
    indent = { enable = true },
  }

  vim.filetype.add {
    extension = { mdx = "mdx" },
  }

  vim.treesitter.language.register("markdown", "mdx")
end

return M
