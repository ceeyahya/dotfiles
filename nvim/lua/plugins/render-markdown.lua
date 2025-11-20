return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = "markdown",
  opts = {
    file_types = { "markdown" },
    enabled = false,
    render_modes = true, -- Always render, never toggle
    heading = {
      backgrounds = {},  -- Remove heading backgrounds
      icons = {},
      foregrounds = {
        "RenderMarkdownH1",
        "RenderMarkdownH2",
        "RenderMarkdownH3",
        "RenderMarkdownH4",
        "RenderMarkdownH5",
        "RenderMarkdownH6",
      },
      position = "inline",
      sign = false,
      width = "full",
    },
  },
  config = function(_, opts)
    require("render-markdown").setup(opts)

    -- Auto-enable only for Cerebro files
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = { "*/cerebro/zettelkasten/*.md", "*/cerebro/scratchpad/*.md" },
      callback = function()
        require("render-markdown").enable()
      end,
    })

    -- Auto-disable for other markdown files
    vim.api.nvim_create_autocmd("BufLeave", {
      pattern = { "*/cerebro/zettelkasten/*.md", "*/cerebro/scratchpad/*.md" },
      callback = function()
        require("render-markdown").disable()
      end,
    })
  end,
}
