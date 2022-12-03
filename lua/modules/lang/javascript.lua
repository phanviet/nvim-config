local M = {}

local fn = vim.fn
local g = vim.g
local Plug = fn['plug#']

-- Install packages
M.install = function ()
  Plug 'pangloss/vim-javascript'
  Plug 'maksimr/vim-jsbeautify'
  Plug 'heavenshell/vim-jsdoc'
end

M.init = function ()
  -- Disable polygot syntax highlight
  g.polygot_disabled = {'javascript'}
end

return M
