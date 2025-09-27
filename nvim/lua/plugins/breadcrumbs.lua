return {
  "LunarVim/breadcrumbs.nvim",
  dependencies = { "SmiteshP/nvim-navic" },
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("breadcrumbs").setup {
      show_dirname = true,
      show_basename = true,
    }
  end,
}
