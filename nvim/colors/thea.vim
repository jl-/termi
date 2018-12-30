hi clear
if exists('syntax_on')
  syntax reset
endif

set t_Co=256
let g:colors_name='thea'

" Palette {{{
let s:palette = {}
let s:palette.red            = { "gui": "#ff5370", "cterm": "204",  "cterm16": "1" }
let s:palette.light_red      = { "gui": "#ff869a", "cterm": "204",  "cterm16": "1" }
let s:palette.dark_red       = { "gui": "#BE5046", "cterm": "196",  "cterm16": "9" }
let s:palette.green          = { "gui": "#C3E88D", "cterm": "114",  "cterm16": "2" }
let s:palette.yellow         = { "gui": "#ffcb6b", "cterm": "180",  "cterm16": "3" }
let s:palette.dark_yellow    = { "gui": "#F78C6C", "cterm": "173",  "cterm16": "11" }
let s:palette.blue           = { "gui": "#82b1ff", "cterm": "39",   "cterm16": "4" }
let s:palette.purple         = { "gui": "#c792ea", "cterm": "170",  "cterm16": "5" }
let s:palette.cyan           = { "gui": "#89DDFF", "cterm": "38",   "cterm16": "6" }
let s:palette.white          = { "gui": "#bfc7d5", "cterm": "145",  "cterm16": "7" }
let s:palette.black          = { "gui": "#292D3E", "cterm": "235",  "cterm16": "0" }
let s:palette.visual_black   = { "gui": "NONE",    "cterm": "NONE", "cterm16": "0" }
let s:palette.comment_grey   = { "gui": "#697098", "cterm": "59",   "cterm16": "15" }
let s:palette.gutter_fg_grey = { "gui": "#4B5263", "cterm": "238",  "cterm16": "15" }
let s:palette.cursor_grey    = { "gui": "#2C323C", "cterm": "236",  "cterm16": "8" }
let s:palette.visual_grey    = { "gui": "#3E4452", "cterm": "237",  "cterm16": "15" }
let s:palette.menu_grey      = { "gui": "#3E4452", "cterm": "237",  "cterm16": "8" }
let s:palette.special_grey   = { "gui": "#3B4048", "cterm": "238",  "cterm16": "15" }
let s:palette.vertsplit      = { "gui": "#181A1F", "cterm": "59",   "cterm16": "15" }
" }}}

function! s:h(group, style)
  let l:ctermfg = (has_key(a:style, "fg") ? a:style.fg.cterm : "NONE")
  let l:ctermbg = (has_key(a:style, "bg") ? a:style.bg.cterm : "NONE")
  execute "highlight" a:group
    \ "guifg="   (has_key(a:style, "fg")    ? a:style.fg.gui   : "NONE")
    \ "guibg="   (has_key(a:style, "bg")    ? a:style.bg.gui   : "NONE")
    \ "guisp="   (has_key(a:style, "sp")    ? a:style.sp.gui   : "NONE")
    \ "gui="     (has_key(a:style, "gui")   ? a:style.gui      : "NONE")
    \ "ctermfg=" . l:ctermfg
    \ "ctermbg=" . l:ctermbg
    \ "cterm="   (has_key(a:style, "cterm") ? a:style.cterm    : "NONE")
endfunction

