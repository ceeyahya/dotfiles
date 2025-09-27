return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VimEnter",
  config = function()
    require("oil").setup {
      delete_to_trash = true,
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,

      float = {
        border = "single",
        max_height = 30,
        max_width = 60,
        win_options = {
          winblend = 0,
        },
      },

      view_options = {
        show_hidden = true,
        is_always_hidden = function(name)
          return name == ".DS_Store"
        end,
      },
    }

    vim.keymap.set("n", "-", "<cmd>Oil --float<cr>", { desc = "Open parent directory (Float)" })
    vim.keymap.set("n", "<leader>e", "<cmd>Oil<cr>", { desc = "Open parent directory" })
  end,
}
