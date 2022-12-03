local Util = require 'util'
local M = {}

local fn = vim.fn
local Plug = fn["plug#"]

-- Install packages
M.install = function()
  Plug("tpope/vim-fugitive")
  Plug("airblade/vim-gitgutter")
  Plug("sindrets/diffview.nvim")

  -- Gist
  Plug("mattn/gist-vim")
end

M.init = function()
  require("diffview").setup({})
  Util.nkeymap("<leader>go", ":DiffviewOpen<CR>")
  Util.nkeymap("<leader>gc", ":DiffviewClose<CR>")
end

return M
