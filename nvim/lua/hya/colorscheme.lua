local M = {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
}

function M.config()
  require("catppuccin").setup {
    flavour = "mocha",
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false,     -- shows the '~' characters after the end of buffers
    term_colors = false,            -- sets terminal colors (e.g. `g:terminal_color_0`)
    no_italic = false,              -- Force no italic
    no_bold = false,                -- Force no bold
    no_underline = true,            -- Force no underline
    styles = {                      -- Handles the styles of general hi groups (see `:h highlight-args`):
      comments = { "italic" },      -- Change the style of comments
      conditionals = {},
      loops = {},
      functions = { "italic" },
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = { "bold" },
      operators = {},
    },
    color_overrides = {
      all = {},
    },
    custom_highlights = {},
    highlight_overrides = {
      mocha = function(C)
        return {
          NvimTreeNormal = { bg = C.none },
          CmpBorder = { fg = C.surface2 },
          Pmenu = { bg = C.none },
          NormalFloat = { bg = C.none },
          TelescopeBorder = { link = "FloatBorder" },
          GitSignsChangeLn = { bg = C.base },
          GitSignsAddLn = { bg = C.base },
        }
      end,
    },
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      notify = false,
      neogit = true,
      markdown = true,
      mason = true,
      harpoon = true,
      illuminate = true,
      indent_blankline = {
        enabled = true,
        scope_color = "base",
        colored_indent_levels = false,
      },
      navic = {
        enabled = true,
        custom_bg = "NONE",
      },
      telescope = {
        enabled = true,
        -- style = "nvchad"
      },
    },
  }

  vim.cmd.colorscheme "catppuccin"
end

return M
