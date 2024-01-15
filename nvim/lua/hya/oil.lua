local M = {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

function M.config()
  require("oil").setup {
    default_file_explorer = false,
    skip_confirm_for_simple_edits = true,
    prompt_save_on_select_new_entry = false,
    float = {
      border = "single",
      max_height = 20,
      max_width = 60,
    },
    view_options = {
      -- Show files and directories that start with "."
      show_hidden = true,
      -- This function defines what is considered a "hidden" file
      is_hidden_file = function(name, bufnr)
        return vim.startswith(name, ".")
      end,
      -- This function defines what will never be shown, even when `show_hidden` is set
      is_always_hidden = function(name, bufnr)
        return vim.startswith(name, ".DS_Store")
      end,
    },
  }

  vim.keymap.set("n", "-", "<cmd>Oil --float<cr>", { desc = "Open parent directory" })
end

return M
