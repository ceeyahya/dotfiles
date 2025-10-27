return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    require("lualine").setup {
      options = {
        theme = "auto", -- Auto-detect from your vague colorscheme
        component_separators = "",
        section_separators = "",
        globalstatus = true, -- Single statusline for all windows
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
              modified = " ●",
              readonly = " ",
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
