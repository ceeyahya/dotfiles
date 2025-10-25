return {
  "mrjones2014/smart-splits.nvim",
  tag = "v2.0.3",
  lazy = false,
  config = function()
    vim.g.smart_splits_log_level = "error"
    require("smart-splits").setup {
      ignored_filetypes = {
        "nofile",
        "quickfix",
        "qf",
        "prompt",
      },
      ignored_buftypes = { "NvimTree" },
      log_level = "off",
    }

    -- Keybindings
    vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
    vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
    vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
    vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)

    -- Resize with Alt
    vim.keymap.set("n", "<M-h>", require("smart-splits").resize_left)
    vim.keymap.set("n", "<M-j>", require("smart-splits").resize_down)
    vim.keymap.set("n", "<M-k>", require("smart-splits").resize_up)
    vim.keymap.set("n", "<M-l>", require("smart-splits").resize_right)
  end,
}
