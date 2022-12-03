local Util = require("util")
local M = {}

local fn = vim.fn
local Plug = fn["plug#"]

-- Install packages
M.install = function()
  -- Sidebar
  Plug("kyazdani42/nvim-web-devicons")
  Plug("kyazdani42/nvim-tree.lua")

  Plug("tpope/vim-projectionist")
end

M.init = function()
  -- Nvim tree
  local nvim_tree = require("nvim-tree")
  nvim_tree.setup({
    view = {
      width = 40,
      side = "left",
    },
  })
  Util.nkeymap("<leader>t", ":NvimTreeToggle<CR>")
  Util.nkeymap("<leader>r", ":NvimTreeRefresh<CR>")
  Util.nkeymap("<leader>\\", ":NvimTreeFindFile<CR>")
end

return M
