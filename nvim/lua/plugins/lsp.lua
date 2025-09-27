return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local lspconfig = require "lspconfig"

    -- Get cmp-nvim-lsp capabilities for better integration
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Formatting functions
    local formatters = {
      lua = function()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local content = table.concat(lines, "\n")

        local cmd = "stylua --stdin-filepath " .. vim.fn.shellescape(vim.api.nvim_buf_get_name(0)) .. " -"
        local result = vim.fn.system(cmd, content)

        if vim.v.shell_error == 0 then
          local formatted_lines = vim.split(result, "\n")
          if formatted_lines[#formatted_lines] == "" then
            table.remove(formatted_lines)
          end
          vim.api.nvim_buf_set_lines(0, 0, -1, false, formatted_lines)
        else
          vim.notify("Stylua formatting failed: " .. result, vim.log.levels.ERROR)
        end
      end,

      javascript = function()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local content = table.concat(lines, "\n")

        local result = vim.fn.system("prettierd " .. vim.fn.shellescape(vim.api.nvim_buf_get_name(0)), content)

        if vim.v.shell_error == 0 then
          local formatted_lines = vim.split(result, "\n")
          if formatted_lines[#formatted_lines] == "" then
            table.remove(formatted_lines)
          end
          vim.api.nvim_buf_set_lines(0, 0, -1, false, formatted_lines)
        else
          vim.notify("Prettierd formatting failed: " .. result, vim.log.levels.ERROR)
        end
      end,

      typescript = function()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local content = table.concat(lines, "\n")

        local result = vim.fn.system("prettierd " .. vim.fn.shellescape(vim.api.nvim_buf_get_name(0)), content)

        if vim.v.shell_error == 0 then
          local formatted_lines = vim.split(result, "\n")
          if formatted_lines[#formatted_lines] == "" then
            table.remove(formatted_lines)
          end
          vim.api.nvim_buf_set_lines(0, 0, -1, false, formatted_lines)
        else
          vim.notify("Prettierd formatting failed: " .. result, vim.log.levels.ERROR)
        end
      end,

      javascriptreact = function()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local content = table.concat(lines, "\n")

        local result = vim.fn.system("prettierd " .. vim.fn.shellescape(vim.api.nvim_buf_get_name(0)), content)

        if vim.v.shell_error == 0 then
          local formatted_lines = vim.split(result, "\n")
          if formatted_lines[#formatted_lines] == "" then
            table.remove(formatted_lines)
          end
          vim.api.nvim_buf_set_lines(0, 0, -1, false, formatted_lines)
        else
          vim.notify("Prettierd formatting failed: " .. result, vim.log.levels.ERROR)
        end
      end,

      typescriptreact = function()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local content = table.concat(lines, "\n")

        local result = vim.fn.system("prettierd " .. vim.fn.shellescape(vim.api.nvim_buf_get_name(0)), content)

        if vim.v.shell_error == 0 then
          local formatted_lines = vim.split(result, "\n")
          if formatted_lines[#formatted_lines] == "" then
            table.remove(formatted_lines)
          end
          vim.api.nvim_buf_set_lines(0, 0, -1, false, formatted_lines)
        else
          vim.notify("Prettierd formatting failed: " .. result, vim.log.levels.ERROR)
        end
      end,

      html = function()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local content = table.concat(lines, "\n")

        local result = vim.fn.system("prettierd " .. vim.fn.shellescape(vim.api.nvim_buf_get_name(0)), content)

        if vim.v.shell_error == 0 then
          local formatted_lines = vim.split(result, "\n")
          if formatted_lines[#formatted_lines] == "" then
            table.remove(formatted_lines)
          end
          vim.api.nvim_buf_set_lines(0, 0, -1, false, formatted_lines)
        else
          vim.notify("Prettierd formatting failed: " .. result, vim.log.levels.ERROR)
        end
      end,

      astro = function()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local content = table.concat(lines, "\n")

        local result = vim.fn.system("prettierd " .. vim.fn.shellescape(vim.api.nvim_buf_get_name(0)), content)

        if vim.v.shell_error == 0 then
          local formatted_lines = vim.split(result, "\n")
          if formatted_lines[#formatted_lines] == "" then
            table.remove(formatted_lines)
          end
          vim.api.nvim_buf_set_lines(0, 0, -1, false, formatted_lines)
        else
          vim.notify("Prettierd formatting failed: " .. result, vim.log.levels.ERROR)
        end
      end,

      css = function()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local content = table.concat(lines, "\n")

        local result = vim.fn.system("prettierd " .. vim.fn.shellescape(vim.api.nvim_buf_get_name(0)), content)

        if vim.v.shell_error == 0 then
          local formatted_lines = vim.split(result, "\n")
          if formatted_lines[#formatted_lines] == "" then
            table.remove(formatted_lines)
          end
          vim.api.nvim_buf_set_lines(0, 0, -1, false, formatted_lines)
        else
          vim.notify("Prettierd formatting failed: " .. result, vim.log.levels.ERROR)
        end
      end,

      go = function()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local content = table.concat(lines, "\n")

        local result = vim.fn.system("gofmt", content)

        if vim.v.shell_error == 0 then
          local formatted_lines = vim.split(result, "\n")
          if formatted_lines[#formatted_lines] == "" then
            table.remove(formatted_lines)
          end
          vim.api.nvim_buf_set_lines(0, 0, -1, false, formatted_lines)
        else
          vim.notify("Gofmt formatting failed: " .. result, vim.log.levels.ERROR)
        end
      end,

      gomod = function()
        local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
        local content = table.concat(lines, "\n")

        local result = vim.fn.system("gofmt", content)

        if vim.v.shell_error == 0 then
          local formatted_lines = vim.split(result, "\n")
          if formatted_lines[#formatted_lines] == "" then
            table.remove(formatted_lines)
          end
          vim.api.nvim_buf_set_lines(0, 0, -1, false, formatted_lines)
        else
          vim.notify("Gofmt formatting failed: " .. result, vim.log.levels.ERROR)
        end
      end,
    }

    local function format_buffer()
      local ft = vim.bo.filetype
      local formatter = formatters[ft]

      if formatter then
        formatter()
      else
        -- Fallback to LSP formatting if available
        local clients = vim.lsp.get_active_clients { bufnr = 0 }
        if #clients > 0 then
          vim.lsp.buf.format { async = false }
        else
          vim.notify("No formatter available for " .. ft, vim.log.levels.WARN)
        end
      end
    end

    -- Setup keymaps function
    local function setup_keymaps(bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }

      vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "gI", vim.lsp.buf.implementation, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "<leader>lk", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "<leader>lj", vim.diagnostic.goto_next, opts)
      vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, opts)
      vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "<leader>lf", format_buffer, opts)
    end

    -- Setup LSP on_attach callback
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(ev)
        setup_keymaps(ev.buf)
      end,
    })

    -- Configure diagnostics
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
        source = "always",
        header = "",
        prefix = "",
      },
    }

    -- Configure LSP handlers
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "single" })
    vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = "single" })

    -- Helper function to find TypeScript SDK (needed for Astro)
    local function find_typescript_sdk()
      -- 1. Check local project node_modules first
      local local_ts = vim.fn.getcwd() .. "/node_modules/typescript/lib"
      if vim.fn.isdirectory(local_ts) == 1 then
        return local_ts
      end

      -- 2. Check Volta's current TypeScript installation
      local home = os.getenv "HOME"
      if home then
        -- Volta stores the current TypeScript in ~/.volta/tools/image/packages/typescript
        local volta_ts = home .. "/.volta/tools/image/packages/typescript/lib"
        if vim.fn.isdirectory(volta_ts) == 1 then
          return volta_ts
        end

        -- Alternative Volta path structure
        local volta_ts_alt = home .. "/.volta/tools/image/node/*/lib/node_modules/typescript/lib"
        local volta_matches = vim.fn.glob(volta_ts_alt, false, true)
        if #volta_matches > 0 then
          -- Sort and take the latest version
          table.sort(volta_matches)
          return volta_matches[#volta_matches]
        end
      end

      -- 3. Try to find TypeScript through Volta's which command
      local volta_which_tsc = vim.fn.system("volta which tsc 2>/dev/null"):gsub("%s+$", "")
      if volta_which_tsc ~= "" and vim.fn.executable(volta_which_tsc) == 1 then
        -- Follow symlinks and find the lib directory
        local real_path = vim.fn.resolve(volta_which_tsc)
        local ts_lib = vim.fn.fnamemodify(real_path, ":h:h") .. "/lib"
        if vim.fn.isdirectory(ts_lib) == 1 then
          return ts_lib
        end
      end

      -- 4. Try regular which command as fallback
      local ts_path = vim.fn.system("which tsc 2>/dev/null"):gsub("%s+$", "")
      if ts_path ~= "" and vim.fn.executable(ts_path) == 1 then
        local real_path = vim.fn.resolve(ts_path)
        local ts_lib = vim.fn.fnamemodify(real_path, ":h:h") .. "/lib"
        if vim.fn.isdirectory(ts_lib) == 1 then
          return ts_lib
        end
      end

      -- 5. Try global npm root as final fallback
      local global_npm_root = vim.fn.system("npm root -g 2>/dev/null"):gsub("%s+$", "")
      if global_npm_root ~= "" then
        local global_ts = global_npm_root .. "/typescript/lib"
        if vim.fn.isdirectory(global_ts) == 1 then
          return global_ts
        end
      end

      -- 6. Manual check of common Volta locations
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
    -- Lua Language Server
    lspconfig.lua_ls.setup {
      capabilities = capabilities,
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    }

    -- HTML Language Server
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

    -- TypeScript Language Server
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

    -- CSS Language Server (This should fix your CSS completion issues!)
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

    -- Tailwind CSS Language Server
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

    -- Astro Language Server
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

    -- Go Language Server
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
  end,
}
