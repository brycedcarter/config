" Tools for highlighing 

" Set to "256" for 256-color terminals, or
" set to "16" to use your terminal emulator's native colors
" (a 16-color palette for this color scheme is available; see
" < https://github.com/joshdick/brycedcarter_dark.vim/blob/master/README.md >
" for more information.)
if !exists("g:brycedcarter_termcolors")
  let g:brycedcarter_termcolors = 256
endif

" Not all terminals support italics properly. If yours does, opt-in.
if !exists("g:brycedcarter_terminal_italics")
  let g:brycedcarter_terminal_italics = 0
endif

let g:highlight_default_fg = "NONE"
let g:highlight_default_bg = "NONE"
let g:highlight_default_sp = "NONE"
let g:highlight_default_gui = "NONE"

" This function was borrowed from FlatColor: https://github.com/MaxSt/FlatColor/
" It was based on one found in hemisu: https://github.com/noahfrederick/vim-hemisu/
function! s:h(group, style)
  "if g:brycedcarter_terminal_italics == 0 && has_key(a:style, "cterm") && a:style["cterm"] == "italic"
    "unlet a:style.cterm
  "endif
  "if g:brycedcarter_termcolors == 16
    "let l:ctermfg = (has_key(a:style, "fg") ? a:style.fg.cterm16 : g:highlight_default_fg)
    "let l:ctermbg = (has_key(a:style, "bg") ? a:style.bg.cterm16 : g:highlight_default_bg)
  "else
    "let l:ctermfg = (has_key(a:style, "fg") ? a:style.fg.cterm : g:highlight_default_fg)
    "let l:ctermbg = (has_key(a:style, "bg") ? a:style.bg.cterm : g:highlight_default_bg)
  "end
  execute "highlight" a:group
    \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg.gui   : g:highlight_default_fg)
    \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg.gui   : g:highlight_default_bg)
    \ "guisp="   (has_key(a:style, "sp")    ? a:style.sp.gui   : g:highlight_default_sp)
    \ "gui="     (has_key(a:style, "gui")   ? a:style.gui      : g:highlight_default_gui)
    "\ "ctermfg=" . l:ctermfg
    "\ "ctermbg=" . l:ctermbg
    "\ "cterm="   (has_key(a:style, "cterm") ? a:style.cterm    : "NONE")
endfunction

