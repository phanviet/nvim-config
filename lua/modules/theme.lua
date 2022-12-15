local M = {}

local fn = vim.fn
local cmd = vim.cmd

local Plug = fn['plug#']

-- Install theme packages
M.install = function ()
  Plug 'xiyaowong/nvim-transparent'

  -- Theme
  Plug 'sjl/badwolf'
  Plug 'olivercederborg/poimandres.nvim'

  -- Status line
  Plug 'nvim-lualine/lualine.nvim'
end

-- Config
--------------------------------------------------
M.init = function ()
  require('transparent').setup({
    enable = true
  })
  require('poimandres').setup({})
  -- cmd 'colorscheme poimandres'
  -- cmd 'colorscheme badwolf'
end

return M
