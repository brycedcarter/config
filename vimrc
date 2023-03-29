"######################################################################################
"################ MANAGED FILE ########################################################
"######################################################################################
"# This file should not be edited except in its original location of ~/config/vimrc
"######################################################################################

" BRYCE'S USAGE NOTES
" <leader> = <space>
"
" Leader strategy is as follows:
"   Actions are grouped together into roughly similar ideas ((D)ebug, (J)ump, 
"   (L)oad, etc...). Each group is associated with a letter or key. 
"   For each group, there is a 'prime' action 
"   that will be triggered simply with <leader> followed by the group's letter
"   in lower case. The rest of the group's actions will be accessible using
"   <leader> followed by the group's letter in UPPER case, followed by another
"   descriptive letter.
"   Finally, some groups may contain a subprime action, this will be accessed
"   with <leader> followed by Ctrl + <groups letter>

if has('nvim')
  let g:nvim = 1
else 
  let g:nvim = 0
endif

" Plugins 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim' " Plugin manger
Plugin 'scrooloose/nerdcommenter' " Quickly add and remove comments 
Plugin 'editorconfig/editorconfig-vim' " Integration with editorconfig files
Plugin 'tmhedberg/SimpylFold' " Code folding for python
Plugin 'vim-scripts/indentpython.vim' " better auto indenting for python
Plugin 'mbbill/undotree' " better undo interface
Plugin 'universal-ctags/ctags' " ctags implementation required by tagbar
Plugin 'majutsushi/tagbar' " outline sidebar
Plugin 'airblade/vim-gitgutter' " show git status in gutter
Plugin 'junegunn/fzf' " fuzyy finding navigation
Plugin 'junegunn/fzf.vim'
Plugin 'octol/vim-cpp-enhanced-highlight' " better highlighting for c++
Plugin 'tpope/vim-obsession' " Intelligent and automatic session management
Plugin 'tpope/vim-fugitive' " Git extension
Plugin 'psf/black' " Black formatter for python
Plugin 'rhysd/vim-clang-format' " clang-format formatter for C style 
Plugin 'stsewd/fzf-checkout.vim' " fzf git actions
Plugin 'kkoomen/vim-doge' " documentation generator
Plugin('chrisbra/Colorizer') " highlight color codes

if nvim " neovim only plugins
  Plugin 'neovim/nvim-lspconfig' " language server protocol client std configs
  Plugin 'p00f/clangd_extensions.nvim'
  Plugin 'hrsh7th/nvim-cmp' " autocompletion for use with nvim lsp
  " Completion sources for nvim-cmp
  Plugin('hrsh7th/cmp-nvim-lsp')
  Plugin('hrsh7th/cmp-buffer')
  Plugin('hrsh7th/cmp-path')
  Plugin('hrsh7th/cmp-cmdline')
  " snippet tool used by nvim-cmp
  Plugin('saadparwaiz1/cmp_luasnip')
  Plugin('L3MON4D3/LuaSnip')

  Plugin('onsails/lspkind.nvim') " LSP completion icons

  Plugin 'nvim-lualine/lualine.nvim'
  Plugin 'akinsho/bufferline.nvim'
  Plugin 'nvim-tree/nvim-web-devicons' " icons for bufferline
  Plugin 'nvim-tree/nvim-tree.lua'
else
  Plugin 'lifepillar/vim-mucomplete' " sets up completion sources (native)
endif
call vundle#end()            " required
filetype plugin indent on    " required
"to ignore plugin indent changes, instead use:
"filetype plugin on

    " Brief help    
    " :PluginList          - list configured plugins  
    " :PluginInstall(!)    - install (update) plugins     
    " :PluginSearch(!) foo - search (or refresh cache first) for foo    
    " :PluginClean(!)- confirm (or auto-approve) removal of unused plugins
    "
"see :h vundle for more details or wiki for faq
"put your non-plugin stuff after this line


" Basic config settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set runtimepath+=~/config/vim/

syntax enable " enable syntax highlighting
set termguicolors " use specific hex colors

