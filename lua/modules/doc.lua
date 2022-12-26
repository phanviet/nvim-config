local M = {}

local g= vim.g
local fn = vim.fn
local Plug = fn["plug#"]
local HOME = os.getenv("HOME")

-- Install document packages
M.install = function()
  -- Org mode
  Plug("nvim-orgmode/orgmode")
end

M.init = function()
  local orgmode = require("orgmode")
  orgmode.setup_ts_grammar()
  orgmode.setup({
    org_agenda_files = { HOME .. "/.orgs/**/*" },
    org_default_notes_file = HOME .. "/.orgs/main.org",
  })
end

return M