" Syntax Groups (descriptions and ordering from `:h w18`) {{{
call s:h("Comment", { "fg": s:palette.comment_grey, "gui": "italic", "cterm": "italic" }) " any comment
call s:h("Constant", { "fg": s:palette.cyan }) " any constant
call s:h("String", { "fg": s:palette.green }) " a string constant: \"this is a string\"
call s:h("Character", { "fg": s:palette.green }) " a character constant: 'c', '\n'
call s:h("Number", { "fg": s:palette.dark_yellow }) " a number constant: 234, 0xff
call s:h("Boolean", { "fg": s:palette.red }) " a boolean constant: TRUE, false
call s:h("Float", { "fg": s:palette.dark_yellow }) " a floating point constant: 2.3e10
call s:h("Identifier", { "fg": s:palette.red }) " any variable name
call s:h("Function", { "fg": s:palette.blue }) " function name (also: methods for classes)
call s:h("Statement", { "fg": s:palette.purple }) " any statement
call s:h("Conditional", { "fg": s:palette.purple }) " if, then, else, endif, switch, etc.
call s:h("Repeat", { "fg": s:palette.purple }) " for, do, while, etc.
call s:h("Label", { "fg": s:palette.purple }) " case, default, etc.
call s:h("Operator", { "fg": s:palette.cyan }) " sizeof, '+', '*', etc.
call s:h("Keyword", { "fg": s:palette.red }) " any other keyword
call s:h("Exception", { "fg": s:palette.purple }) " try, catch, throw
call s:h("PreProc", { "fg": s:palette.yellow }) " generic Preprocessor
call s:h("Include", { "fg": s:palette.blue }) " preprocessor #include
call s:h("Define", { "fg": s:palette.purple }) " preprocessor #define
call s:h("Macro", { "fg": s:palette.purple }) " same as Define
call s:h("PreCondit", { "fg": s:palette.yellow }) " preprocessor #if, #else, #endif, etc.
call s:h("Type", { "fg": s:palette.yellow }) " int, long, char, etc.
call s:h("StorageClass", { "fg": s:palette.yellow }) " static, register, volatile, etc.
call s:h("Structure", { "fg": s:palette.yellow }) " struct, union, enum, etc.
call s:h("Typedef", { "fg": s:palette.yellow }) " A typedef
call s:h("Special", { "fg": s:palette.blue }) " any special symbol
call s:h("SpecialChar", {}) " special character in a constant
call s:h("Tag", {}) " you can use CTRL-] on this
call s:h("Delimiter", {}) " character that needs attention
call s:h("SpecialComment", { "fg": s:palette.comment_grey }) " special things inside a comment
call s:h("Debug", {}) " debugging statements
call s:h("Underlined", { "gui": "underline", "cterm": "underline" }) " text that stands out, HTML links
call s:h("Ignore", {}) " left blank, hidden
call s:h("Error", { "fg": s:palette.red }) " any erroneous construct
call s:h("Todo", { "fg": s:palette.purple }) " anything that needs extra attention; mostly the keywords TODO FIXME and XXX
" }}}

