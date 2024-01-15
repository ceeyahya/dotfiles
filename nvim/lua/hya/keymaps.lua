local keymap = vim.keymap
local opts = { noremap = true, silent = true }

keymap.set("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- normal mode keymaps --
-- clear search highlight
keymap.set("n", "<Esc>", ":nohl<CR>", opts)

-- don't to clipboard when delete single character
keymap.set("n", "x", '"_x', opts)
-- preserve the clipboard when pasting on top of something
keymap.set("x", "p", [["_dP]])

-- better window navigation
keymap.set("n", "<C-h>", "<C-w>h", opts)
keymap.set("n", "<C-j>", "<C-w>j", opts)
keymap.set("n", "<C-k>", "<C-w>k", opts)
keymap.set("n", "<C-l>", "<C-w>l", opts)

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

-- use Alt key + arrows to resize
keymap.set("n", "<M-Up>", ":resize +2<CR>", opts)
keymap.set("n", "<M-Down>", ":resize -2<CR>", opts)
keymap.set("n", "<M-Right>", ":vertical resize +2<CR>", opts)
keymap.set("n", "<M-Left>", ":vertical resize -2<CR>", opts)

-- use Shift l and h to jump to the begining or end of the line
keymap.set({ "n", "o", "x" }, "<s-h>", "^", opts)
keymap.set({ "n", "o", "x" }, "<s-l>", "g_", opts)

-- navigate through buffers
keymap.set("n", "<S-l>", ":bnext<CR>", opts)
keymap.set("n", "<S-h>", ":bprevious<CR>", opts)
keymap.set("n", "<leader>w", ":bdelete<CR>", opts)

-- insert mode keymaps --
keymap.set("i", "jk", "<ESC>", opts)

-- visual Mode Keymaps --
-- stay in indent mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- nvim tree toggle
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", opts)
