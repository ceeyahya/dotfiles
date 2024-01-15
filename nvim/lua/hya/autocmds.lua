-- prevent creation of new comment line when pressing o/O
vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    vim.cmd "set formatoptions-=cro"
  end,
})

-- press q to quit the windows in the list
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "netrw",
    "Jaq",
    "qf",
    "git",
    "help",
    "man",
    "lspinfo",
    "spectre_panel",
    "lir",
    "DressingSelect",
    "tsplayground",
    "Oil",
    "oil",
  },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  pattern = { "*" },
  callback = function()
    vim.cmd "checktime"
  end,
})

-- yank feedback
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 40 }
  end,
})

-- set wrap and spell in markdown and git commit
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "markdown", "gitcommit" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "CursorHold" }, {
  callback = function()
    local status_ok, luasnip = pcall(require, "luasnip")

    if not status_ok then
      return
    end

    if luasnip.expand_or_jumpable() then
      vim.cmd [[silent! lua require("luasnip").unlink_current() ]]
    end
  end,
})