let g:tmp_dir = "~/config/.tmp/"
let s:current_scheme_file = g:tmp_dir . "vim_current_scheme"
if filereadable(expand(s:current_scheme_file))
  execute "colorscheme " . readfile(expand(s:current_scheme_file))[0]
  call mkdir(expand(g:tmp_dir), "p")
else
  colorscheme brycedcarter-cool-dark " use custom color scheme
endif

set backspace=2 " allow backspace to go over eol, indent, and start of insert
set clipboard=unnamedplus " allows yank to go directly to the linux system CLIPBOARD (xclip -selection c -o) which is the one that is synced over XQuarts. using unnamed sends yank to the PRIMARY clipboard that is not synced
set colorcolumn=80 " show the 80th column as a guide
set cursorline " Highlight the line with the cursor
set encoding=utf-8 " use utf-8 encoding
set expandtab                   " Expand tabs into spaces. use CTLR+V->Tab for a real tab
set foldlevelstart=99 " start with no folding
set foldmethod=syntax " use syntax elements to define folding boundaries
set hidden " allow hiding modified buffers without saving
set history=1000 " remember lots of commands
set hlsearch " highlight search results
set incsearch " show search results while typing
set laststatus=2 " always show the status bar for all windows
set list " show visual whitespace 
set listchars=tab:➤-,trail:·,extends:»,precedes:« " chars to show in place of whitespace
set lazyredraw                  " Redraw faster.
set number " show line numbers
set scrolloff=5                 " Keep min of N lines above/below cursor.
set shiftwidth=2                " Auto-indent 2 spaces each indent level. (used for C style files)
set showmatch                   " Show matching () {} etc..
set smarttab                    " Tabs and backspaces at the start of a line indent the line one level.
set sidescrolloff=10            " Keep min of N columns right/left cursor.
set smartindent                 " Maintains most indentation and adds extra level when nesting.
set splitright splitbelow       " Open splits below and to the right.
set synmaxcol=2000              " Only matches syntax on first N columns of each line.
set textwidth=80                " Hard wrap at N characters.
set timeout timeoutlen=1500 " wait 1.5s before canceling a partial command
set ttyfast                     " Smoother redrawing.
set undolevels=1000 " keep lots of undo
set viminfo='100,<500,%,h         " Adjust viminfo contents.
set virtualedit=block           " Allow the cursor to move to columns without text in block select mode
set wildignore=*.pyc      " Ignore generated files in the source tree.
set wildignorecase              " Tab completion is case-insensitive.
set wildmenu                    " Tab completion navigable menu is enabled.
set wildmode=list:longest,full  " Tab completion lists matches, then opens wildmenu on next <Tab>.
set formatoptions=cqronl " custom formatting
set diffopt+=internal,algorithm:patience " enable better 'patience' diff
set grepprg=rg\ --vimgrep\ --no-messages  " use rg for grepping
set grepformat=%f:%l:%c:%m " set grep format to match grep config  
set spell " enable spellcheck
set spellfile=~/.spellfile.utf-8.add " personal spelling dictionary
set spellsuggest=10 " limit the number of spelling suggestions

" Native Package Add
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
packadd termdebug

" Plugin Config 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" disable automatic keybindings for all plugins (except spellunker because it does not support it) 
let g:gitgutter_map_keys = 0 " remove git gutter key mappings


" CppEnhancedHighlight
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:cpp_class_scope_highlight=1
let g:cpp_experimental_template_highlight=1 " not using g:cpp_experimental_simple_template_highlight because it can be super slow
let g:cpp_concepts_highlight=1

" General completion
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set completeopt=menu,menuone,noselect

