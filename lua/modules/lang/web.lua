local M = {}

local fn = vim.fn
local g = vim.g
local Plug = fn['plug#']

-- Install packages
M.install = function ()
  -- html
  Plug 'mattn/emmet-vim'
  Plug 'othree/html5.vim'
  Plug 'alvan/vim-closetag'

  -- css
  Plug 'hail2u/vim-css3-syntax'
  Plug 'cakebaker/scss-syntax.vim'
  Plug 'ap/vim-css-color'
  Plug 'csscomb/vim-csscomb'
  Plug 'tyru/open-browser.vim'
  Plug 'valloric/MatchTagAlways'

  -- Templates
  Plug 'lepture/vim-velocity'
end

M.init = function ()
end

return M
