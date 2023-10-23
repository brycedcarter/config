
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
--require'clangd_extensions'.setup()

-- General nvim settings

-- nvim-tree vinegar style setup
require("nvim-tree").setup{
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = true,
--view = {   # Seems to be deprecated by pluging... need to figure out how the
--new system works
    --mappings = {
      --list = {
        --{ key = "<CR>", action = "edit_in_place" }
      --}
    --}
  --},
        renderer = {
        highlight_opened_files = "all"
      },
        hijack_directories = {
        enable = true,
      },
actions = {
change_dir = {
-- NOTE: netrw-style, do not change the cwd when navigating
enable = false,
},
},
}
-- NOTE: disable fixed nvim-tree width and height
-- to allow creating splits naturally
local winopts = require("nvim-tree.view").View.winopts
winopts.winfixwidth = false
winopts.winfixheight = false

function ExploreCurrentFileDir()
  require("nvim-tree").open_replacing_current_buffer()
end

-- Outline viewer setup
require("symbols-outline").setup{
  relative_width = false,
  width = 80,
  auto_close = true,
  symbols = {
    File = { icon = "", hl = "@text.uri" },
    Module = { icon = "", hl = "@namespace" },
    Namespace = { icon = "", hl = "@namespace" },
    Package = { icon = "", hl = "@namespace" },
    Class = { icon = "𝓒", hl = "@type" },
    Method = { icon = "ƒ", hl = "Function" },
    Property = { icon = "", hl = "@method" },
    Field = { icon = "", hl = "@field" },
    Constructor = { icon = "", hl = "@constructor" },
    Enum = { icon = "ℰ", hl = "@type" },
    Interface = { icon = "ﰮ", hl = "@type" },
    Function = { icon = "", hl = "Function" },
    Variable = { icon = "", hl = "@constant" },
    Constant = { icon = "", hl = "@constant" },
    String = { icon = "𝓐", hl = "@string" },
    Number = { icon = "#", hl = "@number" },
    Boolean = { icon = "⊨", hl = "@boolean" },
    Array = { icon = "", hl = "@constant" },
    Object = { icon = "⦿", hl = "@type" },
    Key = { icon = "🔐", hl = "@type" },
    Null = { icon = "NULL", hl = "@type" },
    EnumMember = { icon = "", hl = "@field" },
    Struct = { icon = "𝓢", hl = "@type" },
    Event = { icon = "🗲", hl = "@type" },
    Operator = { icon = "+", hl = "@operator" },
    TypeParameter = { icon = "𝙏", hl = "@parameter" },
    Component = { icon = "", hl = "@function" },
    Fragment = { icon = "", hl = "@constant" },
  },
}

-- Status line setup
require('lualine').setup()
require("bufferline").setup{
  options = {
    diagnostics = "nvim_lsp",
    show_buffer_icons = true,
    color_icons = true,
    separator_style = "thick", 
    show_buffer_close_icons = false,
    diagnostics_indicator = function(count, level)
        local icon = level:match("error") and " " or ""
        return " " .. icon .. count
    end
}}

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


-- Syntax parser
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all" (the five listed parsers should always be installed)
  ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "cpp", "python", "markdown" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (or "all")
  ignore_install = { "javascript" },

  highlight = {
    enable = true,
    disable = {},
    -- Don't highlight for huge files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

require'nvim-treesitter.configs'.setup {
  incremental_selection = {
    enable = true,
    keymaps = {
            init_selection = '<C-Up>',
            scope_incremental = '<C-Right>',
            node_incremental = '<C-Up>',
            node_decremental = '<C-Down>',
    },
  },
}

require('telescope').setup{
    defaults = {
      sorting_strategy = "ascending",
      layout_strategy = 'vertical',
      layout_config = { 
        anchor = 'top',
        height = 0.8,
        width = 0.8,
        mirror = false,
        prompt_position = 'top',

    },
    },
  }

require("smartcolumn").setup()
require"gitlinker".setup({
  callbacks = {
        ["github.com"] = require"gitlinker.hosts".get_github_type_url,
        ["git.zooxlabs.com"] = require"gitlinker.hosts".get_github_type_url,
  },
  mappings = "<leader>Gl",
}
)

require("scrollbar").setup({
      handlers = {
        cursor = true,
        diagnostic = true,
        gitsigns = true, -- Requires gitsigns
        handle = true,
        search = false, -- Requires hlslens
        ale = false, -- Requires ALE
    },
})
require('gitsigns').setup()

require("luasnip.loaders.from_vscode").lazy_load()
