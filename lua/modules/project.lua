local Util = require("util")
local M = {}

local fn = vim.fn
local Plug = fn["plug#"]

-- Install packages
-- depends: search package
M.install = function()
  -- Sidebar
  Plug("kyazdani42/nvim-web-devicons")
  Plug("kyazdani42/nvim-tree.lua")

  Plug("tpope/vim-projectionist")

  -- Task runner
  Plug("EthanJWright/vs-tasks.nvim")
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

  -- Task runner
  local telescope = require("telescope")
  local vstask = require("vstask")
  Util.nkeymap("<leader>ta", telescope.extensions.vstask.tasks)
  Util.nkeymap("<leader>ti", telescope.extensions.vstask.inputs)
  Util.nkeymap("<leader>th", telescope.extensions.vstask.history)
  Util.nkeymap("<leader>tl", telescope.extensions.vstask.launch)

  vstask.setup({
    cache_json_conf = false, -- don't read the json conf every time a task is ran
    cache_strategy = "last", -- can be "most" or "last" (most used / last used)
    use_harpoon = false, -- use harpoon to auto cache terminals
    telescope_keys = { -- change the telescope bindings used to launch tasks
      vertical = "<C-v>",
      split = "<C-s>",
      tab = "<C-t>",
      current = "<CR>",
    },
    autodetect = { -- auto load scripts
      npm = "on",
    },
    terminal = "toggleterm",
    term_opts = {
      vertical = {
        direction = "vertical",
        size = "80",
      },
      horizontal = {
        direction = "horizontal",
        size = "20",
      },
      current = {
        direction = "horizontal",
        size = "200"
      },
      tab = {
        direction = "tab",
      },
    },
  })
end

return M
