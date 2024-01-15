local M = {
  "windwp/nvim-ts-autotag",
  ft = { "javascriptreact", "typescriptreact", "html", "astro", "svelte" },
}

M.config = function()
  require("nvim-ts-autotag").setup {}
end

return M
