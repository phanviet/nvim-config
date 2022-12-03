local M = {}

local fn = vim.fn
local Plug = fn['plug#']

-- Install packages
M.install = function ()
  Plug 'clojure-vim/vim-jack-in'
  Plug 'guns/vim-sexp'
  Plug 'tpope/vim-sexp-mappings-for-regular-people'
end

M.init = function ()
end

return M