" Highlighting Groups (descriptions and ordering from `:h hitest.vim`) {{{
call s:h("ColorColumn", { "bg": s:palette.cursor_grey }) " used for the columns set with 'colorcolumn'
call s:h("Conceal", {}) " placeholder characters substituted for concealed text (see 'conceallevel')
call s:h("Cursor", { "fg": s:palette.black, "bg": s:palette.blue }) " the character under the cursor
call s:h("CursorIM", {}) " like Cursor, but used when in IME mode
call s:h("CursorColumn", { "gui": "BOLD" }) " the screen column that the cursor is in when 'cursorcolumn' is set
call s:h("CursorLine", { "gui": "BOLD" }) " the screen line that the cursor is in when 'cursorline' is set
call s:h("Directory", { "fg": s:palette.blue }) " directory names (and other special names in listings)
call s:h("DiffAdd", { "bg": s:palette.green, "fg": s:palette.black }) " diff mode: Added line
call s:h("DiffChange", { "bg": s:palette.yellow, "fg": s:palette.black }) " diff mode: Changed line
call s:h("DiffDelete", { "bg": s:palette.red, "fg": s:palette.black }) " diff mode: Deleted line
call s:h("DiffText", { "bg": s:palette.black, "fg": s:palette.yellow }) " diff mode: Changed text within a changed line
call s:h("ErrorMsg", { "fg": s:palette.red }) " error messages on the command line
call s:h("VertSplit", { "fg": s:palette.vertsplit }) " the column separating vertically split windows
call s:h("Folded", { "fg": s:palette.comment_grey }) " line used for closed folds
call s:h("FoldColumn", {}) " 'foldcolumn'
call s:h("SignColumn", {}) " column where signs are displayed
call s:h("IncSearch", { "fg": s:palette.yellow, "bg": s:palette.comment_grey }) " 'incsearch' highlighting; also used for the text replaced with ':s///c'
call s:h("LineNr", { "fg": s:palette.gutter_fg_grey }) " Line number for ':number' and ':#' commands, and when 'number' or 'relativenumber' option is set.
call s:h("CursorLineNr", {}) " Like LineNr when 'cursorline' or 'relativenumber' is set for the cursor line.
call s:h("MatchParen", { "fg": s:palette.blue, "gui": "underline" }) " The character under the cursor or just before it, if it is a paired bracket, and its match.
call s:h("ModeMsg", {}) " 'showmode' message (e.g., "-- INSERT --")
call s:h("MoreMsg", {}) " more-prompt
call s:h("NonText", { "fg": s:palette.special_grey }) " '~' and '@' at the end of the window, characters from 'showbreak' and other characters that do not really exist in the text (e.g., '>' displayed when a double-wide character doesn't fit at the end of the line).
call s:h("Normal", { "fg": s:palette.white, "bg": s:palette.black }) " normal text
call s:h("Pmenu", { "bg": s:palette.menu_grey }) " Popup menu: normal item.
call s:h("PmenuSel", { "fg": s:palette.black, "bg": s:palette.blue }) " Popup menu: selected item.
call s:h("PmenuSbar", { "bg": s:palette.special_grey }) " Popup menu: scrollbar.
call s:h("PmenuThumb", { "bg": s:palette.white }) " Popup menu: Thumb of the scrollbar.
call s:h("Question", { "fg": s:palette.purple }) " hit-enter prompt and yes/no questions
call s:h("Search", { "fg": s:palette.black, "bg": s:palette.yellow }) " Last search pattern highlighting (see 'hlsearch'). Also used for highlighting the current line in the quickfix window and similar items that need to stand out.
call s:h("SpecialKey", { "fg": s:palette.special_grey }) " Meta and special keys listed with ':map', also for text used to show unprintable characters in the text, 'listchars'. Generally: text that is displayed differently from what it really is.
call s:h("SpellBad", { "fg": s:palette.red, "gui": "underline", "cterm": "underline" }) " Word that is not recognized by the spellchecker. This will be combined with the highlighting used otherwise.
call s:h("SpellCap", { "fg": s:palette.dark_yellow }) " Word that should start with a capital. This will be combined with the highlighting used otherwise.
call s:h("SpellLocal", { "fg": s:palette.dark_yellow }) " Word that is recognized by the spellchecker as one that is used in another region. This will be combined with the highlighting used otherwise.
call s:h("SpellRare", { "fg": s:palette.dark_yellow }) " Word that is recognized by the spellchecker as one that is hardly ever used. spell This will be combined with the highlighting used otherwise.
call s:h("StatusLine", { "fg": s:palette.white, "bg": s:palette.cursor_grey }) " status line of current window
call s:h("StatusLineNC", { "fg": s:palette.comment_grey }) " status lines of not-current windows Note: if this is equal to 'StatusLine' Vim will use '^^^' in the status line of the current window.
call s:h("TabLine", { "fg": s:palette.comment_grey }) " tab pages line, not active tab page label
call s:h("TabLineFill", {}) " tab pages line, where there are no labels
call s:h("TabLineSel", { "fg": s:palette.white }) " tab pages line, active tab page label
call s:h("Title", { "fg": s:palette.green }) " titles for output from ":set all", ":autocmd" etc.
call s:h("Visual", { "fg": s:palette.visual_black, "bg": s:palette.visual_grey }) " Visual mode selection
call s:h("VisualNOS", { "bg": s:palette.visual_grey }) " Visual mode selection when vim is 'Not Owning the Selection'. Only X11 Gui's gui-x11 and xterm-clipboard supports this.
call s:h("WarningMsg", { "fg": s:palette.yellow }) " warning messages
call s:h("WildMenu", { "fg": s:palette.black, "bg": s:palette.blue }) " current match in 'wildmenu' completion
" }}}

" Language-Specific Highlighting {{{
" Shell
call s:h("shSet", { "fg": s:palette.cyan })
call s:h("shSetOption", { "fg": s:palette.white })
call s:h("shStatement", { "fg": s:palette.cyan })
call s:h("shFunctionKey", { "fg": s:palette.purple })

" HTML
call s:h("htmlTitle", { "fg": s:palette.white })
call s:h("htmlArg", { "fg": s:palette.yellow })
call s:h("htmlEndTag", { "fg": s:palette.cyan })
call s:h("htmlH1", { "fg": s:palette.white })
call s:h("htmlLink", { "fg": s:palette.purple })
call s:h("htmlSpecialChar", { "fg": s:palette.dark_yellow })
call s:h("htmlSpecialTagName", { "fg": s:palette.red })
call s:h("htmlTag", { "fg": s:palette.cyan })
call s:h("htmlTagName", { "fg": s:palette.red })

