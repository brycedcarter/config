" Vim Color File
" Name:       brycedcarter-dark.vim


" +----------------+
" | Initialization |
" +----------------+
   runtime colors/colorlib/palette.vim
if !exists('*GetPalette')
  echo "loading"
   runtime colors/colorlib/palette.vim
endif

   runtime colors/colorlib/highlighting.vim
if !exists('*H')
  echo "loading"
   runtime colors/colorlib/highlighting.vim
endif

set background=dark

highlight clear

let g:colors_name = 'brycedcarter-cool-dark'

if exists("syntax_on")
  syntax reset
endif

set t_Co=256

let s:palette = GetPalette("basic", "blue", "purple", "cyan", "green", "yellow", "orange", "red", "dark")
call HighlightBasic(s:palette)
