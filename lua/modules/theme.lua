local M = {}

local fn = vim.fn
local cmd = vim.cmd

local Plug = fn['plug#']

-- Install theme packages
M.install = function ()
  -- Theme
  Plug 'sjl/badwolf'
  Plug 'olivercederborg/poimandres.nvim'

  -- Status line
  Plug 'nvim-lualine/lualine.nvim'
end

-- Config
--------------------------------------------------
M.init = function ()
  require('poimandres').setup({})
  cmd 'colorscheme poimandres'
end

return M
