" Vim Color File
" Name:       brycedcarter-cool-dark.vim


" +----------------+
" | Initialization |
" +----------------+
if !exists('*GetPalette')
   runtime colors/colorlib/palette.vim
endif

if !exists('*H')
   runtime colors/colorlib/highlighting.vim
endif

set background=dark

highlight clear

let g:colors_name = 'brycedcarter-cool-dark'

if exists("syntax_on")
  syntax reset
endif

set t_Co=256

" ARGS:  colorset, alpha, beta, gamma, delta, accent, contrast, flare, mode
let s:palette = GetPalette("basic", "blue", "purple", "cyan", "green", "yellow", "orange", "red", "dark")
call HighlightBasic(s:palette)
