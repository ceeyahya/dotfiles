vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.backup = false
vim.opt.clipboard = "unnamedplus"
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.swapfile = false
vim.opt.termguicolors = true
vim.opt.undofile = true
vim.opt.writebackup = false
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4
vim.opt.signcolumn = "yes"
vim.opt.updatetime = 50
vim.opt.pumheight = 15
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 5
vim.opt.shortmess:append "c"
vim.opt.incsearch = true
vim.opt.cmdheight = 0
-- disable the default status line
vim.opt.laststatus = 0

vim.cmd [[set iskeyword+=-]]
vim.cmd "set whichwrap+=<,>,[,],h,l"
vim.cmd "colorscheme free"

-- add filetypes
vim.filetype.add {
  extension = {
    templ = "templ",
  },
}

vim.filetype.add {
  extension = {
    liquid = "liquid",
  },
}
