local M = {}

local common = require 'modules.common'
local theme = require 'modules.theme'
local project = require 'modules.project'
local tmux = require 'modules.tmux'
local git = require 'modules.git'
local doc = require 'modules.doc'
local search = require 'modules.search'
local ide = require 'modules.ide'

-- langs
local web = require 'modules.lang.web'
local javascript = require 'modules.lang.javascript'
local ruby = require 'modules.lang.ruby'
local clojure = require 'modules.lang.clojure'

-- Install all packages
M.install = function ()
  common.install()
  theme.install()
  project.install()
  tmux.install()
  git.install()
  doc.install()
  search.install()
  ide.install()

  -- langs
  web.install()
  javascript.install()
  ruby.install()
  clojure.install()
end

-- Config and run all packages
M.init = function ()
  common.init()
  theme.init()
  project.init()
  tmux.init()
  git.init()
  doc.init()
  search.init()
  ide.init()

  -- langs
  web.init()
  javascript.init()
  ruby.init()
  clojure.init()
end

return M
