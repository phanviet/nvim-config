local Util = require 'util'
local M = {}

local fn = vim.fn
local Plug = fn['plug#']

-- Install packages
M.install = function ()
  -- Fuzzy Search
  Plug('junegunn/fzf', {
    dir = '~/.fzf',
    ['do'] = './install --all'
  })
  Plug 'junegunn/fzf.vim'
end

M.init = function ()
  Util.nkeymap('<C-P>', ':FZF<CR>')
  Util.nkeymap('<leader>b', ':Buffers<CR>')
end

return M
