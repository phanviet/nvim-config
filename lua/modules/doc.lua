local M = {}

local g = vim.g
local fn = vim.fn
local Plug = fn["plug#"]
local HOME = os.getenv("HOME")

-- Install document packages
M.install = function()
  -- Org mode
  Plug('vimwiki/vimwiki')
end

M.init = function()
  g.vimwiki_list = {{
    path = '~/vimwiki/',
    syntax = 'markdown',
    ext = '.md'
  }}
end

return M