if !nvim
  " MUcomplete basic completion
  """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
  let g:mucomplete#enable_auto_at_startup = 1
  let g:mucomplete#chains = {'default' : ['path', 'keyn', 'omni']}
endif


" tagbar customization
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tagbar_autoclose=1 " close the tagbar after jumping to a tag
let g:tagbar_autofocus=1 " jump to the tag bar when it is opened
let g:tagbar_show_data_type = 1 " show the tag type to its right
let g:no_status_line = 1 " don't display the status line
let g:tagbar_sort = 0 " sort by docu:ment order rather than name (outline)
let g:tagbar_map_close = "<leader>o" " use same mapping to open and close

" SimpyFold
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SimpylFold_docstring_preview=1


" Black Formatter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:black_linelength = 80 

" calng-format Formatter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:clang_format#command = 'clang-format-3.6'

" floatterm setup
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:floaterm_width = 0.9
let g:floaterm_height = 0.9
let g:floaterm_autoclose = 2

" Workarounds
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if $VIM_CRONTAB == "true"
set backupcopy=yes
endif

hi debugPC term=reverse ctermbg=52 guibg=DarkRed

if &term =~ '256color'
      " COMES FROM" https://superuser.com/questions/457911/in-vim-background-color-changes-on-scrolling/588243
      " Disable Background Color Erase (BCE) so that color schemes
      "     " work properly when Vim is used inside tmux and GNU screen.
      set t_ut=
endif

" Fixing up the grep command so that it can be used by our custom refactor
command! -nargs=+ Grep silent! :grep  <args> | redraw! | copen

set eventignore-=Syntax

" Custom functions and routines
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" For files with logical pairs such as .cpp and .h files, check if the pair
" exists and if so, open/show it
function ToggleIfPair()
  " This list is ordered... the first entry for which there is a matching pair
  " will be the one that is opened
  let file_pairs = [["cpp", "h"], ["cc", "h"], ["c", "h"]]
  let current_extension = expand("%:e")
  for pair in file_pairs
    for idx in [0, 1]
      if pair[idx] == current_extension
        let matching_extension = pair[(idx + 1)%2]
        let matching_filename = expand("%:p:r") . "." . matching_extension
        if filereadable(matching_filename)
          execute "edit " . matching_filename
          return
        endif 
      endif
    endfor
  endfor
  echo "No paired file found :-("
endfunction

" Converts a list that has been copied from OneNote into a valid markdown
" This is required because anything more than the basic indentation does not 
" copy to makrdown correctly. 
" The list indentation is represented with tab indents rather than *s
function ListToMarkdown()
  %sno/\v^\s[-○§] (\S)/* \1/eg
  %sno/\v^\s\s[-○§] (\S)/** \1/eg
  %sno/\v^\s\s\s[-○§] (\S)/*** \1/eg
  %sno/\v^\s\s\s\s[-○§] (\S)/**** \1/eg
endfunction
nnoremap <leader>@l :silent call ListToMarkdown()<cr>

" Function to source only if file exists --- from here 
" https://devel.tech/snippets/n/vIIMz8vZ/load-vim-source-files-only-if-they-exist
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

" quickfix bindings modified from: https://vonheikemen.github.io/devlog/tools/vim-and-the-quickfix-list/
function! QuickfixMapping()
  " Go to the previous location and stay in the quickfix window
  nnoremap <buffer> K :cprev<CR>zz<C-w>w
  " Go to the next location and stay in the quickfix window
  nnoremap <buffer> J :cnext<CR>zz<C-w>w
  " Make the quickfix list modifiable
  nnoremap <buffer> <leader>u :set modifiable<CR>
  " Save the changes in the quickfix window
  nnoremap <buffer> <leader>w :cgetbuffer<CR>:cclose<CR>:copen<CR>
  " Begin the search and replace
  nnoremap <buffer> <leader>r :cdo s///g \| update<C-Left><C-Left><Left><Left><Left><Left>
  " Begin search and replace with result from previous leader-R in main window
  nnoremap <buffer> <leader>R :cdo s/<C-R>r//g \| update<C-Left><C-Left><Left><Left><Left>
endfunction

" A wrapper function that selects the correct auto-formatter based on the
" current file type
function! FormatBuffer()
  let l:currentExtension = expand("%:e")
  if &filetype ==# 'c' || &filetype ==# 'cpp' || &filetype ==# 'proto'
    execute 'ClangFormat'
  elseif &filetype ==# 'python' 
    execute 'Black'
  else 
    echo "No formatter for filetype: " . &filetype
  endif
endfunction

" Helper to fill the arglist with all files in the current directory of a
" certain type. The main reason for this function is to prevent opening a buffer
" call *.xx when there are no files with the extension of xx in the current
" directory
function! ExpandFilePatterns(patterns)
  " first we clear out any existing entries in the arglist
  silent! argdel *
  for pattern in a:patterns
    " expand the pattern here
    silent! execute 'argadd ' . pattern
    " don't expand here, so we can remove *.xx if it was not expanded before
    silent! execute 'argdel \' . pattern 
  endfor
endfunction

" This is a wrapper around a lua call. It will first check that it is being run
" in Nvim, and then proceed to make the lua call provided by "lua_call"
function! LuaCall(lua_call) 
  if g:nvim
      silent execute "lua " .. a:lua_call
  else
    echohl WarningMsg | echo "This key mapping is only valid in nvim" | echohl None
  endif
endfunction

" Display syntax group 
function! SynGroup()
    let l:s = synID(line('.'), col('.'), 1)
    echo synIDattr(l:s, 'name') . ' -> ' . synIDattr(synIDtrans(l:s), 'name')
endfun

" Auto Commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Populate a template for python files
augroup templates
  au BufNewFile *.py so ~/config/templates/python.txt
  au bufnewfile *.py exe "1," . 7 . "g/Filename:.*/s//Filename: " .expand("%")
  au bufnewfile *.py exe "1," . 7 . "g/Date Created:.*/s//Date Created: " .strftime("%Y-%m-%d")
  au bufnewfile *.py exe "normal! /\\V[Description]\<cr>vf]"
augroup END


" Resize splits on window resize.
augroup AutoResizeSplits
   autocmd!
   autocmd VimResized * exe "normal! \<c-w>="
augroup END

" install special bindings for the quickfix window
augroup quickfix_group
    autocmd!
    autocmd filetype qf call QuickfixMapping()
augroup END

" Refresh teh xserver connection so that clipboard work in tmux
augroup xserver_referesh
  autocmd!
  " taking out for now becuase of delay
  "autocmd FocusGained * xrestore
augroup END

" Record the current color scheme so that it can be loaded on the next open
augroup remember_colorscheme
  autocmd!
  call system('touch ' . s:current_scheme_file)
  autocmd ColorScheme * call writefile([ g:colors_name,], expand(s:current_scheme_file))
augroup END

" Command Mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 

" easier exit from insert mode
inoremap jk <esc>

" Auto closing of closures
inoremap (( ()<esc>i
inoremap [[ []<esc>i
inoremap {{ {}<esc>i
inoremap "" ""<esc>i
inoremap '' ''<esc>i
inoremap `` ``<esc>i

" highlight clear
nnoremap <silent> <leader><cr> :noh<cr>

" movement for use in quickfix mode
nnoremap [q :cprev<CR>
nnoremap ]q :cnext<CR>

" improved spellcheck correction options view
nnoremap z= i<C-X>s

" Ctrl
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 

" better pane navigation and creation 
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" F-Key mapping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 

" Reload vimrc
nnoremap <F1> :so $MYVIMRC<cr>

" Back formatter
nnoremap <F4> :call FormatBuffer()<CR>

" YouCompleteMe
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>

" floatterm keys
nnoremap   <silent>   <F12>   :FloatermToggle<CR>
tnoremap   <silent>   <F12>   <C-\><C-n>:FloatermToggle<CR>

" LEADER raw
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 

" set the leader
let mapleader=" "

" Comment toggling
nnoremap <leader>/ :call nerdcommenter#Comment('n', 'toggle')<CR>
vnoremap <leader>/ :call nerdcommenter#Comment('x', 'toggle')<CR>

" paren/wrapping tools
vnoremap <leader>( <esc>`>a)<esc>`<i(<esc>
vnoremap <leader>[ <esc>`>a]<esc>`<i[<esc>
vnoremap <leader>{ <esc>`>a}<esc>`<i{<esc>
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>
vnoremap <leader>' <esc>`>a'<esc>`<i'<esc>
vnoremap <leader>` <esc>`>a`<esc>`<i`<esc>

" quick toggle previous buffer
nnoremap <leader><tab> :b#<cr>
" quick cycle through buffers
nnoremap <tab> :bn<cr>
nnoremap <S-tab> :bp<cr>

" Swapping between pairs of logically connected files
nnoremap <silent> <leader>= :call ToggleIfPair()<cr>

" LEADER groups
"""""""""""""""""""""""""""""""""""""""""""""""""""""
" See leader strategy above

