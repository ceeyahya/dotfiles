local M = {
  "NvChad/nvim-colorizer.lua",
}

function M.config()
  require("colorizer").setup {
    filetypes = {
      "typescript",
      "typescriptreact",
      "javascript",
      "javascriptreact",
      "css",
      "html",
      "lua",
      "astro",
    },
    user_default_options = {
      names = false,
      rgb_fn = true,
      hsl_fn = true,
      tailwind = "both",
    },
  }
end

return M
