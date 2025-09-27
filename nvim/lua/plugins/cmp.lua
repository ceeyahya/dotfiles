return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    {
      "L3MON4D3/LuaSnip",
      dependencies = {
        "rafamadriz/friendly-snippets",
      },
    },
    "hrsh7th/cmp-nvim-lua",
  },
  config = function()
    local cmp = require "cmp"
    local luasnip = require "luasnip"

    -- Load snippets
    require("luasnip/loaders/from_vscode").lazy_load()
    require("luasnip").filetype_extend("typescriptreact", { "html" })
    require("luasnip").filetype_extend("javascriptreact", { "html" })
    require("luasnip").filetype_extend("astro", { "html" })
    require("luasnip").filetype_extend("mdx", { "markdown" })

    -- Apply consistent border styling
    local border_color = "#3a3a3a"
    vim.api.nvim_set_hl(0, "CmpBorder", { fg = border_color })

    -- Text-based kind icons for performance
    local text_icons = {
      Text = "T",
      Method = "M",
      Function = "F",
      Constructor = "C",
      Field = "F",
      Variable = "V",
      Class = "C",
      Interface = "I",
      Module = "M",
      Property = "P",
      Unit = "U",
      Value = "V",
      Enum = "E",
      Keyword = "K",
      Snippet = "S",
      Color = "C",
      File = "F",
      Reference = "R",
      Folder = "F",
      EnumMember = "E",
      Constant = "C",
      Struct = "S",
      Event = "E",
      Operator = "O",
      TypeParameter = "T",
    }

    cmp.setup {
      enabled = function()
        -- Disable completion in oil.nvim buffers
        if vim.bo.filetype == "oil" then
          return false
        end
        return true
      end,

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      window = {
        completion = {
          border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
          winhighlight = "FloatBorder:CmpBorder",
          scrollbar = false, -- Disable for performance
        },
        documentation = {
          border = { "┌", "─", "┐", "│", "┘", "─", "└", "│" },
          winhighlight = "FloatBorder:CmpBorder",
          max_height = 15,
          max_width = 60,
        },
      },

      mapping = cmp.mapping.preset.insert {
        ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-e>"] = cmp.mapping {
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        },
        ["<CR>"] = cmp.mapping.confirm { select = true },
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },

      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          local kind = require("cmp.types.lsp").CompletionItemKind[entry:get_kind()]
          local source_names = {
            nvim_lsp = "LSP",
            nvim_lua = "Lua",
            luasnip = "Snip",
            buffer = "Buf",
            path = "Path",
          }

          -- Use simple text icons
          vim_item.kind = string.format("%s %s", text_icons[kind] or "?", kind)
          vim_item.menu = string.format("[%s]", source_names[entry.source.name] or "")

          -- Truncate long completions for performance
          local abbr = vim_item.abbr
          if #abbr > 30 then
            vim_item.abbr = string.sub(abbr, 1, 27) .. "..."
          end

          return vim_item
        end,
      },

      sources = {
        {
          name = "nvim_lsp",
          priority = 1000,
          entry_filter = function(entry, ctx)
            -- Convert LSP text completions that contain snippet syntax to snippets
            local completion_item = entry.completion_item
            if completion_item.kind == 1 and completion_item.insertText then -- kind 1 = Text
              local text = completion_item.insertText
              if text:match "%$%d" or text:match "%${%d}" then
                completion_item.kind = 15 -- Change to Snippet kind
                completion_item.insertTextFormat = 2 -- Snippet format
              end
            end
            return true
          end,
        },
        { name = "luasnip", priority = 750 },
        { name = "nvim_lua", priority = 700 },
        { name = "buffer", priority = 500, keyword_length = 3 },
        { name = "path", priority = 250 },
      },

      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },

      -- Performance optimizations
      performance = {
        debounce = 60,
        throttle = 30,
        fetching_timeout = 500,
        confirm_resolve_timeout = 80,
        async_budget = 1,
        max_view_entries = 200,
      },

      -- Disable experimental features for performance
      experimental = {
        ghost_text = false,
      },
    }
  end,
}
