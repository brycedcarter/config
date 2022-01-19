"######################################################################################
"################ MANAGED FILE ########################################################
"######################################################################################
"# This file should not be edited except in its original location of ~/config/vimrc
"######################################################################################

" BRYCE'S USAGE NOTES
" <leader> = <space>


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
Plugin 'tpope/vim-fugitive' " Git extension
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


" set the leader
let mapleader=" "


" Plugin Config 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" disable automatic keybindings for all plugins (except spellunker because it does not support it) 
let g:gitgutter_map_keys = 0 " remove git gutter key mappings
let g:NERDCreateDefaultMappings = 0 "remove nerd tree key mappings
let g:buffergator_suppress_keymaps=1 " remove buffergator key mappings

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
let g:cpp_experimental_simple_template_highlight=1
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
let g:ycm_collect_identifiers_from_tags_files=1
let g:ycm_error_symbol = '>>'
let g:ycm_warning_symbol = '!'
nnoremap <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>


" NERDTree
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" add back default mapping
map <C-n> :NERDTreeToggle<CR>
let NERDTreeIgnore=['\.pyc$', '\~$']

" Buffergator 
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" add back default mapping
nnoremap <leader>b :BuffergatorToggle<cr>

" tagbar customization
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:tagbar_autoclose=1 " close the tagbar after jumping to a tag
let g:tagbar_autofocus=1 " jump to the tag bar when it is opened
let g:tagbar_show_data_type = 1 " show the tag type to its right
let g:no_status_line = 1 " don't display the status line
let g:tagbar_sort = 0 " sort by document order rather than name (outline)
let g:tagbar_map_close = "<leader>o" " use same mapping to open and close
nnoremap <silent> <leader>o :TagbarToggle<cr>

" SimpyFold
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:SimpylFold_docstring_preview=1

" UndoTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>u :UndotreeToggle<cr>


" UndoTree
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nnoremap <leader>/ :call nerdcommenter#Comment('n', 'toggle')<CR>
vnoremap <leader>/ :call nerdcommenter#Comment('x', 'toggle')<CR>


" Workarounds
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if $VIM_CRONTAB == "true"
set backupcopy=yes
endif



inoremap jk <esc>



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
nnoremap <leader>f /\v\c
" case insensitive regex search

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
nnoremap <leader>r :%snomagic/
vnoremap <leader>r :snomagic/

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


" Resize splits on window resize.
augroup AutoResizeSplits
   autocmd!
   autocmd VimResized * exe "normal! \<c-w>="
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




