"######################################################################################
"################ MANAGED FILE ########################################################
"######################################################################################
"# This file should not be edited except in its original location of ~/config/vimrc
"######################################################################################

" BRYCE'S USAGE NOTES
" <leader> = <space>
"
" Leader strategy is as follows:
"   Actions are grouped together into roughly similar ideas. Each group is
"   associated with a letter or key. For each group, there is a 'prime' action 
"   that will be triggered simply with <leader> followed by the group's letter
"   in lower case. The rest of the group's actions will be accessible using
"   <leader> followed by the group's letter in UPPER case, followed by another
"   descriptive letter.
"   Finally, some groups may contain a subprime action, this will be accecced
"   with <leader> followed by Ctrl + <groups letter>


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
Plugin 'Valloric/YouCompleteMe' " Autocompletion
Plugin 'editorconfig/editorconfig-vim' " Integration with editorconfig files
Plugin 'tmhedberg/SimpylFold' " Code folding for python
Plugin 'vim-scripts/indentpython.vim' " better auto indenting for python
Plugin 'vim-syntastic/syntastic' " Syntax checking 
Plugin 'nvie/vim-flake8' " syntax checking tool for python
Plugin 'preservim/nerdtree' " File browsing
Plugin 'Xuyuanp/nerdtree-git-plugin' " git integration with nerd tree
Plugin 'mbbill/undotree' " better undo interface
Plugin 'kamykn/spelunker.vim' " spellcheck and correction suggestions
Plugin 'universal-ctags/ctags'
Plugin 'majutsushi/tagbar' " outline sidbar
Plugin 'airblade/vim-gitgutter' " show git status in gutter
Plugin 'voldikss/vim-floaterm' " popup terminal
Plugin 'junegunn/fzf' " fuzyy finding navigation
Plugin 'junegunn/fzf.vim'
Plugin 'octol/vim-cpp-enhanced-highlight' " better highlighting for c++
Plugin 'tpope/vim-obsession' " Intelligent and automatic session management
Plugin 'vim-airline/vim-airline' " Better status line
Plugin 'vim-airline/vim-airline-themes' " Color theme support for airline
Plugin 'tpope/vim-fugitive' " Git extension
Plugin 'psf/black' " Black formatter
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
syntax enable " enable syntax highlighting
colorscheme brycedcarter " use custom color scheme

set backspace=2 " allow backspace to go over eol, indent, and start of insert
set clipboard=unnamedplus " allows yank to go dirrectly to the linux system CLIPBOARD (xclip -selection c -o) which is the one that is synced over XQuarts. using unnamed sends yank to the PRIMARY clipboard that is not synced
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
set relativenumber " use relative numbers in line numbering
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
set grepprg=rg\ -n\ --column\ --no-heading  " use rg for grepping
set grepformat=%f:%l:%c:%m " set grep format to match grep config  


" Native Package Add
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
packadd termdebug

" Plugin Config 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" disable automatic keybindings for all plugins (except spellunker because it does not support it) 
let g:gitgutter_map_keys = 0 " remove git gutter key mappings
let g:NERDCreateDefaultMappings = 0 "remove nerd tree key mappings

" Airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set noshowmode  " Don't show current editor mode (insert, visual, replace, etc). that is airline's job now
let g:airline#extensions#tabline#enabled = 1 " display the enhanced tab bar that shows buffers 
let g:airline#extensions#tabline#left_alt_sep = '|' " customize tabline visual
let g:airline#extensions#tabline#left_sep = ' '
let g:airline_theme='deus'
let g:airline_powerline_fonts = 1
let g:airline_extensions = ['tabline'] " opt in to extensions rather than auto enabled

" CppEnhancedHighlight
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:cpp_class_scope_highlight=1
let g:cpp_experimental_template_highlight=1 " not using g:cpp_experimental_simple_template_highlight because it can be super slow
let g:cpp_concepts_highlight=1

" Spelunker setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nospell " use Spelunker instead of builtin speckcheck
set spellfile=~/.spellfile.utf-8.add
let g:spelunker_check_type = 1
highlight SpelunkerSpellBad cterm=underline ctermfg=NONE gui=underline guifg=NONE
highlight SpelunkerComplexOrCompoundWord cterm=underline ctermfg=NONE gui=underline guifg=NONE

" Syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
try
  let g:flake8_work_file_ignores=join(readfile(expand("~/.config-work/flake8-ignores.txt")))
catch /.*/
endtry
let g:syntastic_check_on_open=1 " Check for syntax errors on file open.
let g:syntastic_echo_current_error=1 " Echo errors to the command window.
let g:syntastic_enable_signs=1 " Mark lines with errors and warnings.
let g:syntastic_enable_balloons=0 " Do not open error balloons over erroneous lines.
let g:syntastic_cpp_check_header=1 " YCM will provide context for C++ files.
let g:syntastic_c_check_header=1 " Same for C files.
let g:syntastic_python_checkers = ['flake8'] " use flake8 as the python syntax checker
let g:syntastic_python_flake8_args = printf('--per-file-ignores="__init__.py:F401 %s"',g:flake8_work_file_ignores)
" ycm is used for C family language checking (controlled by extra_conf files)

" YouCompleteMe ycm
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_log_level = 'debug'
let g:ycm_server_log_level = 'debug'
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_max_num_identifier_candidates = 0
let g:ycm_min_num_identifier_candidate_chars = 3
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '!'
let g:ycm_max_num_candidates = 6


" NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" add back default mapping
let NERDTreeIgnore=['\.pyc$', '\~$']

" tagbar customization
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tagbar_autoclose=1 " close the tagbar after jumping to a tag
let g:tagbar_autofocus=1 " jump to the tag bar when it is opened
let g:tagbar_show_data_type = 1 " show the tag type to its right
let g:no_status_line = 1 " don't display the status line
let g:tagbar_sort = 0 " sort by document order rather than name (outline)
let g:tagbar_map_close = "<leader>o" " use same mapping to open and close

" SimpyFold
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SimpylFold_docstring_preview=1


" Black Formatter
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:black_linelength = 80 

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

" Custom functions and routines
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" For files with logical pairs such as .cpp and .h files, check if the pair
" exists and if so, open it
function ToggleIfPair()
  let l:filePairs = [["cpp", "h"], ["cc", "h"], ["c", "h"]]
  let l:currentExtension = expand("%:e")
  for pair in g:filePairs
    for idx in [0, 1]
      if pair[idx] == l:currentExtension
        let l:matchingExtension = pair[(idx + 1)%2]
        let l:matchingFilename = expand("%:p:r") . "." . l:matchingExtension
        if filereadable(l:matchingFilename)
          execute "edit " . l:matchingFilename
          return
        else
          echo "Matching file: '" . l:matchingFilename . "' does not exist"
        endif 
      endif
  endfor
endfor
endfunction

" Converts a list that has been copied from OneNote into a valid markdown
" This is required because anything more than the basic indentation does not 
" copy to makrdown correctly. 
" The list indentation is represented with tab indents rather than *s
function! ListToMarkdown()
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

" Auto Commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Populate a header for python files
augroup headers
  au BufNewFile *.py so ~/config/headers/python.txt
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

" Ctrl
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 

" better pane navigation and creation 
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" NERDTree directory browser
nnoremap <C-n> :NERDTreeToggle<CR>

" F-Key mapping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 

" Reload vimrc
nnoremap <F1> :so $MYVIMRC<cr>

" Back formatter
nnoremap <F4> :Black<CR>

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
nnoremap <leader>= :call ToggleIfPair()<cr>

" LEADER groups
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""" 
" See leader strategy above

" --- U --- Undo
"  prime = pending
"  subprime = UNDEFINED

" --- D --- Debug/Diagnose
"  prime = UNDEFINED
"  subprime = Start gdb terminal debugger
"  D->b = insert breakpoint at current line
"  D->c = clear breakpoint at current line
nnoremap <leader><C-D> :Termdebug<cr>
nnoremap <leader>Db :Break<cr>
nnoremap <leader>Dc :Clear<cr>

" --- F --- Find
"  prime = start case insensitive regex find 
"  F->l = use fzf to find lines in open buffers
"  F->g = use fzf to perform a ripgrep recursive search of files
nnoremap <leader>f /\v\c
nnoremap <leader>Fl :Lines<cr>
nnoremap <leader>Fg :Rg<cr>

" --- G --- Git
"  prime = Open fugitive
nnoremap <leader>g  :Git<CR>

" --- J --- Jump
"  prime = Open buffer jump dialog
"  subprime = Jump to definition/declaration using YCM
nnoremap <leader>j :Buffers<cr>
nnoremap <leader><C-J> :YcmCompleter GoTo<CR>

" --- L --- Load
"  prime = use fzf to look for files to load
nnoremap <leader>l :Files<cr>

" --- Q --- Quit
"  prime = quit
"  subprime = force quit
nnoremap <leader>q :q<cr>
nnoremap <leader><C-Q> :q!<cr>

" --- R --- Replace/Repair/Refactor
"  prime = start find and replace
"  subprime = start find and rjplace
"  R->f = perform YCM fixit operation
"  R->g =  perform grep based refactor
nnoremap <leader>r viw"ry<cr>:%snomagic/<c-r>r//gc<Left><Left><Left>a<bs>
vnoremap <leader>r "ry<cr>:%snomagic/<c-r>r//gc<Left><Left><Left>a<bs>
nnoremap <leader>Rf  :YcmCompleter FixIt<CR>
nnoremap <leader>Rg viw"ry/<C-r>r<cr>:exe "Grep " . shellescape(fnameescape(getreg("r")))<cr>
vnoremap <leader>Rg "ry/<C-r>r<cr>:exe "Grep " . shellescape(fnameescape(getreg("r")))<cr>

" --- S --- Split
"  prime = split vertically
"  subprime = split horizontally
nnoremap <leader>s :vsplit<cr>
nnoremap <leader><C-S> :split<cr>

" --- O --- Outline/Overview
"  prime = open outline
nnoremap <silent> <leader>o :TagbarToggle<cr>

" --- U --- Undo
"  prime = open undo tree
nnoremap <leader>u :UndotreeToggle<cr>

" --- V --- Visualize (Display related actions)
"  prime = UNDEFINED
"  subprime = UNDEFINED
"  V->n = toggle line numbers display
"  V->c = use fzf to search for a color profile to load
nnoremap <leader>Vn :set relativenumber!<cr>:set number!<cr>
nnoremap <leader>vc :Color<cr>

" --- W --- Write
"  prime = write current buffer
nnoremap <leader>w :w<cr>

" load a work specific vimrc if applicable
call SourceIfExists("~/.config-work/vimrc")
