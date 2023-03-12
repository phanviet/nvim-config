local M = {}

local api = vim.api
local keymap = vim.keymap

M.flatten = function(t)
  local ret = {}
  for _, v in ipairs(t) do
    if type(v) == "table" then
      for _, fv in ipairs(M.flatten(v)) do
        ret[#ret + 1] = fv
      end
    else
      ret[#ret + 1] = v
    end
  end
  return ret
end

-- Curry function
M.curry = function(func, num_args)
  num_args = num_args or debug.getinfo(func, "u").nparams
  if num_args < 2 then
    return func
  end
  local function helper(argtrace, n)
    if n < 1 then
      return func(unpack(M.flatten(argtrace)))
    else
      return function(...)
        return helper({ argtrace, ... }, n - select("#", ...))
      end
    end
  end
  return helper({}, num_args)
end

-- array helpers
M.each = function(handler, array)
  for i=1,#array do
    handler(array[i])
  end
end

M.map = function(handler, array)
  local rs = {}
  for i=1,#array do
    rs[i] = handler(array[i])
  end
  return rs
end

-- General VIM key mapping
M.keymap = function(mode, key, command, opts)
  local cmd = keymap.set
  if type(command) == "string" then
    cmd = api.nvim_set_keymap
  end

  if not opts then
    opts = { noremap = true, silent = true }
  end

  cmd(mode, key, command, opts)
end

local curried_keymap = M.curry(M.keymap, 3)
-- VIM key mapping in normal mode
M.nkeymap = curried_keymap("n")
M.ikeymap = curried_keymap("i")
M.vkeymap = curried_keymap("v")
M.tkeymap = curried_keymap("t")

return M
