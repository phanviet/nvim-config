local Util = require 'util'
local M = {}

local fn = vim.fn
local Plug = fn['plug#']

-- Install all common packages
M.install = function ()
  Plug 'christoomey/vim-tmux-navigator'
  Plug 'benmills/vimux'
end

M.init = function ()
  Util.nkeymap('<leader>vp', ':VimuxPromptCommand<CR>')
  Util.nkeymap('<leader>vl', ':VimuxRunLastCommand<CR>')
end

return M