" CSS
call s:h("cssAttrComma", { "fg": s:palette.purple })
call s:h("cssAttributeSelector", { "fg": s:palette.green })
call s:h("cssBraces", { "fg": s:palette.white })
call s:h("cssClassName", { "fg": s:palette.dark_yellow })
call s:h("cssClassNameDot", { "fg": s:palette.dark_yellow })
call s:h("cssDefinition", { "fg": s:palette.purple })
call s:h("cssFontAttr", { "fg": s:palette.dark_yellow })
call s:h("cssFontDescriptor", { "fg": s:palette.purple })
call s:h("cssFunctionName", { "fg": s:palette.blue })
call s:h("cssIdentifier", { "fg": s:palette.blue })
call s:h("cssImportant", { "fg": s:palette.purple })
call s:h("cssInclude", { "fg": s:palette.white })
call s:h("cssIncludeKeyword", { "fg": s:palette.purple })
call s:h("cssMediaType", { "fg": s:palette.dark_yellow })
call s:h("cssPseudoClassId", { "fg": s:palette.dark_yellow })
call s:h("cssSelectorOp2", { "fg": s:palette.purple })
call s:h("cssTagName", { "fg": s:palette.red })
call s:h("cssColor", { "fg": s:palette.dark_yellow })
call s:h("cssCommonAttr", { "fg": s:palette.blue })
call s:h("cssProp", { "fg": s:palette.cyan })
call s:h("cssSelectorOp", { "fg": s:palette.white })
call s:h("cssUnitDecorators", { "fg": s:palette.yellow })

" Sass
" https:palette.//github.com/tpope/vim-haml
call s:h("sassAmpersand", { "fg": s:palette.red })
call s:h("sassClass", { "fg": s:palette.dark_yellow })
call s:h("sassControl", { "fg": s:palette.purple })
call s:h("sassExtend", { "fg": s:palette.purple })
call s:h("sassFor", { "fg": s:palette.white })
call s:h("sassFunction", { "fg": s:palette.cyan })
call s:h("sassId", { "fg": s:palette.blue })
call s:h("sassInclude", { "fg": s:palette.purple })
call s:h("sassMedia", { "fg": s:palette.purple })
call s:h("sassMediaOperators", { "fg": s:palette.white })
call s:h("sassMixin", { "fg": s:palette.purple })
call s:h("sassMixinName", { "fg": s:palette.blue })
call s:h("sassMixing", { "fg": s:palette.purple })
call s:h("sassVariable", { "fg": s:palette.dark_yellow })
" https:palette.//github.com/cakebaker/scss-syntax.vim
call s:h("scssExtend", { "fg": s:palette.purple })
call s:h("scssExtendedSelector", { "fg": s:palette.dark_yellow })
call s:h("scssFunctionName", { "fg": s:palette.cyan })
call s:h("scssImport", { "fg": s:palette.purple })
call s:h("scssInclude", { "fg": s:palette.purple })
call s:h("scssMixin", { "fg": s:palette.purple })
call s:h("scssMixinName", { "fg": s:palette.blue })
call s:h("scssSelectorName", { "fg": s:palette.yellow })
call s:h("scssVariable", { "fg": s:palette.dark_yellow })

