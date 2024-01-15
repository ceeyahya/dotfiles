local M = {
  "vimwiki/vimwiki",
  event = "BufEnter",
}

function M.init()
  vim.g.vimwiki_list = {
    {
      path = "~/vimwiki",
      path_html = "~/vimwiki/public_html",
      auto_tags = 1,
      auto_diary_index = 1,
      syntax = "markdown",
      ext = ".md",
    },
  }
  vim.g.vimwiki_markdown_link_ext = 1
  vim.g.vimwiki_stripsym = " "
  vim.g.vimwiki_global_ext = 0
end

return M
