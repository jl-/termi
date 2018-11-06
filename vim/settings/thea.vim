hi clear
if exists('syntax_on')
  syntax reset
endif

set background=dark
let g:colors_name='thea'

" Palette {{{
let s:palette = {}

let s:palette.black          = '#1C1B19'
let s:palette.red            = '#EF2F27'
let s:palette.green          = '#519F50'
let s:palette.yellow         = '#FBB829'
let s:palette.blue           = '#2C78BF'
let s:palette.magenta        = '#E02C6D'
let s:palette.cyan           = '#0AAEB3'
let s:palette.white          = '#918175'
let s:palette.bright_black   = '#2D2C29'
let s:palette.bright_red     = '#F75341'
let s:palette.bright_green   = '#98BC37'
let s:palette.bright_yellow  = '#FED06E'
let s:palette.bright_blue    = '#68A8E4'
let s:palette.bright_magenta = '#FF5C8F'
let s:palette.bright_cyan    = '#53FDE9'
let s:palette.bright_white   = '#FCE8C3'
let s:palette.orange         = '#D75F00'
let s:palette.bright_orange  = '#FF8700'
let s:palette.hard_black     = '#121212'
let s:palette.xgray1         = '#262626'
let s:palette.xgray2         = '#303030'
let s:palette.xgray3         = '#3A3A3A'
let s:palette.xgray4         = '#444444'
let s:palette.xgray5         = '#4E4E4E'
" }}}

hi Normal           guifg=s:palette.white     guibg=s:palette.magenta       gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=NONE
hi CursorLine       guifg=NONE        guibg=NONE     gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=BOLD
hi CursorColumn     guifg=NONE        guibg=NONE     gui=NONE      ctermfg=NONE        ctermbg=NONE        cterm=BOLD

hi PreProc      cterm=bold ctermfg=75
hi Statement    cterm=bold ctermfg=220
hi Constant     cterm=NONE ctermfg=140
hi Type         cterm=bold ctermfg=112
hi Function     cterm=NONE ctermfg=117
hi Identifier   cterm=bold ctermfg=117

hi Special      cterm=bold ctermfg=203
hi Delimiter    cterm=NONE ctermfg=203

hi Comment      cterm=NONE ctermfg=245
hi Todo         cterm=bold ctermfg=203 ctermbg=NONE

hi LineNr       cterm=NONE ctermfg=240
hi Visual       cterm=NONE ctermbg=241

hi Pmenu        cterm=NONE ctermfg=NONE ctermbg=240
hi PmenuSel     cterm=NONE ctermfg=16 ctermbg=220
hi PmenuSbar    cterm=NONE ctermbg=237
hi PmenuThumb   cterm=NONE ctermbg=239

hi StatusLine   cterm=NONE ctermfg=NONE ctermbg=242
hi StatusLineNC cterm=NONE ctermfg=NONE ctermbg=239
hi WildMenu     cterm=NONE ctermfg=16 ctermbg=220

hi Search       cterm=reverse ctermfg=NONE ctermbg=NONE
hi IncSearch    cterm=reverse ctermfg=NONE ctermbg=NONE

hi DiffAdd      cterm=NONE ctermfg=NONE ctermbg=22
hi DiffDelete   cterm=NONE ctermfg=52 ctermbg=52
hi DiffChange   cterm=NONE ctermfg=NONE ctermbg=235
hi DiffText     cterm=NONE ctermfg=NONE ctermbg=235

hi Folded       cterm=NONE ctermfg=111 ctermbg=NONE
hi FoldColumn   cterm=NONE ctermfg=111 ctermbg=NONE
hi VertSplit    ctermbg=NONE ctermfg=NONE cterm=NONE guibg=NONE guifg=NONE gui=NONE

" misc fixes
hi link xmlEndTag Function
"hi link pythonBuiltin Identifier
