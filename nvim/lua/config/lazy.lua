local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy with performance optimizations
require("lazy").setup {
  -- Start with empty spec, add { import = "plugins" } later when you have plugin files
  spec = {
    { import = "plugins" },
  },
  defaults = {
    lazy = true, -- Make all plugins lazy by default
    version = "*", -- Use latest stable tagged versions
  },
  install = {
    missing = true,
    colorscheme = { "free" }, -- Fallback colorscheme during install
  },
  checker = {
    enabled = false, -- Disable automatic update checking for performance
    notify = false,
  },
  change_detection = {
    enabled = false, -- Disable auto-reload on config changes
    notify = false,
  },
  ui = {
    size = { width = 0.8, height = 0.8 },
    border = "single",
    icons = {
      cmd = " ",
      config = "",
      event = "",
      ft = " ",
      init = " ",
      import = " ",
      keys = " ",
      lazy = "󰒲 ",
      loaded = "●",
      not_loaded = "○",
      plugin = " ",
      runtime = " ",
      require = "󰢱 ",
      source = " ",
      start = "",
      task = "✔ ",
      list = {
        "●",
        "➜",
        "★",
        "‒",
      },
    },
  },
  performance = {
    cache = {
      enabled = true,
    },
    reset_packpath = true, -- Reset the package path to improve startup time
    rtp = {
      reset = true, -- Reset the runtime path to $VIMRUNTIME and your config directory
      paths = {}, -- Add any custom paths here that you need
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}
