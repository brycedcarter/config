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
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Valloric/YouCompleteMe'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'preservim/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
Plugin 'mbbill/undotree'
Plugin 'kamykn/spelunker.vim'
Plugin 'jeetsukumaran/vim-buffergator'
Plugin 'universal-ctags/ctags'
Plugin 'majutsushi/tagbar'
Plugin 'airblade/vim-gitgutter'
Plugin 'kien/ctrlp.vim'
Plugin 'voldikss/vim-floaterm'
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
set hlsearch
set incsearch
set backspace=2
inoremap jk <esc>
colorscheme brycedcarter
syntax enable
set clipboard=unnamed
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

" spelunker setup
set nospell
set spellfile=~/.spellfile.utf-8.add
let g:spelunker_check_type = 1
highlight SpelunkerSpellBad cterm=underline ctermfg=247 gui=underline guifg=#9e9e9e
highlight SpelunkerComplexOrCompoundWord cterm=underline ctermfg=NONE gui=underline guifg=NONE

" syntastic customization
let g:syntastic_python_checkers = ['flake8'] " use flake8 as the python syntax checker
let g:syntastic_python_flake8_args = '--per-file-ignores="__init__.py:F401"'

" ycm customization
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>d  :YcmCompleter GetDoc<CR>
map <C-n> :NERDTreeToggle<CR>

" buffergator customization
let g:buffergator_suppress_keymaps=1
nnoremap <leader>b :BuffergatorToggle<cr>

" tagbar customization
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
nnoremap <leader><space> za
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
nnoremap <leader>F ?\v

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

