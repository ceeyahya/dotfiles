local M = {
  "nvim-tree/nvim-web-devicons",
  event = "VeryLazy",
}

function M.config()
  local devicons = require "nvim-web-devicons"

  devicons.set_icon {
    astro = {
      icon = "󰫢",
      color = "#FF4E19",
      name = "astro",
    },
    toml = {
      icon = "",
      color = "#61AFEF",
      name = "toml",
    },
  }
end

return M