" --- D --- Debug/Diagnose
"  prime = UNDEFINED
"  subprime = Start gdb terminal debugger
"  D->b = insert breakpoint at current line
"  D->c = clear breakpoint at current line
"  D->h = show highlighting info at the current location
"       FROM: https://stackoverflow.com/questions/29029050/vim-highlighting-is-there-a-way-to-find-out-what-is-applied-at-a-particular-po
"  D->H = show detailed highlighting ifromation in a new window
"  D->n = Jump to the next diagnostic
"  D->N = Jump to the previous diagnostic
"  D->p = Jump to the previous
"  D->m = start profiling of all functions. NOTE: need to exit vim before
"  results will be written to /tmp/vim.profile
nnoremap <leader><C-D> :Termdebug<cr>
nnoremap <leader>Db :Break<cr>
nnoremap <leader>Dc :Clear<cr>
nnoremap <silent> <leader>Dh :call SynGroup()<cr>
nnoremap <silent> <leader>DH :so $VIMRUNTIME/syntax/hitest.vim<cr>
nnoremap <silent> <leader>Dn :call LuaCall("vim.diagnostic.goto_next()")<CR>
nnoremap <silent> <leader>DN :call LuaCall("vim.diagnostic.goto_prev()")<CR>
nnoremap <leader>Dm :profile start /tmp/vim.profile<cr>:profile file *<cr>:profile func *<cr>

