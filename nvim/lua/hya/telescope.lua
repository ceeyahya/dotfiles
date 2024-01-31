local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = { { "nvim-telescope/telescope-fzf-native.nvim", build = "make", lazy = true } },
  command = "Telescope",
}
function M.config()
  local keymap = vim.keymap
  local builtin = require "telescope.builtin"
  local icons = require "hya.icons"
  local actions = require "telescope.actions"
  local themes = require "telescope.themes"

  keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Fuzzy find files in cwd" })
  keymap.set("n", "<leader>bb", builtin.buffers, { desc = "Find Buffer" })
  keymap.set("n", "<leader>fo", builtin.oldfiles, { desc = "Fuzzy find recent files" })
  keymap.set("n", "<leader>fw", builtin.live_grep, { desc = "Find string in cwd" })
  keymap.set("n", "<leader>fc", builtin.grep_string, { desc = "Find string under cursor in cwd" })

  require("telescope").setup {
    defaults = {
      borderchars = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
      prompt_prefix = icons.ui.Search .. " ",
      selection_caret = icons.ui.Triangle .. " ",
      entry_prefix = "   ",
      initial_mode = "insert",
      selection_strategy = "reset",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      path_display = { "smart" },
      color_devicons = true,
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git",
      },

      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
        n = {
          ["<esc>"] = actions.close,
          ["q"] = actions.close,
          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
        },
      },
    },
    pickers = {
      live_grep = {},
      grep_string = {},
      find_files = {
        previewer = true,
      },
      buffers = {
        previewer = false,
        initial_mode = "normal",
        mappings = {
          i = {
            ["<C-d>"] = actions.delete_buffer,
          },
          n = {
            ["dd"] = actions.delete_buffer,
          },
        },
      },
      planets = {
        show_pluto = true,
        show_moon = true,
      },
      lsp_references = {
        initial_mode = "normal",
      },
      lsp_definitions = {
        initial_mode = "normal",
      },
      lsp_declarations = {
        initial_mode = "normal",
      },
      lsp_implementations = {
        initial_mode = "normal",
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  }
end

return M
