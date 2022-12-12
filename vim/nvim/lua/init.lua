
-- Configure language servers for autocompletion and error checking
local on_attach = function(client, bufnr)
  -- Setup the omnifunc that is can be used by completion tools
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
end

-- Helper function that checks for a connected server before issuing an lsp
-- command
function TryLsp(lsp_command)
  if vim.lsp.buf.server_ready() then
   vim.lsp.buf[lsp_command]()
  else
    print("No lsp server currently ready to process this command... Try :LspInfo for more information")
  end
end

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require'lspconfig'.clangd.setup{on_attach = on_attach, capabilities=capabilities}
require'lspconfig'.pyright.setup{on_attach = on_attach, capabilities=capabilities} --  install via pip install pyright
require'lspconfig'.sumneko_lua.setup{on_attach = on_attach, capabilities=capabilities} -- Insall from: https://github.com/sumneko/lua-language-server/wiki/Getting-Started
--require'clangd_extensions'.setup()

-- General nvim settings


-- Status line setup
require('lualine').setup()
require("bufferline").setup{}

-- max popup height
vim.o.pumheight = 10;

-- Show line diagnostics automatically in hover window
 vim.o.updatetime = 250
 vim.cmd [[autocmd CursorHold,CursorHoldI * lua vim.diagnostic.open_float(nil, {focus=false})]]

-- show pretty symbols in the gutter for diagnostics
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

 -- hide inline diagnostic
 vim.diagnostic.config({
     virtual_text = false
   })

-- Set up nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    expand = function(args)
       require('luasnip').lsp_expand(args.body)
    end,
  },
  window = {
        completion = {
      winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      col_offset = -3,
      side_padding = 0,
    },
    documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<tab>'] = cmp.mapping.select_next_item(),
    ['<s-tab>'] = cmp.mapping.select_prev_item(),
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<esc>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' }, -- LSP
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer' },
  }, {
    { name = 'path' }
  }),
  formatting = {
    fields = { "kind", "abbr", "menu" },
    format = function(entry, vim_item)
      local kind = require("lspkind").cmp_format({ mode = "symbol_text", maxwidth = 50 })(entry, vim_item)
      local strings = vim.split(kind.kind, "%s", { trimempty = true })
      kind.kind = " " .. strings[1] .. " "
      kind.menu = "    (" .. strings[2] .. ")"

      return kind
    end,
  },
  --matching.disallow_fuzzy_matching = false,
  --matching.disallow_partial_matching = false
})

-- Use buffer source for `/` and `?` (completion for vim search)
-- NOTE currently this does not work because we use magic search:
-- https://github.com/hrsh7th/cmp-cmdline/issues/14
--cmp.setup.cmdline({ '/', '?' }, {
  --mapping = cmp.mapping.preset.cmdline(),
  --sources = {
    --{ name = 'buffer' }
  --},
  --view = {
    --entries = {name = 'wildmenu', separator = '|' }
  --},
--})

-- Use cmdline & path source for ':'  (completion for in the vim command line)
cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})

