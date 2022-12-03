local M = {}

local fn = vim.fn
local g = vim.g
local Plug = fn['plug#']

-- Install packages
M.install = function ()
  Plug 'vim-ruby/vim-ruby'
  Plug 'tpope/vim-rails'
  Plug 'tpope/vim-endwise'
end

M.init = function ()
end

return M
