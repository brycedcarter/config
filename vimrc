"######################################################################################
"################ MANAGED FILE ########################################################
"######################################################################################
"# This file should not be edited except in its original location of ~/config/vimrc
"######################################################################################

" BRYCE'S USAGE NOTES
"
"
" <leader> = <space>
"
" exit edit mode: jk 
" toggle comment: <leader>ci
" toggle folding: <leader><space>
" get docs for function <leader>d
" go to definition for function <leader>g
" add marker: m[a-z0-9]
" remove all markers from line: m-
" list markers: m/ 
" toggle file tree view ctrl+n 
" just back to previous buffer <tab>
" open the outliner <leader>o



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
Plugin 'jeetsukumaran/vim-buffergator' " buffer listing panel
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
call vundle#end()            " required
filetype plugin indent on    " required
 "to ignore plugin indent changes, instead use:
"filetype plugin on

    " Brief help    
    " :PluginList          - list configured plugins  
    " :PluginInstall(!)    - install (update) plugins     
    " :PluginSearch(!) foo - search (or refresh cache first) for foo    
    " " :PluginClean(!)- confirm (or auto-approve) removal of unused pluginsk
    "
 "see :h vundle for more details or wiki for faq
 "put your non-plugin stuff after this line

set encoding=utf-8
set number
set showcmd
set hlsearch " highlight search results
set incsearch " show search results while typing
set backspace=2
inoremap jk <esc>
colorscheme brycedcarter
syntax enable
" set clipboard=unnamed
set clipboard=unnamedplus " allows yank to go dirrectly to the linux system CLIPBOARD (xclip -selection c -o) which is the one that is synced over XQuarts. using unnamed sends yank to the PRIMARY clipboard that is not synced
let mapleader=" "
set timeout timeoutlen=1500
set cursorline
set relativenumber
set laststatus=2
set history=1000 " remember lots of commands
set undolevels=1000 " keep lots of undo
set colorcolumn=80 " show the 80th column as a guide
set hidden " allow hiding modified buffers without saving
set smartcase " case insensitive search if search pattern is all lowercase
set list " show visual whitespace 
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" disable automatic keybindings for all plugins (except spellunker becuase it 
" does not support it) 
let g:gitgutter_map_keys = 0
let g:NERDCreateDefaultMappings = 0

" Airline
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='deus'
let g:airline_powerline_fonts = 1

" CppEnhancedHighlight
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:cpp_class_scope_highlight=1
let g:cpp_experimental_simple_template_highlight=1
let g:cpp_concepts_highlight=1

" spelunker setup
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nospell
set spellfile=~/.spellfile.utf-8.add
let g:spelunker_check_type = 1
highlight SpelunkerSpellBad cterm=underline ctermfg=NONE gui=underline guifg=NONE
highlight SpelunkerComplexOrCompoundWord cterm=underline ctermfg=NONE gui=underline guifg=NONE

" Syntastic
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Commands:
"     Errors               pop up location list and display errors
"     SyntasticToggleMode  toggles between active and passive mode
"     SyntasticCheck       forces a syntax check in passive mode
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:syntastic_check_on_open=1 " Check for syntax errors on file open.
let g:syntastic_echo_current_error=1 " Echo errors to the command window.
let g:syntastic_enable_signs=1 " Mark lines with errors and warnings.
let g:syntastic_enable_balloons=0 " Do not open error balloons over erroneous lines.
let g:syntastic_cpp_check_header=1 " YCM will provide context for C++ files.
let g:syntastic_c_check_header=1 " Same for C files.
let g:syntastic_python_checkers = ['flake8'] " use flake8 as the python syntax checker
let g:syntastic_python_flake8_args = '--per-file-ignores="__init__.py:F401"'

" ycm customization
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:ycm_autoclose_preview_window_after_completion=1
let g:ycm_collect_identifiers_from_tags_files=1
nnoremap <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>d  :YcmCompleter GetDoc<CR>
map <C-n> :NERDTreeToggle<CR>

" buffergator customization
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:buffergator_suppress_keymaps=1
nnoremap <leader>b :BuffergatorToggle<cr>

" tagbar customization
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tagbar_autoclose=1
let g:tagbar_autofocus=1
let g:tagbar_show_data_type = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_autopreview = 0
let g:no_status_line = 1
let g:tagbar_sort = 0
nnoremap <silent> <leader>o :TagbarToggle<cr>

