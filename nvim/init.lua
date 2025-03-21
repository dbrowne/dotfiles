vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
    config = function()
            require "options"
    end,
  },

  { import = "plugins" },
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "nvchad.autocmds"

vim.schedule(function()
  require "mappings"
end)

local telescope = require('telescope')
vim.fn.sign_define('DapBreakpoint', { text = '�~W~O', texthl = 'DapBreakpoint', numhl = 'DapBreakpoint' })
vim.api.nvim_set_hl(0, "DapBreakpoint", { fg = "#ff0000", bold = true })

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd [[
      highlight @comment.documentation guifg=#00ff00 gui=bold
      highlight @doc_comment guifg=#00ff00 gui=bold
    ]]
  end
})



telescope.setup {
  defaults = {
    file_ignore_patterns = {"target/.*", "%.lock", "node_modules/.*", "git/.*"},
  },
  pickers = {
    find_files = {
      hidden = true
    }
  }
}
