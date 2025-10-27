return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    local lspconfig = require "lspconfig"
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    local function setup_keymaps(bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }

      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>lk", vim.diagnostic.get_prev, opts)
      vim.keymap.set("n", "<leader>lj", vim.diagnostic.get_next, opts)
      vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, opts)
      vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format, opts)
    end

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        setup_keymaps(ev.buf)
      end,
    })

    vim.diagnostic.config {
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "E",
          [vim.diagnostic.severity.WARN] = "W",
          [vim.diagnostic.severity.HINT] = "H",
          [vim.diagnostic.severity.INFO] = "I",
        },
      },
      virtual_text = true,
      update_in_insert = false,
      underline = true,
      severity_sort = true,
      float = {
        focusable = true,
        style = "minimal",
        border = "single",
        source = true,
        header = "",
        prefix = "",
      },
    }

    local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or "single"
      opts.max_width = opts.max_width or 80
      opts.max_height = opts.max_height or 30
      return orig_util_open_floating_preview(contents, syntax, opts, ...)
    end

    local function find_typescript_sdk()
      local local_ts = vim.fn.getcwd() .. "/node_modules/typescript/lib"
      if vim.fn.isdirectory(local_ts) == 1 then
        return local_ts
      end

      local home = os.getenv "HOME"
      if home then
        local volta_ts = home .. "/.volta/tools/image/packages/typescript/lib"
        if vim.fn.isdirectory(volta_ts) == 1 then
          return volta_ts
        end

        local volta_ts_alt = home .. "/.volta/tools/image/node/*/lib/node_modules/typescript/lib"
        local volta_matches = vim.fn.glob(volta_ts_alt, false, true)
        if #volta_matches > 0 then
          table.sort(volta_matches)
          return volta_matches[#volta_matches]
        end
      end

      local volta_which_tsc = vim.fn.system("volta which tsc 2>/dev/null"):gsub("%s+$", "")
      if volta_which_tsc ~= "" and vim.fn.executable(volta_which_tsc) == 1 then
        local real_path = vim.fn.resolve(volta_which_tsc)
        local ts_lib = vim.fn.fnamemodify(real_path, ":h:h") .. "/lib"
        if vim.fn.isdirectory(ts_lib) == 1 then
          return ts_lib
        end
      end

      local ts_path = vim.fn.system("which tsc 2>/dev/null"):gsub("%s+$", "")
      if ts_path ~= "" and vim.fn.executable(ts_path) == 1 then
        local real_path = vim.fn.resolve(ts_path)
        local ts_lib = vim.fn.fnamemodify(real_path, ":h:h") .. "/lib"
        if vim.fn.isdirectory(ts_lib) == 1 then
          return ts_lib
        end
      end

      local global_npm_root = vim.fn.system("npm root -g 2>/dev/null"):gsub("%s+$", "")
      if global_npm_root ~= "" then
        local global_ts = global_npm_root .. "/typescript/lib"
        if vim.fn.isdirectory(global_ts) == 1 then
          return global_ts
        end
      end

      if home then
        local common_volta_paths = {
          home .. "/.volta/tools/image/packages/typescript/lib",
          home .. "/.volta/bin/../lib/node_modules/typescript/lib",
        }

        for _, path in ipairs(common_volta_paths) do
          if vim.fn.isdirectory(path) == 1 then
            return path
          end
        end
      end

      return nil
    end

    lspconfig.lua_ls.setup {
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = { version = "LuaJIT" },
          diagnostics = { globals = { "vim" } },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
    }

    lspconfig.html.setup {
      capabilities = capabilities,
      filetypes = { "html", "njk" },
      init_options = {
        configurationSection = { "html", "css", "javascript" },
        embeddedLanguages = {
          css = true,
          javascript = true,
        },
        provideFormatter = true,
      },
      settings = {
        html = {
          format = {
            enable = true,
            wrapLineLength = 120,
            unformatted = "wbr",
            contentUnformatted = "pre,code,textarea",
            indentInnerHtml = false,
            preserveNewLines = true,
            maxPreserveNewLines = 2,
            indentHandlebars = false,
            endWithNewline = false,
            extraLiners = "head, body, /html",
            wrapAttributes = "auto",
          },
          suggest = {
            html5 = true,
            angular1 = false,
            ionic = false,
          },
          validate = {
            scripts = true,
            styles = true,
          },
          hover = {
            documentation = true,
            references = true,
          },
          completion = {
            attributeDefaultValue = "doublequotes",
          },
          mirrorCursorOnMatchingTag = false,
        },
      },
    }

    lspconfig.ts_ls.setup {
      capabilities = capabilities,
      init_options = {
        preferences = {
          disableSuggestions = false,
        },
      },
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
          suggest = {
            includeCompletionsForModuleExports = true,
          },
          preferences = {
            includePackageJsonAutoImports = "auto",
          },
          format = { enable = true },
          validate = { enable = true },
          check = { npmIsInstalled = true },
          tsc = {
            useSyntaxServer = "always",
          },
        },
        javascript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
            includeInlayPropertyDeclarationTypeHints = true,
            includeInlayFunctionLikeReturnTypeHints = true,
            includeInlayEnumMemberValueHints = true,
          },
          suggest = {
            includeCompletionsForModuleExports = true,
          },
          preferences = {
            includePackageJsonAutoImports = "auto",
          },
          format = { enable = true },
          validate = { enable = true },
          check = { npmIsInstalled = true },
          implicitProjectConfig = {
            checkJs = true,
            experimentalDecorators = true,
            module = "ESNext",
            target = "ES2020",
            jsx = "react-jsx",
          },
        },
        completions = {
          completeFunctionCalls = true,
        },
      },
    }

    lspconfig.cssls.setup {
      capabilities = capabilities,
      settings = {
        css = {
          validate = true,
          lint = {
            unknownAtRules = "ignore",
          },
        },
        scss = {
          validate = true,
          lint = {
            unknownAtRules = "ignore",
          },
        },
        less = {
          validate = true,
          lint = {
            unknownAtRules = "ignore",
          },
        },
      },
    }

    lspconfig.tailwindcss.setup {
      capabilities = capabilities,
      settings = {
        tailwindCSS = {
          lint = {
            cssConflict = "warning",
            invalidApply = "error",
            invalidConfigPath = "error",
            invalidScreen = "error",
            invalidTailwindDirective = "error",
            invalidVariant = "error",
            recommendedVariantOrder = "warning",
          },
          validate = true,
          classAttributes = { "class", "className", "class:list", "classList", "ngClass" },
          includeLanguages = {
            html = "html",
            css = "css",
            javascript = "javascript",
            typescript = "typescript",
            javascriptreact = "javascript",
            typescriptreact = "typescript",
            vue = "html",
            svelte = "html",
            astro = "html",
          },
          experimental = {
            classRegex = {
              "tw`([^`]*)",
              'tw="([^"]*)',
              'tw={"([^"}]*)',
              "tw\\.\\w+`([^`]*)",
              "tw\\(.*?\\)`([^`]*)",
            },
          },
        },
      },
    }

    lspconfig.astro.setup {
      capabilities = capabilities,
      init_options = (function()
        local tsdk = find_typescript_sdk()
        if tsdk then
          return {
            typescript = {
              tsdk = tsdk,
            },
          }
        else
          vim.notify("TypeScript SDK not found. Install typescript locally or globally.", vim.log.levels.WARN)
          return {}
        end
      end)(),
      settings = {
        astro = {
          typescript = {
            enabled = true,
          },
        },
      },
    }

    lspconfig.gopls.setup {
      capabilities = capabilities,
      settings = {
        gopls = {
          gofumpt = true,
          codelenses = {
            gc_details = false,
            generate = true,
            regenerate_cgo = true,
            run_govulncheck = true,
            test = true,
            tidy = true,
            upgrade_dependency = true,
            vendor = true,
          },
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            compositeLiteralTypes = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
          analyses = {
            nilness = true,
            unusedparams = true,
            unusedwrite = true,
            useany = true,
          },
          usePlaceholders = true,
          completeUnimported = true,
          staticcheck = true,
          directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
          semanticTokens = true,
        },
      },
    }

    lspconfig.templ.setup {
      capabilities = capabilities,
      filetypes = { "templ" },
    }

    -- JSON Language Server
    lspconfig.jsonls.setup {
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    }

    lspconfig.yamlls.setup {
      capabilities = capabilities,
      settings = {
        yaml = {
          schemaStore = {
            enable = false,
            url = "",
          },
          schemas = require("schemastore").yaml.schemas(),
          validate = true,
          format = {
            enable = true,
          },
          hover = true,
          completion = true,
        },
      },
    }

    lspconfig.clangd.setup {
      capabilities = capabilities,
      cmd = {
        "clangd",
        "--background-index",
        "--clang-tidy",
        "--header-insertion=iwyu",
        "--completion-style=detailed",
        "--function-arg-placeholders",
        "--fallback-style=llvm",
      },
      init_options = {
        usePlaceholders = true,
        completeUnimported = true,
        clangdFileStatus = true,
      },
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    }

    lspconfig.emmet_ls.setup {
      capabilities = capabilities,
      filetypes = {
        "html",
        "typescriptreact",
        "javascriptreact",
        "css",
        "sass",
        "scss",
        "less",
        "astro",
      },
    }

    -- Typst Language Server
    lspconfig.tinymist.setup {
      capabilities = capabilities,
      settings = {
        formatterMode = "typstyle",
      },
    }
  end,
}
