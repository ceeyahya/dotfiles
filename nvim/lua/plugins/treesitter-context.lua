return {
  "nvim-treesitter/nvim-treesitter-context",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    enable = true,
    max_lines = 3,
    min_window_height = 0,
    line_numbers = true,
    multiline_threshold = 1,
    trim_scope = "outer",
    mode = "cursor",
    separator = nil,
    zindex = 20,
  },
}
