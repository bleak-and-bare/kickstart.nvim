require 'acf.dap'
require 'acf.keymaps'
require 'acf.commands'
require 'acf.blink'

local colorscheme = require 'acf.colorscheme'
colorscheme.setupTheme()

vim.opt.rnu = true

vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>pv', vim.cmd.Ex)

-- use space
vim.opt.expandtab = true

-- number of spaces for a tab
vim.opt.tabstop = 4

-- do not display white chars
vim.opt.list = false

-- number of spaces for indentation
vim.opt.shiftwidth = 4

vim.opt.autoindent = true
vim.opt.smartindent = true

-- enable scope folding
vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'

-- enable global status only
vim.api.nvim_create_autocmd('User', {
  pattern = 'VeryLazy',
  callback = function()
    vim.opt.laststatus = 3
  end,
})

-- make file explorer follow code buffer
require('neo-tree').setup {
  sources = { 'filesystem', 'buffers', 'git_status' },
  filesystem = {
    follow_current_file = {
      enabled = true,
    },
    use_libuv_file_watcher = true,
  },
}

-- enable breadcrumb
require('breadcrumbs').setup()
