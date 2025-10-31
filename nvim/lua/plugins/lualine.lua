return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    local colors = {
      bg = "#181818",
      fg = "#b8b8b8",
      yellow = "#EBCB8B",
      cyan = "#7db8a8",
      green = "#7db8a8",
      orange = "#EBC88E",
      violet = "#AAA0FA",
      magenta = "#E394DC",
      blue = "#87C3FF",
      red = "#BF616A",
    }

    local custom_theme = {
      normal = {
        a = { bg = colors.violet, fg = colors.bg }, -- Purple bg for normal mode
        b = { bg = colors.bg, fg = colors.fg }, -- Filename stays fg
        c = { bg = colors.bg, fg = colors.fg },
      },
      insert = {
        a = { bg = colors.green, fg = colors.bg }, -- Green bg for insert
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      visual = {
        a = { bg = colors.magenta, fg = colors.bg }, -- Pink bg for visual
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      replace = {
        a = { bg = colors.red, fg = colors.bg }, -- Red bg for replace
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      command = {
        a = { bg = colors.yellow, fg = colors.bg }, -- Yellow bg for command
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
      inactive = {
        a = { bg = colors.bg, fg = colors.fg },
        b = { bg = colors.bg, fg = colors.fg },
        c = { bg = colors.bg, fg = colors.fg },
      },
    }

    require("lualine").setup {
      options = {
        theme = custom_theme,
        component_separators = "",
        section_separators = "",
        globalstatus = true,
        disabled_filetypes = { "alpha", "dashboard", "lazy" },
      },

      sections = {
        lualine_a = {
          {
            "mode",
            fmt = function(str)
              return str:sub(1, 1)
            end,
          },
        },
        lualine_b = {
          {
            "filename",
            path = 1,
            symbols = {
              modified = " ",
              readonly = " ",
              unnamed = "[No Name]",
            },
          },
        },

        lualine_c = {
          {
            "branch",
            icon = " ",
            cond = function()
              return vim.fn.system("git rev-parse --is-inside-work-tree 2>/dev/null"):match "true" ~= nil
            end,
          },
        },

        lualine_x = {
          {
            "diagnostics",
            sources = { "nvim_lsp" },
            symbols = { error = "E", warn = "W", info = "I", hint = "H" },
            colored = true,
          },
        },
        lualine_y = {},
        lualine_z = {
          {
            "progress",
            fmt = function(str)
              return str == "Top" and "⤒" or str == "Bot" and "⤓" or str
            end,
          },
          "location",
        },
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    }
  end,
}
