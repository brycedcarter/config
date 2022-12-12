" Vim Color File
" Name:       brycedcarter-bryce.vim

" +----------------+
" | Initialization |
" +----------------+
   runtime colors/colorlib/palette.vim
if !exists('*GetPalette')
  echo "loading"
   runtime colors/colorlib/palette.vim
endif

   runtime colors/colorlib/highlighting.vim
if !exists('*HighlightBasic')
  echo "loading"
   runtime colors/colorlib/highlighting.vim
endif

set background=light

highlight clear

let g:colors_name = 'brycedcarter-warm-light'

if exists("syntax_on")
  syntax reset
endif

set t_Co=256

let g:highlight_default_gui = "bold" " make all highlights bold for the light theme to amke it easier to read
let s:palette = GetPalette("basic", "orange", "red", "yellow", "green", "cyan", "blue", "purple", "light")
call HighlightBasic(s:palette)
