local M = {
  "eandrju/cellular-automaton.nvim",
  event = "VeryLazy",
}

function M.config()
  vim.keymap.set("n", "<leader>fm", "<cmd>CellularAutomaton make_it_rain<CR>")
end

return M