" --- F --- Find
"  prime = start case insensitive regex find 
"  F->l = use fzf to find lines in open buffers
"  F->g = use fzf to perform a ripgrep recursive search of files
"  F->r = find references using language server
"  F->t = open the tree sidebar
nnoremap <leader>f /\v\c
nnoremap <leader>Fl :Lines<cr>
nnoremap <leader>Fg :Rg<cr>
nnoremap <leader>Fr :call LuaCall("TryLsp('references')")<cr>
nnoremap <leader>Ft :call LuaCall('require("nvim-tree.api").tree.toggle()')<cr>

" --- G --- Git
"  prime = Open fugitive
"  G->p = initiate a git push
"  G->b = initiate a git blame
"  G->c = initiate a checkout for branches
"  G->t = initiate a checkout for tags
"  G->n = next git hunk
"  G->N = previous git hunk
"  G->v = view preview of hunk under the cursor
"  G->r = restore (discard) the changes in the hunk under the cursor
"  G->a = stage the changes in the hunk under the cursor
nnoremap <leader>g  :Git<CR>
nnoremap <leader>Gp  :G push<CR>
nnoremap <leader>Gb  :G blame<CR>
nnoremap <leader>Gc  :GBranches checkout<CR>
nnoremap <leader>Gt  :GTags checkout<CR>
nnoremap <leader>Gn  :GitGutterNextHunk<CR>
nnoremap <leader>GN  :GitGutterPrevHunk<CR>
nnoremap <leader>Gv  :GitGutterPreviewHunk<CR>
nnoremap <leader>Gr  :GitGutterUndoHunk<CR>
nnoremap <leader>Ga  :GitGutterStageHunk<CR>

" --- H --- Help
"  prime = LSP hover help
"  H->l = get info about current LSP state
nnoremap <leader>h  :call LuaCall("TryLsp('hover')")<CR>
nnoremap <leader>Hl  :LspInfo<CR>

