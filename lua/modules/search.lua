local Util = require("util")
local M = {}

local fn = vim.fn
local Plug = fn["plug#"]

-- Install packages
M.install = function()
  -- Fuzzy Search
  Plug("junegunn/fzf", {
    dir = "~/.fzf",
    ["do"] = "./install --all",
  })
  Plug("junegunn/fzf.vim")

  -- General fuzzy finder
  Plug('nvim-telescope/telescope-fzf-native.nvim', {['do']='make'})
  Plug("nvim-telescope/telescope.nvim")
end

M.init = function()
  Util.nkeymap("<C-P>", ":FZF<CR>")
  Util.nkeymap("<leader>b", ":Buffers<CR>")

  -- Telescope
  local telescope = require('telescope')
  local telescope_builtin = require('telescope.builtin')
  Util.nkeymap('<leader>ff', telescope_builtin.find_files)
  Util.nkeymap('<leader>fg', telescope_builtin.live_grep)
  Util.nkeymap('<leader>fb', telescope_builtin.buffers)
  Util.nkeymap('<leader>fh', telescope_builtin.help_tags)

  telescope.setup({
    extensions = {
      fzf = {
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                         -- the default case_mode is "smart_case"
      }
    }
  })

  telescope.load_extension('fzf')
end

return M
