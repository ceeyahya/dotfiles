local M = {
  "christoomey/vim-tmux-navigator",
  cmd = {
    "TmuxNavigateLeft",
    "TmuxNavigateDown",
    "TmuxNavigateUp",
    "TmuxNavigateRight",
    "TmuxNavigatePrevious",
  },
}

function M.config() end

M.keys = {
  { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
  { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
  { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
  { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
  { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
}

return M