" JavaScript
call s:h("javaScriptBraces", { "fg": s:palette.white })
call s:h("javaScriptFunction", { "fg": s:palette.purple })
call s:h("javaScriptIdentifier", { "fg": s:palette.purple })
call s:h("javaScriptNull", { "fg": s:palette.dark_yellow })
call s:h("javaScriptNumber", { "fg": s:palette.dark_yellow })
call s:h("javaScriptRequire", { "fg": s:palette.cyan })
call s:h("javaScriptReserved", { "fg": s:palette.purple })
" https:palette.//github.com/pangloss/vim-javascript
call s:h("jsArrowFunction", { "fg": s:palette.purple })
call s:h("jsClassKeyword", { "fg": s:palette.purple })
call s:h("jsClassDefinition", { "fg": s:palette.yellow })
call s:h("jsClassMethodType", { "fg": s:palette.purple })
call s:h("jsClassFuncName", { "fg": s:palette.blue })
call s:h("jsDestructuringBlock", { "fg": s:palette.blue })
call s:h("jsDocParam", { "fg": s:palette.blue })
call s:h("jsDocTags", { "fg": s:palette.purple })
call s:h("jsExport", { "fg": s:palette.purple })
call s:h("jsExportDefault", { "fg": s:palette.red })
call s:h("jsExtendsKeyword", { "fg": s:palette.purple })
call s:h("jsConditional", { "fg": s:palette.purple })
call s:h("jsOperator", { "fg": s:palette.purple })
call s:h("jsFrom", { "fg": s:palette.purple })
call s:h("jsFuncArgs", { "fg": s:palette.blue })
call s:h("jsFuncCall", { "fg": s:palette.blue })
call s:h("jsFuncName", { "fg": s:palette.blue })
call s:h("jsObjectProp", { "fg": s:palette.cyan })
call s:h("jsFunction", { "fg": s:palette.purple })
call s:h("jsGenerator", { "fg": s:palette.yellow })
call s:h("jsGlobalObjects", { "fg": s:palette.yellow })
call s:h("jsImport", { "fg": s:palette.purple })
call s:h("jsModuleAs", { "fg": s:palette.purple })
call s:h("jsModuleWords", { "fg": s:palette.purple })
call s:h("jsModuleKeyword", { "fg": s:palette.blue })
call s:h("jsModules", { "fg": s:palette.purple })
call s:h("jsNull", { "fg": s:palette.dark_yellow })
call s:h("jsStorageClass", { "fg": s:palette.purple })
call s:h("jsSuper", { "fg": s:palette.red })
call s:h("jsTemplateBraces", { "fg": s:palette.dark_red })
call s:h("jsTemplateVar", { "fg": s:palette.green })
call s:h("jsThis", { "fg": s:palette.red })
call s:h("jsUndefined", { "fg": s:palette.dark_yellow })
" call s:h("jsVariableDef", { "fg": s:palette.blue })
" https:palette.//github.com/othree/yajs.vim
call s:h("javascriptArrowFunc", { "fg": s:palette.purple })
call s:h("javascriptClassExtends", { "fg": s:palette.purple })
call s:h("javascriptClassKeyword", { "fg": s:palette.purple })
call s:h("javascriptDocNotation", { "fg": s:palette.purple })
call s:h("javascriptDocParamName", { "fg": s:palette.blue })
call s:h("javascriptDocTags", { "fg": s:palette.purple })
call s:h("javascriptEndColons", { "fg": s:palette.white })
call s:h("javascriptExport", { "fg": s:palette.purple })
call s:h("javascriptFuncArg", { "fg": s:palette.white })
call s:h("javascriptFuncKeyword", { "fg": s:palette.purple })
call s:h("javascriptIdentifier", { "fg": s:palette.red })
call s:h("javascriptImport", { "fg": s:palette.purple })
call s:h("javascriptMethodName", { "fg": s:palette.white })
call s:h("javascriptObjectLabel", { "fg": s:palette.white })
call s:h("javascriptOpSymbol", { "fg": s:palette.cyan })
call s:h("javascriptOpSymbols", { "fg": s:palette.cyan })
call s:h("javascriptPropertyName", { "fg": s:palette.green })
call s:h("javascriptTemplateSB", { "fg": s:palette.dark_red })
call s:h("javascriptVariable", { "fg": s:palette.purple })

" TypeScript
call s:h("typescriptReserved", { "fg": s:palette.purple })
call s:h("typescriptEndColons", { "fg": s:palette.white })
call s:h("typescriptBraces", { "fg": s:palette.white })

" JSON
call s:h("jsonCommentError", { "fg": s:palette.white })
call s:h("jsonKeyword", { "fg": s:palette.blue })
call s:h("jsonBoolean", { "fg": s:palette.red })
call s:h("jsonNumber", { "fg": s:palette.dark_yellow })
call s:h("jsonQuote", { "fg": s:palette.white })
call s:h("jsonMissingCommaError", { "fg": s:palette.red, "gui": "reverse" })
call s:h("jsonNoQuotesError", { "fg": s:palette.red, "gui": "reverse" })
call s:h("jsonNumError", { "fg": s:palette.red, "gui": "reverse" })
call s:h("jsonString", { "fg": s:palette.green })
call s:h("jsonStringSQError", { "fg": s:palette.red, "gui": "reverse" })
call s:h("jsonSemicolonError", { "fg": s:palette.red, "gui": "reverse" })

