return {
  "windwp/nvim-ts-autotag",
  ft = { "javascriptreact", "typescriptreact", "html", "astro" },
  config = function()
    require("nvim-ts-autotag").setup {}
  end,
}
