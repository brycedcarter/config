" This is where we keep our list of plugins that we use. This file should be
" sourced from the main vimrc file
" We keep the plugin stuff over here so that we can reload just the plugin
" information without needing to fully resource the vimrc. This is helpful when
" we have added new configs that require have the new plugins installed before
" they can be configured.. In this case, the pattern is:
"       - Source this plugins.vim file
"       - Run :PlugInstall to ensure all required plugins are installed
"       - Source the full vimrc to load the new configs

let data_dir = g:nvim ? stdpath('data') . '/site' : '~/.vim'
" Auto install vim-plug plugin manager
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()
Plug 'editorconfig/editorconfig-vim' " Integration with editorconfig files
Plug 'vim-scripts/indentpython.vim' " better auto indenting for python
Plug 'mbbill/undotree' " better undo interface
Plug 'tpope/vim-obsession' " Intelligent and automatic session management
Plug 'tpope/vim-fugitive' " Git extension
Plug 'psf/black' " Black formatter for python
Plug 'rhysd/vim-clang-format' " clang-format formatter for C style 
Plug 'kkoomen/vim-doge' " documentation generator
Plug('chrisbra/Colorizer') " highlight color codes
Plug('rickhowe/diffchar.vim') " improved diffing that allows showing multiple diffs on the same line

if nvim " neovim only plugins
  Plug 'numToStr/Comment.nvim' " Commenting improvements
  Plug 'neovim/nvim-lspconfig' " language server protocol client std configs
  Plug 'p00f/clangd_extensions.nvim'
  Plug 'hrsh7th/nvim-cmp' " autocompletion for use with nvim lsp
  " Completion sources for nvim-cmp
  Plug('hrsh7th/cmp-nvim-lsp')
  Plug('hrsh7th/cmp-buffer')
  Plug('hrsh7th/cmp-path')
  Plug('hrsh7th/cmp-cmdline')
  " snippet tool used by nvim-cmp
  Plug('saadparwaiz1/cmp_luasnip')
  Plug('L3MON4D3/LuaSnip')
  Plug 'rafamadriz/friendly-snippets' " snippet collection

  Plug('onsails/lspkind.nvim') " LSP completion icons

  Plug 'nvim-lualine/lualine.nvim'
  Plug 'akinsho/bufferline.nvim'
  Plug 'nvim-tree/nvim-web-devicons' " icons for bufferline
  Plug 'simrat39/symbols-outline.nvim' " Outline viewer
  Plug 'stevearc/aerial.nvim' " Outline viewer
  
  Plug 'kevinhwang91/nvim-bqf' " Better quick fix window
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " syntax tree gen. Needs the update to keep the update the parsers

  Plug 'nvim-lua/plenary.nvim' " Dep for telscope
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.4' } " Fuzzy finder window
  Plug 'm4xshen/smartcolumn.nvim' " Selectively enable 80 char line
  Plug 'ruifm/gitlinker.nvim' " Github link gen
  Plug 'petertriho/nvim-scrollbar' " Scrollbar 
  Plug 'lewis6991/gitsigns.nvim' " show git status in gutter
  Plug 'nvim-telescope/telescope-file-browser.nvim' " File browser
  Plug 'benfowler/telescope-luasnip.nvim' " Snippet browser for telescope
  Plug 'ziontee113/SnippetGenie' " Snippet generation tool to work in consort with luasnip
  Plug 'williamboman/mason.nvim' " Tool for managing things like external LSP tools
  Plug 'williamboman/mason-lspconfig.nvim' " Compatability plugin for lspconfg and mason
  Plug 'WhoIsSethDaniel/mason-tool-installer.nvim' " Tool to provide and easy way to install all of the mason tools
  Plug 'mhartington/formatter.nvim' " formatter tools, pairs with mason for actually installing the formatters
  Plug 'mfussenegger/nvim-lint' " Linter manager that integrates its output into the nvim LSP diagnostics
else
  Plug 'lifepillar/vim-mucomplete' " sets up completion sources (native)
endif
call plug#end()            " required

" Brief help    
" :PlugStatus          - list configured plugins  
" :PlugInstall    - install plugins     
" :PlugClean(!)- confirm (or auto-approve) removal of unused plugins
    "