" Markdown
call s:h("markdownCode", { "fg": s:palette.green })
call s:h("markdownCodeBlock", { "fg": s:palette.green })
call s:h("markdownCodeDelimiter", { "fg": s:palette.green })
call s:h("markdownHeadingDelimiter", { "fg": s:palette.red })
call s:h("markdownRule", { "fg": s:palette.comment_grey })
call s:h("markdownHeadingRule", { "fg": s:palette.comment_grey })
call s:h("htmlH1", { "fg": s:palette.blue })
call s:h("htmlH2", { "fg": s:palette.blue })
call s:h("htmlH3", { "fg": s:palette.blue })
call s:h("htmlH4", { "fg": s:palette.blue })
call s:h("htmlH5", { "fg": s:palette.blue })
call s:h("htmlH6", { "fg": s:palette.blue })
call s:h("mkdDelimiter", { "fg": s:palette.cyan })
call s:h("markdownId", { "fg": s:palette.purple })
call s:h("markdownBlockquote", { "fg": s:palette.comment_grey })
call s:h("markdownItalic", { "fg": s:palette.purple, "gui": "italic", "cterm": "italic" })
call s:h("mkdBold", { "fg": s:palette.yellow, "gui": "bold", "cterm": "bold" })
call s:h("mkdInlineURL", { "fg": s:palette.light_red })
call s:h("mkdListItem", { "fg": s:palette.yellow })
call s:h("markdownOrderedListMarker", { "fg": s:palette.red })
call s:h("markdownIdDeclaration", { "fg": s:palette.blue })
call s:h("mkdLink", { "fg": s:palette.white })
call s:h("markdownLinkDelimiter", { "fg": s:palette.white })
call s:h("mkdURL", { "fg": s:palette.light_red })

" Go
call s:h("goDeclaration", { "fg": s:palette.purple })

" Dockerfile
call s:h("dockerfileKeyword", { "fg": s:palette.purple })

" Ruby
call s:h("rubyAccess", { "fg": s:palette.cyan })
call s:h("rubyBlockParameter", { "fg": s:palette.yellow})
call s:h("rubyBlockParameterList", { "fg": s:palette.white })
call s:h("rubyBoolean", { "fg": s:palette.red })
call s:h("rubyCapitalizedMethod", { "fg": s:palette.blue})
call s:h("rubyClass", { "fg": s:palette.purple})
call s:h("rubyClassName", { "fg": s:palette.yellow })
call s:h("rubyConstant", { "fg": s:palette.yellow })
call s:h("rubyControl", { "fg": s:palette.purple })
call s:h("rubyEscape", { "fg": s:palette.red})
call s:h("rubyFunction", { "fg": s:palette.blue})
call s:h("rubyGlobalVariable", { "fg": s:palette.red})
call s:h("rubyInclude", { "fg": s:palette.cyan})
call s:h("rubyIncluderubyGlobalVariable", { "fg": s:palette.red})
call s:h("rubyInstanceVariable", { "fg": s:palette.red})
call s:h("rubyInterpolation", { "fg": s:palette.cyan })
call s:h("rubyInterpolationDelimiter", { "fg": s:palette.red })
call s:h("rubyModuleName", { "fg": s:palette.white })
call s:h("rubyKeyword", { "fg": s:palette.purple })
call s:h("rubyKeywordAsMethod", { "fg": s:palette.cyan})
call s:h("rubyOperator", { "fg": s:palette.purple })
call s:h("rubyPredefinedConstant", { "fg": s:palette.yellow})
call s:h("rubyPseudoVariable", { "fg": s:palette.blue })
call s:h("rubyRegexp", { "fg": s:palette.white})
call s:h("rubyRegexpDelimiter", { "fg": s:palette.cyan})
call s:h("rubySharpBang", { "fg": s:palette.comment_grey})
call s:h("rubyStringDelimiter", { "fg": s:palette.green})
call s:h("rubySymbol", { "fg": s:palette.blue})

" ERb
call s:h("erubyDelimiter", { "fg": s:palette.red })

