local Util = require("util")

local g = vim.g
local opt = vim.opt
local HOME = os.getenv("HOME")

g.mapleader = ","
g.maplocalleader = " "
g["$LANG"] = "en_US"
g.python3_host_prog = HOME .. "/venv/bin/python"

opt.mouse = "a"
opt.langmenu = "en_US"
opt.list = true
opt.autoindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
opt.expandtab = true
opt.swapfile = false
opt.clipboard = "unnamedplus"
opt.autoread = true
opt.termguicolors = true
opt.colorcolumn = "+120"
opt.signcolumn = "yes:1"
opt.foldmethod = "syntax"
opt.foldlevelstart = 99
opt.completeopt = "menu,menuone,noselect"
opt.number = true
opt.relativenumber = true
opt.hlsearch = true

-- DEFAULT KEY MAPPING
----------------------------------
-- Back to VIM normal mode
Util.ikeymap("jj", "<ESC>")

-- Navigation
Util.nkeymap("<c-j>", "<c-w>j")
Util.nkeymap("<c-k>", "<c-w>k")
Util.nkeymap("<c-h>", "<c-w>h")
Util.nkeymap("<c-l>", "<c-w>l")

-- Split window
Util.nkeymap("vv", ":vsplit<CR>")
Util.nkeymap("ss", ":split<CR>")

-- Toggle highlight
Util.nkeymap("<leader>hl", ":set hlsearch!<CR>")

-- Back to previous buffer
Util.nkeymap("gb", ":b#<CR>")
