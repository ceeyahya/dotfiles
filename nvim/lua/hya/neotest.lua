local M = {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-vim-test",

    -- language dependencies
    "nvim-neotest/neotest-python",
    "nvim-neotest/neotest-go",
    "marilari88/neotest-vitest",
    "rouge8/neotest-rust",
  },
}

function M.config()
  local keymap = vim.keymap.set
  local opts = { noremap = true, silent = true }

  keymap("n", "<leader>tt", "<cmd>lua require('neotest').run.run()<CR>", opts)
  keymap("n", "<leader>tf", "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>", opts)
  keymap("n", "<leader>td", "<cmd>lua require('neotest').run.run({ strategy = 'dap' })<CR>", opts)
  keymap("n", "<leader>ts", "<cmd>lua require('neotest').run.stop()<CR>", opts)
  keymap("n", "<leader>ta", "<cmd>lua require('neotest').run.attach()<CR>", opts)

  require("neotest").setup {
    adapters = {
      require "neotest-python" {
        dap = { justMyCode = false },
      },
      require "neotest-vitest",
      require "neotest-go",
      require "neotest-rust",
      require "neotest-vim-test" {
        ignore_file_types = { "python", "vim", "lua", "javascript", "typescript" },
      },
    },
  }
end

return M