" Rails
call s:h("railsAssetPreProc", { "fg": s:palette.comment_grey })
call s:h("railsAssetInclude", { "fg": s:palette.comment_grey })
call s:h("railsAssetIncluded", { "fg": s:palette.comment_grey })
call s:h("rubyRailsMethod", { "fg": s:palette.blue })
call s:h("rubyRailsFilterMethod", { "fg": s:palette.cyan })
call s:h("rubyRailsRenderMethod", { "fg": s:palette.cyan })
call s:h("rubyRailsARAssociationMethod", { "fg": s:palette.cyan })
call s:h("rubyRailsHelperMethod", { "fg": s:palette.cyan })

" RSpec
call s:h("rspecGroupMethods", { "fg": s:palette.white })
call s:h("rspecBeforeAndAfter", { "fg": s:palette.white })

" XML
call s:h("xmlAttrib", { "fg": s:palette.yellow })
call s:h("xmlEndTag", { "fg": s:palette.red })
call s:h("xmlTag", { "fg": s:palette.red })
call s:h("xmlTagName", { "fg": s:palette.red })
" }}}

" Plugin Highlighting {{{
" airblade/vim-gitgutter
hi link GitGutterAdd    SignifySignAdd
hi link GitGutterChange SignifySignChange
hi link GitGutterDelete SignifySignDelete

" mhinz/vim-signify
call s:h("SignifySignAdd", { "fg": s:palette.green })
call s:h("SignifySignChange", { "fg": s:palette.yellow })
call s:h("SignifySignDelete", { "fg": s:palette.red })

" neomake/neomake
call s:h("NeomakeWarningSign", { "fg": s:palette.yellow })
call s:h("NeomakeErrorSign", { "fg": s:palette.red })
call s:h("NeomakeInfoSign", { "fg": s:palette.blue })

" tpope/vim-fugitive
call s:h("diffAdded", { "fg": s:palette.green })
call s:h("diffRemoved", { "fg": s:palette.red })
" }}}

" Git Highlighting {{{
call s:h("gitcommitComment", { "fg": s:palette.comment_grey })
call s:h("gitcommitUnmerged", { "fg": s:palette.green })
call s:h("gitcommitOnBranch", {})
call s:h("gitcommitBranch", { "fg": s:palette.purple })
call s:h("gitcommitDiscardedType", { "fg": s:palette.red })
call s:h("gitcommitSelectedType", { "fg": s:palette.green })
call s:h("gitcommitheader", {})
call s:h("gitcommitUntrackedFile", { "fg": s:palette.cyan })
call s:h("gitcommitDiscardedFile", { "fg": s:palette.red })
call s:h("gitcommitSelectedFile", { "fg": s:palette.green })
call s:h("gitcommitUnmergedFile", { "fg": s:palette.yellow })
call s:h("gitcommitFile", {})
call s:h("gitcommitSummary", { "fg": s:palette.white })
call s:h("gitcommitOverflow", { "fg": s:palette.red })
hi link gitcommitNoBranch gitcommitBranch
hi link gitcommitUntracked gitcommitComment
hi link gitcommitDiscarded gitcommitComment
hi link gitcommitSelected gitcommitComment
hi link gitcommitDiscardedArrow gitcommitDiscardedFile
hi link gitcommitSelectedArrow gitcommitSelectedFile
hi link gitcommitUnmergedArrow gitcommitUnmergedFile
" }}}

" Neovim terminal colors {{{
if has("nvim")
  let g:terminal_color_0 =  s:palette.black.gui
  let g:terminal_color_1 =  s:palette.red.gui
  let g:terminal_color_2 =  s:palette.green.gui
  let g:terminal_color_3 =  s:palette.yellow.gui
  let g:terminal_color_4 =  s:palette.blue.gui
  let g:terminal_color_5 =  s:palette.purple.gui
  let g:terminal_color_6 =  s:palette.cyan.gui
  let g:terminal_color_7 =  s:palette.white.gui
  let g:terminal_color_8 =  s:palette.visual_grey.gui
  let g:terminal_color_9 =  s:palette.dark_red.gui
  let g:terminal_color_10 = s:palette.green.gui " No dark version
  let g:terminal_color_11 = s:palette.dark_yellow.gui
  let g:terminal_color_12 = s:palette.blue.gui " No dark version
  let g:terminal_color_13 = s:palette.purple.gui " No dark version
  let g:terminal_color_14 = s:palette.cyan.gui " No dark version
  let g:terminal_color_15 = s:palette.comment_grey.gui
  let g:terminal_color_background = g:terminal_color_0
  let g:terminal_color_foreground = g:terminal_color_7
endif
" }}}
