return {
  "vimwiki/vimwiki",
  event = "BufEnter *.md",
  keys = {
    { "<leader>ww", "<cmd>VimwikiIndex<cr>",   desc = "Open Zettelkasten index" },
    { "<leader>ws", "<cmd>VimwikiIndex 2<cr>", desc = "Open Scratchpad index" },
    {
      "<leader>wp",
      function()
        local date = os.date "%Y-%m-%d"
        local filepath = vim.fn.expand("~/cerebro/scratchpad/" .. date .. ".md")
        vim.cmd("edit " .. filepath)
      end,
      desc = "Open today's scratchpad",
    },
    {
      "<leader>wn",
      function()
        local title = vim.fn.input "Note title: "
        if title == "" then
          print "Cancelled"
          return
        end

        -- Convert title to kebab-case
        local filename = title:lower():gsub("%s+", "-"):gsub("[^%w%-]", "")
        local timestamp = os.date "%Y%m%d%H%M%S"
        local full_filename = timestamp .. "-" .. filename .. ".md"
        local filepath = vim.fn.expand("~/cerebro/zettelkasten/" .. full_filename)

        -- Create ISO 8601 timestamp
        local iso_timestamp = os.date "%Y-%m-%dT%H:%M:%S"

        vim.cmd("edit " .. filepath)

        -- Insert YAML frontmatter and title
        local template = {
          "---",
          "title:" .. title,
          "tags: []",
          "type: ",
          "company: ",
          "created: " .. iso_timestamp,
          "---",
          "",
          "",
          "",
        }
        vim.api.nvim_buf_set_lines(0, 0, 0, false, template)
        vim.cmd "normal! G"
      end,
      desc = "New Zettel note",
    },
  },
  init = function()
    vim.g.vimwiki_list = {
      {
        path = "~/cerebro/zettelkasten/",
        syntax = "markdown",
        ext = ".md",
      },
      {
        path = "~/cerebro/scratchpad/",
        syntax = "markdown",
        ext = ".md",
      },
    }
    vim.g.vimwiki_markdown_link_ext = 1
    vim.g.vimwiki_global_ext = 0

    -- Disable vimwiki keybindings that conflict
    vim.g.vimwiki_key_mappings = {
      all_maps = 1,
      global = 1,
      headers = 0,
      text_objs = 1,
      table_format = 1,
      table_mappings = 1,
      lists = 1,
      links = 1,
      html = 1,
      mouse = 0,
    }
  end,
  config = function()
    -- Force markdown filetype for Cerebro files AFTER vimwiki loads
    vim.api.nvim_create_autocmd("FileType", {
      pattern = "vimwiki",
      callback = function()
        local filepath = vim.fn.expand "%:p"
        if filepath:match "cerebro/zettelkasten" or filepath:match "cerebro/scratchpad" then
          vim.bo.filetype = "markdown"
        end

        -- Scratchpad-specific keymaps
        if filepath:match "cerebro/scratchpad" then
          vim.keymap.set("n", "<leader>wd", function()
            local date = os.date "%Y-%m-%d"
            vim.api.nvim_put({ date }, "c", true, true)
          end, { buffer = true, desc = "Insert today's date" })

          vim.keymap.set("n", "<leader>wh", function()
            vim.api.nvim_put({ "---" }, "l", true, true)
          end, { buffer = true, desc = "Insert separator" })
        end
      end,
    })
  end,
}
