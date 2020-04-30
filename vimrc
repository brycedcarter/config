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
" tiggle folding: <leader><space>
" get docs for function <leader>d
" go to definition for function <leader>g
" add marker: m[a-z0-9]
" remove all markers from line: m-
" list markers: m/ 
" toggle file tree view ctrl+n 
" 
"



set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
"Plugin 'wikitopian/hardmode'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Valloric/YouCompleteMe'
Plugin 'kshenoy/vim-signature'
"Plugin 'jewes/Conque-Shell'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'tmhedberg/SimpylFold'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'vim-syntastic/syntastic'
Plugin 'nvie/vim-flake8'
Plugin 'preservim/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
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

" ycm customization
let g:ycm_autoclose_preview_window_after_completion=1
nnoremap <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>d  :YcmCompleter GetDoc<CR>
map <C-n> :NERDTreeToggle<CR>

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

" add pep8 support for .py files
au BufNewFile,BufRead *.py
      \ set tabstop=4 |
      \ set softtabstop=4 |
      \ set shiftwidth=4 |
      \ set textwidth=79 |
      \ set expandtab |
      \ set autoindent |
      \ set fileformat=unix |

" better pane navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

if &term =~ '256color'
      " COMES FROM" https://superuser.com/questions/457911/in-vim-background-color-changes-on-scrolling/588243
      " Disable Background Color Erase (BCE) so that color schemes
      "     " work properly when Vim is used inside tmux and GNU screen.
      set t_ut=
endif
