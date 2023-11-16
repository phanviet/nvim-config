local Util = require("util")

local Plug = vim.fn['plug#']

local M = {}

local module_names = {
  'common',
  'rest',
  'theme',
  'search',
  'project',
  'tmux',
  'git',
  'doc',
  'ide',

  -- lang
  'lang.web',
  'lang.javascript',
  'lang.ruby',
  'lang.clojure',
}

-- require all modules
local modules = Util.map(function(name)
  return require('modules.' .. name)
end, module_names)


local install_module = function(m) m.install() end
local init_module = function(m) m.init() end

local install_modules = function(ms) Util.each(install_module, ms) end
local init_modules = function(ms) Util.each(init_module, ms) end

-- Install all packages
M.install = function()
  install_modules(modules)
end

-- Config and run all packages
M.init = function()
  init_modules(modules)
end

return M
