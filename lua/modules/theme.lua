local M = {}

local fn = vim.fn
local cmd = vim.cmd
local opt = vim.opt

local Plug = fn["plug#"]

-- Install theme packages
M.install = function()
  Plug("xiyaowong/nvim-transparent")
  Plug("phanviet/nvim-cursor")

  -- Theme
  Plug("sjl/badwolf")
  Plug("olivercederborg/poimandres.nvim")

  -- Status line
  Plug("nvim-lualine/lualine.nvim")
end

-- Config
--------------------------------------------------
M.init = function()
  require("transparent").setup({
    enable = true,
  })

  require("nvim-cursor").setup({
    normalModeColor = "yellow",
    insertModeColor = "yellow",
  })

  require("poimandres").setup({})
  -- cmd 'colorscheme poimandres'
  opt.background = "dark"
  cmd 'colorscheme badwolf'
end

return M