" --- J --- Jump
"  prime = Open buffer jump dialog
"  subprime = Jump to definition using the language server
"  J->d = Jump to declaration using the language server
nnoremap <leader>j :Buffers<cr>
nnoremap <silent> <leader><C-J> :call LuaCall("TryLsp('declaration')")<CR>
nnoremap <silent> <leader>Jd :call LuaCall("TryLsp('definition')")<CR>

" --- L --- Load
"  prime = use fzf to look for files to load
"  L->h = load all headers in the current directory
"  L->p = load all .py in the current directory
"  L->c = load all .c/.cc/.cpp/.h/.hpp files in the current directory
nnoremap <leader>l :Files<cr>
" using "next" on joined list rather than argdo because argdo disables syntax
" autocmd for Syntax when it si running
nnoremap <leader>Lh :call ExpandFilePatterns(['*.h'])<cr>:silent exe 'next ' . join(argv(), ' ' )<cr>
nnoremap <leader>Lp :call ExpandFilePatterns(['*.py'])<cr>:silent exe 'next ' . join(argv(), ' ' )<cr>
nnoremap <leader>Lc :call ExpandFilePatterns(['*.c', '*.cc', '*.cpp', '*.h', '*.hpp'])<cr>:silent exe 'next ' . join(argv(), ' ' )<cr>

" --- O --- Outline/Overview
"  prime = open outline
"  subprime = open the folder that contains the current document
nnoremap <silent> <leader>o :TagbarToggle<cr>
nnoremap <silent> <leader><C-O> :Explore<cr>

" --- Q --- Quit
"  prime = quit
"  subprime = force quit
"  Q->b = drop the current buffer
"  G->a = drop all buffers
nnoremap <leader>q :q<cr>
nnoremap <leader><C-Q> :q!<cr>
nnoremap <leader>Qb :bd<cr>
nnoremap <leader>Qa :silent bufdo bd<cr>

" --- R --- Replace/Repair/Refactor
"  prime = start find and replace
"  prime-visual = start find and replace bounded by visual selection
"  R->d = perform DoGe document generation
"  R->f = perform LSP fixit operation
"  R->g =  perform grep based refactor
"  R->s = perfom a sort on the selected lines
nnoremap <leader>r viw"ry<cr>:%snomagic/<c-r>r//gc<Left><Left><Left>a<bs>
vnoremap <leader>r :snomagic///gc<Left><Left><Left><Left>
nnoremap <leader>Rd  :DogeGenerate 1<CR>
nnoremap <leader>Rf  :call LuaCall("TryLsp('code_action')")<CR>
nnoremap <leader>Rg viw"ry/<C-r>r<cr>:exe "Grep " . shellescape(fnameescape(getreg("r")))<cr>
vnoremap <leader>Rg "ry/<C-r>r<cr>:exe "Grep " . shellescape(fnameescape(getreg("r")))<cr>
vnoremap <leader>Rs  :sort<CR>

" --- S --- Split
"  prime = split vertically
"  subprime = split horizontally
"  S->s = swap the current split with the one to its right
nnoremap <leader>s :vsplit<cr>
nnoremap <leader><C-S> :split<cr>
nnoremap <leader>Ss <C-W><C-X><cr>

" --- U --- Undo
"  prime = open undo tree
nnoremap <leader>u :UndotreeToggle<cr>

" --- V --- Visualize (Display related actions)
"  prime = UNDEFINED
"  subprime = UNDEFINED
"  V->n = toggle line numbers display
"  V->c = use fzf to search for a color profile to load
"  V->h = Toggle highlighting of color codes
"  V->g = Toggle git gutter display
nnoremap <leader>Vn :set number!<cr>
nnoremap <leader>Vc :Colors<cr>
nnoremap <leader>Vh :ColorToggle<cr>
nnoremap <leader>Vg :GitGutterToggle<cr>

" --- W --- Write
"  prime = write current buffer
nnoremap <leader>w :w<cr>

" load a work specific vimrc if applicable
call SourceIfExists("~/.config-work/vimrc")
" run lua init script if we are running neovim
if nvim
  source ~/config/vim/nvim/lua/init.lua
endif
