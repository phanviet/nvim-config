local Util = require("util")

local M = {}

local fn = vim.fn
local g = vim.g
local opt = vim.opt
local Plug = fn["plug#"]

-- Install all common packages
M.install = function()
  -- Common useful lua function for neovim
  Plug("nvim-lua/plenary.nvim")
  Plug("antoinemadec/FixCursorHold.nvim")

  -- Dispatch
  Plug("tpope/vim-dispatch")
  Plug("radenling/vim-dispatch-neovim")

  Plug("tpope/vim-surround")
  Plug("nvim-treesitter/nvim-treesitter", { ["do"] = ":TSUpdate" })

  -- Aligment
  Plug("godlygeek/tabular")
  Plug("nathanaelkane/vim-indent-guides")

  -- Comment
  Plug("tomtom/tcomment_vim")

  -- Quick move in file
  Plug("easymotion/vim-easymotion")

  Plug("tpope/vim-repeat")
  Plug("mg979/vim-visual-multi", { branch = "master" })

  -- Code folding
  Plug("kevinhwang91/promise-async")
  Plug("kevinhwang91/nvim-ufo")

  Plug("akinsho/toggleterm.nvim", { tag = "*" })

  -- image
  Plug("edluffy/hologram.nvim")
end

M.init = function()
  -- Indent guides
  g.indent_guides_start_level = 2
  g.indent_guides_guide_size = 1
  Util.nkeymap("<leader>ti", ":IndentGuidesToggle<cr>")

  -- Tabular Alignment config
  Util.vkeymap("<leader>a= :Tabularize /=<CR>")
  Util.vkeymap("<leader>a: :Tabularize /:<CR>")
  Util.vkeymap("<leader>a, :Tabularize /,<CR>")

  -- Tree-sitter configuration
  require("nvim-treesitter.configs").setup({
    -- If TS highlights are not enabled at all, or disabled via `disable` prop, highlighting will fallback to default Vim syntax highlighting
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = { "org" }, -- Required for spellcheck, some LaTex highlights and code block highlights that do not have ts grammar
    },
    ensure_installed = { "org" }, -- Or run :TSUpdate org
  })

  -- Folding
  local Ufo = require("ufo")
  Util.nkeymap("zR", Ufo.openAllFolds)
  Util.nkeymap("zM", Ufo.openAllFolds)
  Ufo.setup({
    provider_selector = function(bufnr, filetype, buftype)
      return { "treesitter", "indent" }
    end,
  })

  opt.foldcolumn = "1"
  opt.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
  opt.foldlevelstart = 99
  opt.foldenable = true

  require("toggleterm").setup()

  -- hologram
  require("hologram").setup({
    auto_display = true,
  })
end

return M