if $VIM_CRONTAB == "true"
	set backupcopy=yes
endif

" enable code folding
set foldmethod=indent
set foldlevel=99
"  nnoremap <leader><space> za
let g:SimpylFold_docstring_preview=1


"ignore files in NERDTree
let NERDTreeIgnore=['\.pyc$', '\~$']

" better undo mapping
nnoremap <leader>u :UndotreeToggle<cr>

" floatterm setup
nnoremap   <silent>   <F12>   :FloatermToggle<CR>
tnoremap   <silent>   <F12>   <C-\><C-n>:FloatermToggle<CR>
let g:floaterm_width = 0.9
let g:floaterm_height = 0.9
let g:floaterm_autoclose = 2

" better pane navigation and creation 
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

nnoremap <leader>s :split<cr>
nnoremap <leader>vs :vsplit<cr>


" quick file writing
nnoremap <leader>w :w<cr>

" quick quit
nnoremap <leader>q :q<cr>


" add find and replace
vnoremap <silent> <leader>r :call VisualSelection('replace')<CR>

" paren/wrapping tools
vnoremap <leader>( <esc>`>a)<esc>`<i(<esc>
vnoremap <leader>[ <esc>`>a]<esc>`<i[<esc>
vnoremap <leader>{ <esc>`>a}<esc>`<i{<esc>
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>
vnoremap <leader>' <esc>`>a'<esc>`<i'<esc>
vnoremap <leader>` <esc>`>a`<esc>`<i`<esc>

inoremap (( ()<esc>i
inoremap [[ []<esc>i
inoremap {{ {}<esc>i
inoremap "" ""<esc>i
inoremap '' ''<esc>i
inoremap `` ``<esc>i

" highligh clear
nnoremap <silent> <leader><cr> :noh<cr>

" search 
nnoremap <leader>f /\v

" quick edit
nnoremap <leader>e :e<Space>

nnoremap <tab> :b#<cr>
" quick cycle through buffers
nnoremap <S-tab> :bn<cr>

" shortcut for adding docstring
nnoremap <leader>ds i"""<cr><cr>"""<esc>ki
" shortcut for adding a short docstring (on one line)
nnoremap <leader>sd i""""""<esc>hhi

" quick relace
nnoremap <leader>r :%sno/

" Quick open terminal
nnoremap <leader>t :terminal<cr>
tnoremap <C-t> exit<cr>

" reload vimrc
nnoremap <F1> :so $MYVIMRC<cr>

" fzf bindings
nnoremap <leader>H :History<cr>
nnoremap <leader>C :Color<cr>
nnoremap <leader>O :Files<cr>
nnoremap <leader>L :Lines<cr>
nnoremap <leader>T :Tags<cr>

" ===================== Auto commands ================
augroup headers
  au BufNewFile *.py so ~/config/headers/python.txt
  au bufnewfile *.py exe "1," . 7 . "g/Filename:.*/s//Filename: " .expand("%")
  au bufnewfile *.py exe "1," . 7 . "g/Date Created:.*/s//Date Created: " .strftime("%Y-%m-%d")
  au bufnewfile *.py exe "normal! /\\V[Description]\<cr>vf]"

augroup END

augroup cleanup
  " when saving
  " remember current cursor location
  au BufWritePre,FileWritePre * exe "normal mq"
  " trim bad whitespace
  au BufWritePre,FileWritePre *.py silent! exe "%s/\\v(\\S|^)\\zs\\s+\\ze$//g"
  " trim trailing newlines
  au BufWritePre,FileWritePre *.py silent! exe "%s/\\v\\n*%$//g"
  " return to cursor position
  au BufWritePre,FileWritePre * silent! exe "normal `q"
  au BufWritePre,FileWritePre * silent! exe ":delmarks q"
augroup END



if &term =~ '256color'
      " COMES FROM" https://superuser.com/questions/457911/in-vim-background-color-changes-on-scrolling/588243
      " Disable Background Color Erase (BCE) so that color schemes
      "     " work properly when Vim is used inside tmux and GNU screen.
      set t_ut=

endif
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

call SourceIfExists("~/.config-work/vimrc")




