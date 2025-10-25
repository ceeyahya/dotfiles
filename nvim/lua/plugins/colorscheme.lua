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
        style = {
          boolean = "none",
          number = "none",
          float = "none",
          error = "none",
          comments = "none",
          conditionals = "none",
          functions = "none",
          headings = "none",
          operators = "none",
          strings = "none",
          variables = "none",
          keywords = "none",
          keyword_return = "none",
          keywords_loop = "none",
          keywords_label = "none",
          keywords_exception = "none",
          builtin_constants = "none",
          builtin_functions = "none",
          builtin_types = "none",
          builtin_variables = "none",
        },
        on_highlights = function(highlights, colors)
          -- Define your color palette
          local base = colors.fg -- base color for most code
          local string_color = colors.string -- or colors.plus for green
          local constant_color = colors.number -- orange/amber for constants
          local comment_color = colors.comment -- already dimmed/muted
          local definition_color = colors.hint -- blue for functions
          local tag_color = colors.builtin -- purple/cyan for JSX tags

          -- Set everything to base color first
          -- Keywords
          highlights["@keyword"] = { fg = base }
          highlights["@keyword.function"] = { fg = base }
          highlights["@keyword.operator"] = { fg = base }
          highlights["@keyword.return"] = { fg = base }
          highlights["@keyword.conditional"] = { fg = base }
          highlights["@keyword.repeat"] = { fg = base }
          highlights["@keyword.import"] = { fg = base }
          highlights["@keyword.exception"] = { fg = base }

          -- Variables
          highlights["@variable"] = { fg = base }
          highlights["@variable.builtin"] = { fg = base }
          highlights["@variable.parameter"] = { fg = base }
          highlights["@variable.member"] = { fg = base }

          -- Operators & Punctuation
          highlights["@operator"] = { fg = base }
          highlights["@punctuation.bracket"] = { fg = base }
          highlights["@punctuation.delimiter"] = { fg = base }
          highlights["@punctuation.special"] = { fg = base }

          -- Types (when not definitions)
          -- highlights["@type"] = { fg = base }
          -- highlights["@type.builtin"] = { fg = base }
          -- highlights["@type.qualifier"] = { fg = base }

          -- Properties & Fields
          highlights["@property"] = { fg = base }
          highlights["@field"] = { fg = base }

          -- Labels
          highlights["@label"] = { fg = base }

          -- NOW SET YOUR HIGHLIGHTED CATEGORIES

          -- 1. STRINGS
          highlights["@string"] = { fg = string_color }
          highlights["@string.escape"] = { fg = string_color }
          highlights["@string.special"] = { fg = string_color }
          highlights["@string.regex"] = { fg = string_color }

          -- 2. CONSTANTS
          highlights["@constant"] = { fg = constant_color }
          highlights["@constant.builtin"] = { fg = constant_color }
          highlights["@number"] = { fg = constant_color }
          highlights["@number.float"] = { fg = constant_color }
          highlights["@boolean"] = { fg = constant_color }
          highlights["@float"] = { fg = constant_color }

          -- 3. COMMENTS
          highlights["@comment"] = { fg = comment_color }
          highlights["@comment.documentation"] = { fg = comment_color }

          -- 4. TOP-LEVEL DEFINITIONS (functions, methods, classes, types)
          highlights["@function"] = { fg = definition_color }
          highlights["@function.builtin"] = { fg = definition_color }
          highlights["@function.call"] = { fg = definition_color }
          highlights["@function.macro"] = { fg = definition_color }
          highlights["@method"] = { fg = definition_color }
          highlights["@method.call"] = { fg = definition_color }
          -- highlights["@constructor"] = { fg = definition_color }
          -- highlights["@type.definition"] = { fg = definition_color }
          highlights["@class"] = { fg = definition_color }

          -- 5. HTML/JSX TAGS
          highlights["@tag"] = { fg = tag_color }
          highlights["@tag.builtin"] = { fg = tag_color } -- for uppercase JSX components
          highlights["@tag.delimiter"] = { fg = tag_color }
          highlights["@tag.attribute"] = { fg = base } -- keep attributes in base color
          highlights["@constructor"] = { fg = tag_color }
          highlights["@type.astro"] = { fg = tag_color }
          highlights["@type.tsx"] = { fg = tag_color }
          highlights["@type.jsx"] = { fg = tag_color }
        end,
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

-- return {
--   {
--     "vague2k/vague.nvim",
--     lazy = false,
--     priority = 1000,
--     config = function()
--       require("vague").setup {
--         transparent = false,
--         bold = false,
--         italic = false,
--       }
--       vim.cmd.colorscheme "vague"
--       vim.api.nvim_set_hl(0, "EndOfBuffer", { fg = "bg" })
--
--       -- Set subtle border colors for all UI elements
--       local border_color = "#3a3a3a"
--       vim.api.nvim_set_hl(0, "FloatBorder", { fg = border_color })
--       vim.api.nvim_set_hl(0, "NormalBorder", { fg = border_color })
--       vim.api.nvim_set_hl(0, "TelescopeBorder", { fg = border_color })
--       vim.api.nvim_set_hl(0, "FzfLuaBorder", { fg = border_color })
--       vim.api.nvim_set_hl(0, "OilBorder", { fg = border_color })
--
--       -- Breadcrumbs styling to match editor background
--       local normal_bg = vim.api.nvim_get_hl(0, { name = "Normal" }).bg
--       local normal_fg = vim.api.nvim_get_hl(0, { name = "Normal" }).fg
--       if normal_bg then
--         vim.api.nvim_set_hl(0, "WinBar", { bg = normal_bg, fg = normal_fg })
--         vim.api.nvim_set_hl(0, "WinBarNC", { bg = normal_bg, fg = "#666666" })
--         vim.api.nvim_set_hl(0, "NavicSeparator", { bg = normal_bg, fg = "#666666" })
--         vim.api.nvim_set_hl(0, "NavicText", { bg = normal_bg, fg = normal_fg })
--         vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { fg = "#444444" })
--         vim.api.nvim_set_hl(0, "WinSeparator", { fg = border_color })
--         vim.api.nvim_set_hl(0, "VertSplit", { fg = border_color })
--       end
--     end,
--   },
-- }
