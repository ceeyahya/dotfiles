-- Prevent creation of new comment line when pressing o/O
vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})

-- Press q to quit special windows
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "qf",
    "help",
    "man",
    "lspinfo",
    "Oil",
    "oil",
    "lazy",
    "mason",
  },
  callback = function()
    vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = true, silent = true })
    vim.opt_local.buflisted = false
  end,
})

-- Yank feedback (great UX, minimal performance cost)
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 40 }
  end,
})

-- Markdown and git commit settings
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Language-specific indentation
vim.api.nvim_create_autocmd("FileType", {
  pattern = "go",
  callback = function()
    vim.opt_local.expandtab = false
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

-- You can add Python, JS, etc. here too:
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
    vim.opt_local.softtabstop = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "typescript", "json", "lua" },
  callback = function()
    vim.opt_local.expandtab = true
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
    vim.opt_local.softtabstop = 2
  end,
})

-- Override separator color in LSP hover markdown
vim.api.nvim_create_autocmd("BufWinEnter", {
  callback = function(args)
    local win = vim.api.nvim_get_current_win()
    local win_config = vim.api.nvim_win_get_config(win)
    local buftype = vim.api.nvim_get_option_value("buftype", { buf = args.buf })

    -- Only apply in floating windows with markdown-like content
    if win_config.relative ~= "" and (buftype == "nofile" or buftype == "") then
      local ft = vim.api.nvim_get_option_value("filetype", { buf = args.buf })
      if ft == "markdown" or ft == "" then
        vim.fn.matchadd("LspSeparator", "─", 10)
      end
    end
  end,
})
