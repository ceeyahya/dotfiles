local M = {
  "numToStr/Comment.nvim",
  lazy = false,
  dependencies = {
    {
      "JoosepAlviste/nvim-ts-context-commentstring",
      event = "VeryLazy",
    },
  },
}

function M.config()
  local keymap = vim.keymap

  keymap.set("n", "gc", "<Plug>(comment_toggle_linewise_current)", { desc = "Comment lin in normal mode" })
  keymap.set("v", "gc", "<Plug>(comment_toggle_linewise_visual)", { desc = "Comment lin in normal mode" })

  vim.g.skip_ts_context_commentstring_module = true

  require("ts_context_commentstring").setup {
    enable_autocmd = false,
  }

  require("Comment").setup {
    pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    padding = true,
    sticky = true,
  }
end

return M
