return {
  "j-hui/fidget.nvim",
  event = "LspAttach",
  opts = {
    progress = {
      display = {
        render_limit = 5,
        done_ttl = 3,
      },
    },
    notification = {
      window = {
        winblend = 0,
        border = "none",
        relative = "editor",
      },
    },
  },
}
