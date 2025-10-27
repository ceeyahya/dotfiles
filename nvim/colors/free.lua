-- Clear existing highlights
vim.cmd "highlight clear"

if vim.fn.exists "syntax_on" then
  vim.cmd "syntax reset"
end

vim.o.termguicolors = true
vim.g.colors_name = "free"

-- Helper function to set highlights
local function hl(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Color palette (inspired by vague.nvim but more vibrant and WCAG compliant)
local c = {
  -- Backgrounds
  bg = "#141415",
  bg_alt = "#1c1c24",
  bg_highlight = "#252530",
  bg_visual = "#333738",

  -- Foregrounds
  fg = "#cdcdcd",
  fg_dim = "#878787",

  -- Syntax colors (more vibrant, WCAG AA compliant)
  -- These will be assigned to semantic groups below
  accent1 = "#e0bd94", -- Orange (strings)
  accent2 = "#7da3d9", -- Blue (functions)
  accent3 = "#b5d989", -- Red (constants)
  accent4 = "#666666",

  -- UI colors
  border = "#3a3a3a", -- Very subtle borders
  error = "#e67c7c",
  warning = "#f0c674",
  info = "#7cafc2",
  hint = "#88c0a0",
}

-- ============================================================================
-- EDITOR UI
-- ============================================================================

-- Base
hl("Normal", { fg = c.fg, bg = c.bg })
hl("NormalFloat", { fg = c.fg, bg = c.bg })
hl("NormalNC", { fg = c.fg, bg = c.bg })

-- Cursor and lines
hl("Cursor", { fg = c.bg, bg = c.fg })
hl("CursorLine", { bg = c.bg_highlight })
hl("CursorLineNr", { fg = c.fg, bg = c.bg_highlight })
hl("LineNr", { fg = c.fg_dim })

-- Visual selection
hl("Visual", { bg = c.bg_visual })
hl("VisualNOS", { bg = c.bg_visual })

-- Search
hl("Search", { fg = c.bg, bg = c.accent2 })
hl("IncSearch", { fg = c.bg, bg = c.accent1 })
hl("CurSearch", { fg = c.bg, bg = c.accent1 })

-- Borders (very subtle)
hl("VertSplit", { fg = c.border })
hl("WinSeparator", { fg = c.border })
hl("FloatBorder", { fg = c.border })

-- Status line
hl("StatusLine", { fg = c.fg, bg = c.bg })
hl("StatusLineNC", { fg = c.fg_dim, bg = c.bg })

-- Tab line
hl("TabLine", { fg = c.fg_dim, bg = c.bg_alt })
hl("TabLineFill", { fg = c.fg_dim, bg = c.bg_alt })
hl("TabLineSel", { fg = c.fg, bg = c.bg_highlight })

-- Popup menu
hl("Pmenu", { fg = c.fg, bg = c.bg })
hl("PmenuSel", { fg = c.bg, bg = c.accent2 })
hl("PmenuSbar", { bg = c.bg_highlight })
hl("PmenuThumb", { bg = c.fg_dim })

-- EndOfBuffer
hl("EndOfBuffer", { fg = c.bg })

-- Signs and folds
hl("SignColumn", { fg = c.fg_dim, bg = c.bg })
hl("FoldColumn", { fg = c.fg_dim, bg = c.bg })
hl("Folded", { fg = c.fg_dim, bg = c.bg })

-- Diagnostics
hl("DiagnosticError", { fg = c.error })
hl("DiagnosticWarn", { fg = c.warning })
hl("DiagnosticInfo", { fg = c.info })
hl("DiagnosticHint", { fg = c.hint })

hl("DiagnosticVirtualTextError", { fg = c.error, bg = c.bg })
hl("DiagnosticVirtualTextWarn", { fg = c.warning, bg = c.bg })
hl("DiagnosticVirtualTextInfo", { fg = c.info, bg = c.bg })
hl("DiagnosticVirtualTextHint", { fg = c.hint, bg = c.bg })

-- WinBar
hl("WinBar", { fg = c.fg, bg = c.bg })
hl("WinBarNC", { fg = "#666666", bg = c.bg })

-- Navic (breadcrumbs)
hl("NavicSeparator", { fg = "#666666", bg = c.bg })
hl("NavicText", { fg = c.fg, bg = c.bg })

-- Mini.indentscope
hl("MiniIndentscopeSymbol", { fg = "#444444" })

-- Breadcrumbs highlight groups
hl("File", { fg = c.fg })
hl("Module", { fg = c.accent2 })
hl("Structure", { fg = c.accent2 })
hl("Class", { fg = c.accent2 })
hl("Method", { fg = c.accent2 })
hl("Property", { fg = c.fg })
hl("Field", { fg = c.fg })
hl("Enum", { fg = c.accent3 })
hl("Type", { fg = c.fg })
hl("Array", { fg = c.fg })
hl("Struct", { fg = c.accent2 })

-- ============================================================================
-- SYNTAX HIGHLIGHTING (Minimal Philosophy)
-- Only highlight: strings, constants, comments, top-level definitions
-- Everything else uses default fg color
-- ============================================================================

-- Default for most code (keywords, operators, variables, etc.)
hl("Identifier", { fg = c.fg })
hl("Statement", { fg = c.fg })
hl("Keyword", { fg = c.fg })
hl("Conditional", { fg = c.fg })
hl("Repeat", { fg = c.fg })
hl("Label", { fg = c.fg })
hl("Operator", { fg = c.fg })
hl("Exception", { fg = c.fg })
hl("PreProc", { fg = c.fg })
hl("Include", { fg = c.fg })
hl("Define", { fg = c.fg })
hl("Macro", { fg = c.fg })
hl("PreCondit", { fg = c.fg })
hl("Type", { fg = c.fg })
hl("StorageClass", { fg = c.fg })
hl("Structure", { fg = c.fg })
hl("Typedef", { fg = c.fg })
hl("Special", { fg = c.fg })
hl("SpecialChar", { fg = c.fg })
hl("Tag", { fg = c.fg })
hl("Delimiter", { fg = c.fg })
hl("SpecialComment", { fg = c.fg })
hl("Debug", { fg = c.fg })

-- HIGHLIGHTED ELEMENTS

-- Strings
hl("String", { fg = c.accent1 })
hl("Character", { fg = c.accent1 })

-- Constants (numbers, booleans, etc.)
hl("Constant", { fg = c.accent3 })
hl("Number", { fg = c.accent3 })
hl("Boolean", { fg = c.accent3 })
hl("Float", { fg = c.accent3 })

-- Comments (subtle)
hl("Comment", { fg = c.accent4 })

-- Function definitions (we'll handle this more specifically in Treesitter)
hl("Function", { fg = c.accent2 })

-- ============================================================================
-- TREESITTER
-- ============================================================================

-- Most treesitter groups inherit from default fg
hl("@variable", { fg = c.fg })
hl("@variable.builtin", { fg = c.fg })
hl("@variable.parameter", { fg = c.fg })
hl("@variable.member", { fg = c.fg })

hl("@keyword", { fg = c.fg })
hl("@keyword.function", { fg = c.fg })
hl("@keyword.operator", { fg = c.fg })
hl("@keyword.return", { fg = c.fg })
hl("@keyword.conditional", { fg = c.fg })
hl("@keyword.repeat", { fg = c.fg })

hl("@operator", { fg = c.fg })
hl("@punctuation.bracket", { fg = c.fg })
hl("@punctuation.delimiter", { fg = c.fg })
hl("@punctuation.special", { fg = c.fg })

hl("@type", { fg = c.fg })
hl("@type.builtin", { fg = c.fg })
hl("@type.qualifier", { fg = c.fg })

-- HIGHLIGHTED: Strings
hl("@string", { fg = c.accent1 })
hl("@string.escape", { fg = c.accent1 })
hl("@string.special", { fg = c.accent1 })

-- HIGHLIGHTED: Constants
hl("@constant", { fg = c.accent3 })
hl("@constant.builtin", { fg = c.accent3 })
hl("@number", { fg = c.accent3 })
hl("@boolean", { fg = c.accent3 })

-- HIGHLIGHTED: Comments
hl("@comment", { fg = c.accent4 })

-- HIGHLIGHTED: Function/Method definitions (top-level only ideally, but Treesitter doesn't always distinguish)
-- For now, we'll highlight all function names but you can refine this
hl("@function", { fg = c.accent2 })
hl("@function.builtin", { fg = c.fg }) -- Builtins stay default
hl("@function.method", { fg = c.accent2 })
hl("@constructor", { fg = c.accent2 })

-- Function calls remain default fg (not highlighted)
hl("@function.call", { fg = c.fg })
hl("@function.method.call", { fg = c.fg })

-- HIGHLIGHTED: HTML/JSX tags
-- All tag-related elements get the same color
hl("@tag", { fg = c.accent2 })
hl("@tag.delimiter", { fg = c.accent2 }) -- < > />
hl("@tag.attribute", { fg = c.fg }) -- Attributes stay default
hl("@type.astro", { fg = c.accent2 })

-- Properties/attributes stay default
hl("@property", { fg = c.fg })
hl("@attribute", { fg = c.fg })

-- Markup (Markdown, etc.)
hl("@markup.heading", { fg = c.accent2 })
hl("@markup.link", { fg = c.accent2, underline = true })
hl("@markup.raw", { fg = c.accent1 })

-- ============================================================================
-- LSP SEMANTIC TOKENS
-- ============================================================================

-- Most LSP tokens inherit default behavior
hl("@lsp.type.namespace", { fg = c.fg })
hl("@lsp.type.type", { fg = c.fg })
hl("@lsp.type.class", { fg = c.fg })
hl("@lsp.type.enum", { fg = c.fg })
hl("@lsp.type.interface", { fg = c.fg })
hl("@lsp.type.struct", { fg = c.fg })
hl("@lsp.type.parameter", { fg = c.fg })
hl("@lsp.type.variable", { fg = c.fg })
hl("@lsp.type.property", { fg = c.fg })
hl("@lsp.type.enumMember", { fg = c.fg })
hl("@lsp.type.decorator", { fg = c.fg })
hl("@lsp.type.macro", { fg = c.fg })

-- Function definitions highlighted
hl("@lsp.type.function", { fg = c.accent2 })
hl("@lsp.type.method", { fg = c.accent2 })

-- LSP References/usages
hl("LspReferenceText", { bg = c.bg_highlight })
hl("LspReferenceRead", { bg = c.bg_highlight })
hl("LspReferenceWrite", { bg = c.bg_highlight })

-- ============================================================================
-- GIT SIGNS
-- ============================================================================

hl("GitSignsAdd", { fg = c.hint })
hl("GitSignsChange", { fg = c.warning })
hl("GitSignsDelete", { fg = c.error })

-- ============================================================================
-- FZF-LUA
-- ============================================================================

hl("FzfLuaNormal", { fg = c.fg, bg = c.bg })
hl("FzfLuaBorder", { fg = c.border, bg = c.bg })
hl("FzfLuaTitle", { fg = c.fg, bg = c.bg })
hl("FzfLuaPreviewNormal", { fg = c.fg, bg = c.bg })
hl("FzfLuaPreviewBorder", { fg = c.border, bg = c.bg })
hl("FzfLuaCursor", { fg = c.bg, bg = c.fg })
hl("FzfLuaCursorLine", { bg = c.bg_highlight })
hl("FzfLuaSearch", { fg = c.bg, bg = c.accent2 })
hl("FzfLuaScrollBorderEmpty", { fg = c.border })
hl("FzfLuaScrollBorderFull", { fg = c.border })
hl("FzfLuaScrollFloatEmpty", { fg = c.border })
hl("FzfLuaScrollFloatFull", { fg = c.border })
hl("FzfLuaHelpNormal", { fg = c.fg, bg = c.bg })
hl("FzfLuaHelpBorder", { fg = c.border, bg = c.bg })

-- ============================================================================
-- COMPLETION (nvim-cmp)
-- ============================================================================

hl("CmpItemAbbrMatch", { fg = c.accent2, bold = true })
hl("CmpItemAbbrMatchFuzzy", { fg = c.accent2 })
hl("CmpItemKindVariable", { fg = c.fg })
hl("CmpItemKindFunction", { fg = c.accent2 })
hl("CmpItemKindKeyword", { fg = c.fg })
