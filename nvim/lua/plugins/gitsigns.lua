return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    -- Custom highlight for blame text
    vim.api.nvim_set_hl(0, "GitSignsCurrentLineBlame", { fg = "#666666", italic = false })

    require("gitsigns").setup {
      signs = {
        add = { text = "+" },
        change = { text = "*" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "?" },
      },

      -- Performance optimizations
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },

      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 500,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      current_line_blame_formatter = " <author>, <author_time:%R> • <summary>",

      attach_to_untracked = true,
      update_debounce = 200,
      max_file_length = 40000,

      preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    }

    -- Keymaps
    local keymap = vim.keymap.set
    local opts = { noremap = true, silent = true }

    keymap("n", "<leader>gh", "<cmd>Gitsigns preview_hunk<CR>", opts)
    keymap("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<CR>", opts)
    keymap("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<CR>", opts)
    keymap("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", opts)
  end,
}
