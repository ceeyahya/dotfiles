local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- center when using ctrl + u and ctrl + d
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center cursor after moving down half-page" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center cursor after moving up half-page" })

-- normal mode keymaps --
-- clear search highlight
keymap.set("n", "<Esc>", ":nohl<CR>", opts)

-- don't to clipboard when delete single character
keymap.set("n", "x", '"_x', opts)

-- preserve the clipboard when pasting on top of something
keymap.set("x", "p", [["_dP]])

-- center on search
keymap.set("n", "n", "nzz", opts)
keymap.set("n", "N", "Nzz", opts)
keymap.set("n", "*", "*zz", opts)
keymap.set("n", "#", "#zz", opts)
keymap.set("n", "g*", "g*zz", opts)
keymap.set("n", "g#", "g#zz", opts)

-- split buffer vertically
keymap.set("n", "sv", "<C-w>v", opts)

-- split buffer horizontally
keymap.set("n", "ss", "<C-w>s", opts)

-- close current buffer
keymap.set("n", "sx", ":close<CR>", opts)

-- visual mode keymaps --
-- stay in indent mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- gopher.nvim keymaps
-- keymap.set("n", "<leader>gj", "<CMD> GoTagAdd json <CR>", opts)
-- keymap.set("n", "<leader>gy", "<CMD> GoTagAdd yaml <CR>", opts)
-- keymap.set("n", "<leader>ie", "<CMD> GoIfErr <CR>", opts)

-- Disable horizontal scrolling keymaps
vim.keymap.set({ "n", "i", "v" }, "<ScrollWheelLeft>", "<Nop>", { silent = true })
vim.keymap.set({ "n", "i", "v" }, "<ScrollWheelRight>", "<Nop>", { silent = true })
vim.keymap.set({ "n", "i", "v" }, "<ScrollWheelUp>", "<Nop>", { silent = true })
vim.keymap.set({ "n", "i", "v" }, "<ScrollWheelDown>", "<Nop>", { silent = true })