function! g:HighlightBasic(palette)
  call s:h("Comment", { "fg": a:palette.deltaprime}) " any comment
  call s:h("Constant", { "fg": a:palette.gammaprime }) " any constant
  call s:h("String", { "fg": a:palette.delta }) " a string constant: "this is a string"
  call s:h("Character", { "fg": a:palette.delta }) " a character constant: 'c', '\n'
  call s:h("Number", { "fg": a:palette.contrast }) " a number constant: 234, 0xff
  call s:h("boolean", { "fg": a:palette.contrast }) " a boolean constant: TRUE, false
  call s:h("Float", { "fg": a:palette.contrastprime }) " a floating point constant: 2.3e10
  call s:h("Identifier", { "fg": a:palette.beta }) " any variable name
  call s:h("Function", { "fg": a:palette.alphaprime }) " function name (also: methods for classes)
  call s:h("Statement", { "fg": a:palette.betaprime }) " any statement
  call s:h("Conditional", { "fg": a:palette.gamma }) " if, then, else, endif, switch, etc.
  call s:h("Repeat", { "fg": a:palette.beta }) " for, do, while, etc.
  call s:h("Label", { "fg": a:palette.betaprime }) " case, default, etc.
  call s:h("Operator", {}) " sizeof", "+", "*", etc.
  call s:h("Keyword", { "fg": a:palette.accentprime }) " any other keyword
  call s:h("Exception", { "fg": a:palette.flareprime }) " try, catch, throw
  call s:h("PreProc", { "fg": a:palette.gamma }) " generic Preprocessor
  call s:h("Include", { "fg": a:palette.gammaprime }) " preprocessor #include
  call s:h("Define", { "fg": a:palette.gamma }) " preprocessor #define
  call s:h("Macro", { "fg": a:palette.gammaprime }) " same as Define
  call s:h("PreCondit", { "fg": a:palette.gamma }) " preprocessor #if, #else, #endif, etc.
  call s:h("Type", { "fg": a:palette.accent }) " int, long, char, etc.
  call s:h("StorageClass", { "fg": a:palette.contrast }) " static, register, volatile, etc.
  call s:h("Structure", { "fg": a:palette.beta }) " struct, union, enum, etc.
  call s:h("Typedef", { "fg": a:palette.accentprime }) " A typedef
  call s:h("Special", { "fg": a:palette.flareprime }) " any special symbol
  call s:h("SpecialChar", {}) " special character in a constant
  call s:h("Tag", {}) " you can use CTRL-] on this
  call s:h("Delimiter", {}) " character that needs attention
  call s:h("SpecialComment", {}) " special things inside a comment
  call s:h("Debug", {}) " debugging statements
  call s:h("Underlined", {}) " text that stands out, HTML links
  call s:h("Ignore", {}) " left blank, hidden
  call s:h("Error", { "fg": a:palette.flare }) " any erroneous construct
  call s:h("Todo", { "fg": a:palette.contrast }) " anything that needs extra attention; mostly the keywords TODO FIXME and XXX

  " +----------------------------------------------------------------------+
  " | Highlighting Groups (descriptions and ordering from `:h hitest.vim`) |
  " +----------------------------------------------------------------------+

  call s:h("ColorColumn", { "bg": a:palette.aftstrong }) " used for the columns set with 'colorcolumn'
  call s:h("Conceal", {}) " placeholder characters substituted for concealed text (see 'conceallevel')
  call s:h("Cursor", { "fg": a:palette.aft, "bg": a:palette.alphaprime }) " the character under the cursor
  call s:h("CursorIM", {}) " like Cursor, but used when in IME mode
  call s:h("CursorColumn", { "bg": a:palette.aft }) " the screen column that the cursor is in when 'cursorcolumn' is set
  call s:h("CursorLine", { "bg": a:palette.aftweak }) " the screen line that the cursor is in when 'cursorline' is set
  call s:h("Directory", {}) " directory names (and other special names in listings)
  call s:h("DiffAdd", { "fg": a:palette.green }) " diff mode: Added line
  call s:h("DiffChange", { "fg": a:palette.blue }) " diff mode: Changed line
  call s:h("DiffDelete", { "fg": a:palette.red }) " diff mode: Deleted line
  call s:h("DiffText", { "bg": a:palette.blue, 'fg': a:palette.aft }) " diff mode: Changed text within a changed line
  call s:h("ErrorMsg", {}) " error messages on the command line
  call s:h("VertSplit", { "fg": a:palette.foreweak }) " the column separating vertically split windows
  call s:h("Folded", { "fg": a:palette.fore }) " line used for closed folds
  call s:h("FoldColumn", {}) " 'foldcolumn'
  call s:h("SignColumn", {}) " column where signs are displayed
  call s:h("IncSearch", { "fg": a:palette.alpha, "bg": a:palette.aft }) " 'incsearch' highlighting; also used for the text replaced with ":s///c"
  call s:h("LineNr", { "fg": a:palette.aftweak }) " Line number for ":number" and ":#" commands, and when 'number' or 'relativenumber' option is set.
  call s:h("CursorLineNr", {"fg": a:palette.delta}) " Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
  call s:h("MatchParen", { "bg": a:palette.gamma, "fg": a:palette.aft, "gui": "underline" }) " The character under the cursor or just before it, if it is a paired bracket, and its match.
  call s:h("ModeMsg", {}) " 'showmode' message (e.g., "-- INSERT --")
  call s:h("MoreMsg", {}) " more-prompt
  call s:h("NonText", { "fg": a:palette.foreweak }) " '~' and '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., ">" displayed when a double-wide character doesn't fit at the end of the line).
  call s:h("Normal", { "fg": a:palette.fore, "bg": a:palette.aft }) " normal text
  call s:h("Pmenu", { "bg": a:palette.aftstrong }) " Popup menu: normal item.
  call s:h("PmenuSel", { "bg": a:palette.beta }) " Popup menu: selected item.
  call s:h("PmenuSbar", { "bg": a:palette.foreweak }) " Popup menu: scrollbar.
  call s:h("PmenuThumb", { "bg": a:palette.forestrong }) " Popup menu: Thumb of the scrollbar.
  call s:h("Question", { "fg": a:palette.contrast }) " hit-enter prompt and yes/no questions
  call s:h("Search", { "fg": a:palette.flarefill, "bg": a:palette.accentprime }) " Last search pattern highlighting (see 'hlsearch'). Also used for highlighting the current line in the quickfix window and similar items that need to stand out.
  call s:h("SpecialKey", { "fg": a:palette.alphaprime }) " Meta and special keys listed with ":map", also for text used to show unprintable characters in the text, 'listchars'. Generally: text that is displayed differently from what it really is.
  call s:h("SpellBad", { "fg": a:palette.flare, "gui": "underline"}) " Word that is not recognized by the spellchecker. This will be combined with the highlighting used otherwise.
  call s:h("SpellCap", { "fg": a:palette.contrastprime }) " Word that should start with a capital. This will be combined with the highlighting used otherwise.
  call s:h("SpellLocal", { "fg": a:palette.contrastprime }) " Word that is recognized by the spellchecker as one that is used in another region. This will be combined with the highlighting used otherwise.
  "call s:h("SpellRare", { "fg": a:palette. }) " Word that is recognized by the spellchecker as one that is hardly ever used. spell This will be combined with the highlighting used otherwise.
  call s:h("StatusLine", { "fg": a:palette.fore, "bg": a:palette.aft }) " status line of current window
  call s:h("StatusLineNC", { "fg": a:palette.foreweak }) " status lines of not-current windows Note: if this is equal to "StatusLine" Vim will use "^^^" in the status line of the current window.
  "call s:h("TabLine", { "fg": a:palette.fore }) " tab pages line, not active tab page label
  "call s:h("TabLineFill", {}) " tab pages line, where there are no labels
  "call s:h("TabLineSel", { "fg": a:palette.red }) " tab pages line, active tab page label
  call s:h("Title", { "fg": a:palette.gamma }) " titles for output from ":set all", ":autocmd" etc.
  call s:h("Visual", {"bg": a:palette.aftweak }) " Visual mode selection
  "call s:h("VisualNOS", { "bg": s:visual_grey }) " Visual mode selection when vim is "Not Owning the Selection". Only X11 Gui's gui-x11 and xterm-clipboard supports this.
  call s:h("WarningMsg", { "fg": a:palette.flareprime }) " warning messages
  call s:h("WildMenu", {"fg": a:palette.contrast}) " current match in 'wildmenu' completion

  if has("nvim")
  "" +--------------------------------+
  "" | Lsp Highlighting |
  "" +--------------------------------+
  call s:h("LspInlayHint", { "fg": a:palette.deltaprime, "bg": a:palette.aftweak })

  "" +--------------------------------+
  "" | Language-Specific Highlighting |
  "" +--------------------------------+

  " C
  call s:h("cCustomFunc", { "fg": a:palette.alphaprime, "gui": "bold" })
  call s:h("cCustomClass", { "fg": a:palette.alpha })
  highlight link cppFloat Float


  "" Markdown
  call s:h("markdownCode", { "fg": a:palette.delta })
  call s:h("markdownCodeBlock", { "fg": a:palette.delta })
  call s:h("markdownCodeDelimiter", { "fg": a:palette.delta })
  call s:h("markdownHeadingDelimiter", { "fg": a:palette.accentprime })
  "call s:h("markdownRule", { "fg": s:comment_grey })
  "call s:h("markdownHeadingRule", { "fg": s:comment_grey })
  call s:h("markdownH1", { "fg": a:palette.accentprime })
  call s:h("markdownH2", { "fg": a:palette.accent })
  call s:h("markdownH3", { "fg": a:palette.accentprime })
  call s:h("markdownH4", { "fg": a:palette.accent })
  call s:h("markdownH5", { "fg": a:palette.accentprime })
  call s:h("markdownH6", { "fg": a:palette.accent })
  call s:h("markdownIdDelimiter", { "fg": a:palette.betaprime })
  call s:h("markdownId", { "fg": a:palette.beta })
  call s:h("markdownBlockquote", { "fg": a:palette.gammaprime, "bg": a:palette.aftweak })
  call s:h("markdownItalic", { "fg": a:palette.foreweak, "gui": "italic", "cterm": "italic" })
  call s:h("markdownBold", { "fg": a:palette.forestrong, "gui": "bold", "cterm": "bold" })
  call s:h("markdownListMarker", { "fg": a:palette.contrast })
  call s:h("markdownOrderedListMarker", { "fg": a:palette.contrast })
  call s:h("markdownIdDeclaration", { "fg": a:palette.beta })
  call s:h("markdownLinkText", { "fg": a:palette.flare })
  call s:h("markdownLinkTextDelimiter", { "fg": a:palette.gammaprime })
  call s:h("markdownLinkDelimiter", { "fg": a:palette.gamma })
  call s:h("markdownUrl", { "fg": a:palette.foreweak })



  "" +---------------------+
  "" | Plugin Highlighting |
  "" +---------------------+

  " hrsh7th/nvim-cmp
  call s:h("CmpItemKind", { "fg": a:palette.beta })

  highlight! link CmpItemAbbrDeprecated Error

  highlight! link CmpItemAbbrMatch String
  highlight! link CmpItemAbbrMatchFuzzy CmpItemAbbrMatch

  highlight! link CmpItemKindVariable Number
  highlight! link CmpItemKindInterface CmpItemKindVariable

  highlight! link CmpItemKindText String

  highlight! link CmpItemKindFunction Function
  highlight! link CmpItemKindMethod CmpItemKindFunction

  highlight! link CmpItemKindKeyword Keyword
  highlight! link CmpItemKindProperty CmpItemKindKeyword
  highlight! link CmpItemKindUnit CmpItemKindKeyword

  " tpope/vim-fugitive
  call s:h("diffAdded", { "fg": a:palette.green })
  call s:h("diffRemoved", { "fg": a:palette.red })

  " simrat39/symbols-outline.nvim
  call s:h("FocusedSymbol", { "bg": a:palette.flarefill })


  "" +------------------+
  "" | Git Highlighting |
  "" +------------------+

  call s:h("gitcommitComment", { "fg": a:palette.fore })
  call s:h("gitcommitUnmerged", { "fg": a:palette.green })
  call s:h("gitcommitOnBranch", {})
  call s:h("gitcommitBranch", { "fg": a:palette.purple })
  call s:h("gitcommitDiscardedType", { "fg": a:palette.red })
  call s:h("gitcommitSelectedType", { "fg": a:palette.green })
  call s:h("gitcommitHeader", {})
  call s:h("gitcommitUntrackedFile", { "fg": a:palette.cyan })
  call s:h("gitcommitDiscardedFile", { "fg": a:palette.red })
  call s:h("gitcommitSelectedFile", { "fg": a:palette.green })
  call s:h("gitcommitUnmergedFile", { "fg": a:palette.yellow })
  call s:h("gitcommitFile", {})
  hi link gitcommitNoBranch gitcommitBranch
  hi link gitcommitUntracked gitcommitComment
  hi link gitcommitDiscarded gitcommitComment
  hi link gitcommitSelected gitcommitComment
  hi link gitcommitDiscardedArrow gitcommitDiscardedFile
  hi link gitcommitSelectedArrow gitcommitSelectedFile
  hi link gitcommitUnmergedArrow gitcommitUnmergedFile


  "" Markup groups from tree-sitter
  highlight! link @markup.heading.1 markdownH1
  highlight! link @markup.heading.2 markdownH2
  highlight! link @markup.heading.3 markdownH3
  highlight! link @markup.heading.4 markdownH4
  highlight! link @markup.heading.5 markdownH5
  highlight! link @markup.heading.6 markdownH6
  highlight! link @markup.heading markdownH1
  highlight! link @markup.quote markdownBlockquote
  highlight! link @markup.strong markdownBold
  highlight! link @markup.italic markdownItalic
  highlight! link @markup.link markdownLinkTextDelimiter
  highlight! link @markup.link.label markdownLinkText
  highlight! link @markup.link.url markdownUrl
  highlight! link @markup.raw markdownCode
  highlight! link @markup.raw.block markdownCode
  highlight! link @markup.list markdownListMarker

  "" +------------------------+
  "" | Neovim terminal colors |
  "" +------------------------+

    let g:terminal_color_0 =  a:palette.aft.gui
    let g:terminal_color_1 =  a:palette.red.gui
    let g:terminal_color_2 =  a:palette.green.gui
    let g:terminal_color_3 =  a:palette.yellow.gui
    let g:terminal_color_4 =  a:palette.blue.gui
    let g:terminal_color_5 =  a:palette.purple.gui
    let g:terminal_color_6 =  a:palette.cyan.gui
    let g:terminal_color_7 =  a:palette.fore.gui
    let g:terminal_color_8 =  a:palette.aftweak.gui
    let g:terminal_color_9 =  a:palette.redprime.gui
    "let g:terminal_color_10 = s:green.gui " No dark version
    let g:terminal_color_11 = a:palette.yellowprime.gui
    "let g:terminal_color_12 = s:blue.gui " No dark version
    "let g:terminal_color_13 = s:purple.gui " No dark version
    "let g:terminal_color_14 = s:cyan.gui " No dark version
    let g:terminal_color_15 = a:palette.foreweak.gui
    let g:terminal_color_background = g:terminal_color_0
    let g:terminal_color_foreground = g:terminal_color_7
  endif
  endfunction
