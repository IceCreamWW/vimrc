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

vim.g.copilot_no_tab_map = true

-- set grepprg to use ripgrep
vim.opt.grepprg = "ack --nogroup --column $*"
vim.opt.grepformat = "%f:%l:%c:%m"


require("nvim-tree").setup({
  filters = {
    dotfiles = true,
  },
})
vim.notify = require("notify")
-- ~/.config/nvim/lua/custom/init.lua

vim.cmd([[cnoreabbrev w silent! w \| file]])
vim.cmd([[cnoreabbrev wq silent! wq]])
vim.cmd([[cnoreabbrev wa silent! wa \| file]])
vim.cmd([[cnoreabbrev wqa silent! wqa]])
-- set noignorecase
vim.opt.ignorecase = false

vim.api.nvim_create_autocmd("BufReadPost", {
callback = function()
  local last_position = vim.fn.line("'\"")
  if last_position > 1 and last_position <= vim.fn.line("$") then
    vim.api.nvim_command("normal! g'\"")
  end
end,
})


local cmp = require('cmp')
vim.o.completeopt = "noselect"

cmp.setup({
  completion = {
    completeopt = 'noselect',
  },
  preselect = cmp.PreselectMode.None,  -- Disable preselection
  mapping = {
    ["<CR>"] = cmp.config.disable,
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
      else
        fallback()  -- Default fallback, such as inserting a tab character
      end
    end, { 'i', 's' }),
  },
})
