return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    vim.filetype.add {
      extension = {
        mdx = "mdx",
        njk = "html",
      },
      filename = {
        ["Dockerfile"] = "dockerfile",
        [".dockerignore"] = "dockerignore",
      },
    }

    vim.treesitter.language.register("markdown", "mdx")

    require("nvim-treesitter.configs").setup {
      ensure_installed = {
        -- Core languages
        "lua",
        "vim",
        "vimdoc",

        -- Web development
        "javascript",
        "typescript",
        "tsx",
        "html",
        "css",
        "astro",
        "templ",

        -- Documentation
        "markdown",

        -- System languages
        "bash",
        "python",
        "go",
        "c",

        -- DevOps
        "dockerfile",
        "yaml",
        "json",

        -- Other
        "typst",
      },

      -- Performance settings
      auto_install = true,
      sync_install = false, -- Install parsers asynchronously

      highlight = {
        enable = true,
        disable = function(lang, buf)
          -- Disable for very large files (performance)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            return true
          end
        end,
        additional_vim_regex_highlighting = false,
      },

      indent = {
        enable = true,
        disable = { "python" },
      },
    }
  end,
}
