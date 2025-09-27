return {
  {
    "vague2k/vague.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("vague").setup {
        transparent = false,
        bold = false,
        italic = false,
      }
      vim.cmd.colorscheme "vague"
      vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "bg" })

      -- Set subtle border colors for all UI elements
      local border_color = "#3a3a3a"
      vim.api.nvim_set_hl(0, "FloatBorder", { fg = border_color })
      vim.api.nvim_set_hl(0, "NormalBorder", { fg = border_color })
      vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = border_color })
      vim.api.nvim_set_hl(0, "FzfLuaBorder", { fg = border_color })
      vim.api.nvim_set_hl(0, "OilBorder", { fg = border_color })

      -- Breadcrumbs styling to match editor background
      local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
      local normal_fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg
      if normal_bg then
        vim.api.nvim_set_hl(0, "WinBar", { bg = normal_bg, fg = normal_fg })
        vim.api.nvim_set_hl(0, "WinBarNC", { bg = normal_bg, fg = "#666666" })
        vim.api.nvim_set_hl(0, "NavicSeparator", { bg = normal_bg, fg = "#666666" })
        vim.api.nvim_set_hl(0, "NavicText", { bg = normal_bg, fg = normal_fg })
        vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#444444" })
        vim.api.nvim_set_hl(0, "WinSeparator", { fg = border_color })
        vim.api.nvim_set_hl(0, "VertSplit", { fg = border_color })
      end
    end,
  },
}
