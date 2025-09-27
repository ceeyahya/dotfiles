return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "FzfLua", -- Lazy load on command
  keys = {
    { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
    { "<leader>fw", "<cmd>FzfLua live_grep<cr>", desc = "Live grep" },
    { "<leader>fb", "<cmd>FzfLua buffers<cr>", desc = "Find buffers" },
    { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Help tags" },
  },
  config = function()
    require("fzf-lua").setup {
      winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.50,
        border = "single",
        preview = {
          border = "single",
          wrap = "nowrap",
        },
      },

      fzf_opts = {
        ["--layout"] = "reverse",
        ["--border"] = "none",
      },

      files = {
        -- This is the key fix for .env files
        find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
        rg_opts = "--color=never --files --hidden --follow -g '!.git'",
        fd_opts = "--color=never --type f --hidden --follow --exclude .git",
      },

      grep = {
        rg_opts = "--column --line-number --no-heading --color=always --smart-case --hidden -g '!.git'",
      },

      defaults = {
        git_icons = false,
        file_icons = true,
        color_icons = true,
      },

      previewers = {
        bat = {
          args = "--style=numbers,changes --color always",
        },
      },
    }
  end,
}
