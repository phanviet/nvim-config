local Util = require("util")
local M = {}

local fn = vim.fn
local g = vim.g
local api = vim.api
local inspect = vim.inspect
local Plug = fn["plug#"]

-- Install ide base packages
M.install = function()
  -- Syntax
  Plug("sheerun/vim-polyglot")
  Plug("sbdchd/neoformat")
  Plug("lukas-reineke/lsp-format.nvim")
  Plug("luochen1990/rainbow")

  -- Testing
  Plug("vim-test/vim-test")

  -- Style guide
  Plug("editorconfig/editorconfig-vim")

  -- Debug
  Plug("puremourning/vimspector")

  -- LSP
  Plug("neovim/nvim-lspconfig")
  Plug("hrsh7th/cmp-nvim-lsp")
  Plug("hrsh7th/cmp-buffer")
  Plug("hrsh7th/cmp-path")
  Plug("hrsh7th/cmp-cmdline")
  Plug("L3MON4D3/LuaSnip")
  Plug("hrsh7th/nvim-cmp")
  Plug("saadparwaiz1/cmp_luasnip")
  Plug("windwp/nvim-autopairs")
  Plug("glepnir/lspsaga.nvim")

  Plug("williamboman/mason.nvim")
  Plug("williamboman/mason-lspconfig.nvim")

  -- REPL
  Plug("jpalardy/vim-slime")
end

local has_words_before = function()
  local line, col = unpack(api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

M.init = function()
  g.rainbow_active = 1

  -- vim test
  Util.nkeymap("<leader>tn", ":TestNearest<CR>")
  Util.nkeymap("<leader>tf", ":TestFile<CR>")
  Util.nkeymap("<leader>ts", ":TestSuite<CR>")
  Util.nkeymap("<leader>tl", ":TestLast<CR>")
  Util.nkeymap("<leader>tv", ":TestVisit<CR>")

  -- vim slime
  g.slime_target = "tmux"
  g.slime_default_config = { socket_name = "default", target_pane = ":.1" }

  -- Auto format
  Util.nkeymap("<space>fm", ":Neoformat<CR>")

  -- LSP
  --------------------------------------------------
  local lspformat = require("lsp-format")
  local mason = require("mason")
  local luasnip = require("luasnip")
  local cmp = require("cmp")
  -- lspformat.setup({
  --   lua = { tab_width = 4 },
  -- })

  -- Manage external editor tooling such as LSP servers, DAP servers, linters, and formatters through a single interface
  mason.setup()
  require("mason-lspconfig").setup()

  -- Auto completion
  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
        require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

      -- ["<Tab>"] = cmp.mapping(function(fallback)
      --   if cmp.visible() then
      --     cmp.select_next_item()
      --   elseif luasnip.expand_or_jumpable() then
      --     luasnip.expand_or_jump()
      --   elseif has_words_before() then
      --     cmp.complete()
      --   else
      --     fallback()
      --   end
      -- end, { "i", "s" }),

      -- ["<S-Tab>"] = cmp.mapping(function(fallback)
      --   if cmp.visible() then
      --     cmp.select_prev_item()
      --   elseif luasnip.jumpable(-1) then
      --     luasnip.jump(-1)
      --   else
      --     fallback()
      --   end
      -- end, { "i", "s" }),
    }),

    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "luasnip" }, -- For luasnip users.
      { name = "orgmode" },
    }, {
      { name = "buffer" },
    }),
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
      { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = "buffer" },
    }),
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = "path" },
    }, {
      { name = "cmdline" },
    }),
  })

  -- Setup lspconfig.
  local lspconfig = require("lspconfig")
  local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

  -- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
  local lspservers = {
    "lua_ls", -- lua
    "tsserver",
    "vimls", -- vim script
    "solargraph", -- ruby
    "clojure_lsp", -- clojure
    "terraformls", -- terraform
    "bashls", -- bash
    "yamlls", -- yaml
    "solidity", -- solidity
    "pyright", -- python
  }
  local diagnostic = vim.diagnostic
  local lsp = vim.lsp

  Util.nkeymap("<space>e", diagnostic.open_float)
  Util.nkeymap("[d", diagnostic.goto_prev)
  Util.nkeymap("]d", diagnostic.goto_next)
  Util.nkeymap("<space>q", diagnostic.setloclist)

  local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")

    -- autoformat
    lspformat.on_attach(client, bufnr)

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    Util.nkeymap("gD", lsp.buf.declaration, bufopts)
    Util.nkeymap("gd", lsp.buf.definition, bufopts)
    Util.nkeymap("K", lsp.buf.hover, bufopts)
    Util.nkeymap("gi", lsp.buf.implementation, bufopts)
    Util.nkeymap("<C-k>", lsp.buf.signature_help, bufopts)
    Util.nkeymap("<space>wa", lsp.buf.add_workspace_folder, bufopts)
    Util.nkeymap("<space>wr", lsp.buf.remove_workspace_folder, bufopts)
    Util.nkeymap("<space>wl", function()
      print(inspect(lsp.buf.list_workspace_folders()))
    end, bufopts)
    Util.nkeymap("<space>D", lsp.buf.type_definition, bufopts)
    Util.nkeymap('<space>rn', lsp.buf.rename, bufopts)
    Util.nkeymap('<space>ca', lsp.buf.code_action, bufopts)
    Util.nkeymap("gr", lsp.buf.references, bufopts)
    Util.nkeymap("<space>f", lsp.buf.format, bufopts)
  end

  local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150,
  }

  for i = 1, #lspservers do
    local s = lspservers[i]
    lspconfig[s].setup({
      capabilities = capabilities,
      on_attach = on_attach,
      flags = lsp_flags,
    })
  end

  require("nvim-autopairs").setup({})
  require("lspsaga").setup()
  local lspsaga_diagnostic = require("lspsaga.diagnostic")

  Util.nkeymap("<leader>ca", "<cmd>Lspsaga code_action<CR>")
  Util.vkeymap("<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>")
  Util.nkeymap("gh", "<cmd>Lspsaga lsp_finder<CR>")
  Util.nkeymap("<leader>rn", "<cmd>Lspsaga rename<CR>")
  Util.nkeymap("gd", "<cmd>Lspsaga peek_definition<CR>")

  -- Show line diagnostics
  Util.nkeymap("<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>")

  -- Show cursor diagnostic
  Util.nkeymap("<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>")

  -- Diagnsotic jump can use `<c-o>` to jump back
  Util.nkeymap("[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
  Util.nkeymap("]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

  -- Only jump to error
  Util.nkeymap("[E", function()
    lspsaga_diagnostic.goto_prev({ severity = diagnostic.severity.ERROR })
  end)
  Util.nkeymap("]E", function()
    lspsaga_diagnostic.goto_next({ severity = diagnostic.severity.ERROR })
  end)

  -- Outline
  Util.nkeymap("<leader>o", "<cmd>LSoutlineToggle<CR>")

  -- Hover Doc
  Util.nkeymap("K", "<cmd>Lspsaga hover_doc<CR>")

  -- Float terminal
  Util.nkeymap("<A-d>", "<cmd>Lspsaga open_floaterm<CR>")
  -- if you want pass somc cli command into terminal you can do like this
  -- open lazygit in lspsaga float terminal
  Util.nkeymap("<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>")
  -- close floaterm
  Util.tkeymap("<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]])
end

return M
