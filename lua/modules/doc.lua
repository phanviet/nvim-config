local M = {}

local fn = vim.fn
local Plug = fn["plug#"]

-- Install document packages
M.install = function()
  -- Org mode
  Plug("nvim-orgmode/orgmode")
end

M.init = function()
  local orgmode = require("orgmode")
  orgmode.setup_ts_grammar()
  orgmode.setup({
    org_agenda_files = { "~/.orgs/**/*" },
    org_default_notes_file = "~/.orgs/main.org",
  })
end

return M
