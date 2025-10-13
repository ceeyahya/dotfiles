return {
  "olexsmir/gopher.nvim",
  ft = "go",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    gotag = {
      transform = "snakecase",
      default_tag = "json",
    },
  },
  config = function(_, opts)
    require("gopher").setup(opts)

    -- Keymaps for gopher.nvim (only active in Go files)
    local map = vim.keymap.set

    -- Struct tags
    map("n", "<leader>gtj", "<cmd>GoTagAdd json<cr>", { desc = "Add json struct tags" })
    map("n", "<leader>gty", "<cmd>GoTagAdd yaml<cr>", { desc = "Add yaml struct tags" })
    map("n", "<leader>gtx", "<cmd>GoTagRm<cr>", { desc = "Remove all struct tags" })

    -- Error handling
    map("n", "<leader>ge", "<cmd>GoIfErr<cr>", { desc = "Generate if err != nil" })

    -- Test generation
    map("n", "<leader>gta", "<cmd>GoTestAdd<cr>", { desc = "Add test for function" })
    map("n", "<leader>gts", "<cmd>GoTestsAll<cr>", { desc = "Add all tests for file" })
    map("n", "<leader>gte", "<cmd>GoTestsExp<cr>", { desc = "Add tests for exported functions" })

    -- Interface implementation
    map("n", "<leader>gi", "<cmd>GoImpl<cr>", { desc = "Implement interface" })

    -- Doc comments
    map("n", "<leader>gc", "<cmd>GoCmt<cr>", { desc = "Generate doc comment" })

    -- Go get/mod commands
    map("n", "<leader>gg", "<cmd>GoGet ", { desc = "Go get package" })
    map("n", "<leader>gmt", "<cmd>GoMod tidy<cr>", { desc = "Go mod tidy" })
  end,
}
