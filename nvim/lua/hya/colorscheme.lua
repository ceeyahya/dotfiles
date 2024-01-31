local M = {
  "catppuccin/nvim",
  lazy = false,
  name = "catppuccin",
  priority = 1000,
}

function M.config()
  require("catppuccin").setup {
    flavour = "mocha",
    transparent_background = true,
    show_end_of_buffer = false,
    term_colors = false,
    no_italic = false,
    no_bold = false,
    no_underline = false,
    styles = {
      comments = { "italic" },
      conditionals = {},
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
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
      ufo = true,
      vimwiki = true,
      treesitter = true,
      notify = false,
      neogit = true,
      fidget = true,
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
