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
  bg = "#181818",
  bg_highlight = "#232323",
  bg_visual = "#2D2D2D",

  -- Foregrounds
  fg = "#B8B8B8", -- "#D0D0D0",
  fg_dim = "#878787",

  accent1 = "#EBC88E", -- Orange (strings)
  accent2 = "#AAA0FA", -- Purple (functions)
  accent3 = "#E394DC", -- Pink (constants)
  accent4 = "#636363",

  -- UI colors
  border = "#3A3A3A", -- Very subtle borders
  error = "#BF616A",
  warning = "#EBCB8B",
  info = "#7FA5C3",
  hint = "#7DB8A8",
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
hl('ColorColumn', { bg = '#1e1e1e' })

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

hl("LspSeparator", { fg = c.border })

-- Status line
hl("StatusLine", { fg = c.fg, bg = c.bg })
hl("StatusLineNC", { fg = c.fg_dim, bg = c.bg })

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

-- Folders
hl("Directory", { fg = "#87C3FF" })

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
hl("String", { fg = "#D4A574", bg = "#2d261f" })
hl("Character", { fg = "#D4A574", bg = "#2d261f" })

-- Constants (numbers, booleans, etc.)
hl("Constant", { fg = "#D885C8", bg = "#2d262d" })
hl("Number", { fg = "#D885C8", bg = "#2d262d" })
hl("Boolean", { fg = "#D885C8", bg = "#2d262d" })
hl("Float", { fg = "#D885C8", bg = "#2d262d" })

-- Comments (subtle)
hl("Comment", { fg = c.accent4 })

-- Function definitions
hl("Function", { fg = "#9A8AE0", bg = "#26212c" })

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

-- HIGHLIGHTED: Strings
hl("@string", { fg = "#D4A574", bg = "#2d261f" })
hl("@string.escape", { fg = "#D4A574", bg = "#2d261f" })
hl("@string.special", { fg = "#D4A574", bg = "#2d261f" })

-- HIGHLIGHTED: Constants
hl("@constant", { fg = "#D885C8", bg = "#2d262d" })
hl("@constant.builtin", { fg = "#D885C8", bg = "#2d262d" })
hl("@number", { fg = "#D885C8", bg = "#2d262d" })
hl("@boolean", { fg = "#D885C8", bg = "#2d262d" })

-- HIGHLIGHTED: Functions
hl("@function", { fg = "#9A8AE0", bg = "#26212c" })
hl("@function.method", { fg = "#9A8AE0", bg = "#26212c" })
hl("@constructor", { fg = "#9A8AE0", bg = "#26212c" })

-- Function calls remain default fg (not highlighted)
hl("@function.call", { fg = c.fg })
hl("@function.method.call", { fg = c.fg })

-- HIGHLIGHTED: HTML/JSX tags
-- All tag-related elements get the same color
hl("@tag", { fg = c.accent2 })
hl("@tag.delimiter", { fg = c.accent2 }) -- < > />
hl("@tag.attribute", { fg = c.fg })      -- Attributes stay default
hl("@type.astro", { fg = c.accent2 })
hl("@_jsx_element.tsx", { fg = c.accent2 })
hl("@_jsx_element", { fg = c.accent2 })
hl("@variable.tsx", { fg = c.accent2 })
hl("@tag.builtin.tsx", { fg = c.accent2 })

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

hl("@lsp.typemod.function.defaultLibrary", { fg = c.accent2 })
hl("@lsp.typemod.function.globalScope", { fg = c.accent2 })

-- LSP References/usages
hl("LspReferenceText", { bg = c.bg_highlight })
hl("LspReferenceRead", { bg = c.bg_highlight })
hl("LspReferenceWrite", { bg = c.bg_highlight })

-- ============================================================================
-- MARKDOWN / VIMWIKI / RENDER-MARKDOWN
-- ============================================================================

-- Headings (no backgrounds, just colors)
hl("markdownH1", { fg = c.accent2, bold = true })
hl("markdownH2", { fg = c.accent2, bold = true })
hl("markdownH3", { fg = c.accent3, bold = true })
hl("markdownH4", { fg = c.accent3 })
hl("markdownH5", { fg = c.fg })
hl("markdownH6", { fg = c.fg })

-- render-markdown headings (no backgrounds)
hl("RenderMarkdownH1", { fg = c.accent2, bold = true })
hl("RenderMarkdownH2", { fg = c.accent2, bold = true })
hl("RenderMarkdownH3", { fg = c.accent3, bold = true })
hl("RenderMarkdownH4", { fg = c.accent3 })
hl("RenderMarkdownH5", { fg = c.fg })
hl("RenderMarkdownH6", { fg = c.fg_dim })

-- Code blocks (same background as editor)
hl("markdownCode", { fg = c.accent1, bg = "#2d261f" })             -- Inline code with orange badge
hl("markdownCodeBlock", { fg = c.fg, bg = c.bg })                  -- Block code, same as editor bg
hl("RenderMarkdownCode", { bg = c.bg })                            -- Code block background
hl("RenderMarkdownCodeInline", { fg = c.accent1, bg = "#2d261f" }) -- Inline code badge

-- Links
hl("markdownLink", { fg = c.accent2, underline = true })
hl("markdownUrl", { fg = c.accent2 })
hl("RenderMarkdownLink", { fg = c.accent2, underline = true })

-- Lists
hl("markdownListMarker", { fg = c.accent3 })
hl("RenderMarkdownBullet", { fg = c.accent3 })

-- Bold/Italic
hl("markdownBold", { fg = c.fg, bold = true })
hl("markdownItalic", { fg = c.fg, italic = true })
hl("RenderMarkdownBold", { fg = c.fg, bold = true })
hl("RenderMarkdownItalic", { fg = c.fg, italic = true })

-- Quotes
hl("markdownBlockquote", { fg = c.fg_dim, italic = true })
hl("RenderMarkdownQuote", { fg = c.fg_dim })

-- Horizontal rules
hl("markdownRule", { fg = c.border })
hl("RenderMarkdownDash", { fg = c.border })

-- YAML frontmatter (pink keys, orange values)
hl("yamlBlockMappingKey", { fg = c.accent3 }) -- Pink for keys
hl("yamlPlainScalar", { fg = c.accent1 })     -- Orange for values
hl('@property.yaml', { fg = c.accent3 })  -- Pink for keys
hl('@string.yaml', { fg = c.accent1 })  -- Orange for values
hl('@keyword.directive.markdown', { fg = c.accent3 })  -- Pink for --- markers

-- Vimwiki specific
hl("VimwikiHeader1", { fg = c.accent2, bold = true })
hl("VimwikiHeader2", { fg = c.accent2, bold = true })
hl("VimwikiHeader3", { fg = c.accent3, bold = true })
hl("VimwikiHeader4", { fg = c.accent3 })
hl("VimwikiHeader5", { fg = c.fg })
hl("VimwikiHeader6", { fg = c.fg })
hl("VimwikiLink", { fg = c.accent2, underline = true })
hl("VimwikiList", { fg = c.accent3 })
hl("VimwikiTag", { fg = c.accent3 })
hl("VimwikiCode", { fg = c.accent1, bg = "#2d261f" })

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
