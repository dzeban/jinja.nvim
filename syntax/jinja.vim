" Vim syntax file
" Language:     Jinja2 template
" Maintainer:   Claude
" Last Change:  2025-10-21

if exists("b:current_syntax")
  finish
endif

" Jinja template syntax
syntax case match

" Comments
syntax region jinjaComment start="{#" end="#}" contains=jinjaTodo
syntax keyword jinjaTodo contained TODO FIXME XXX NOTE

" Variable blocks
syntax region jinjaVariable start="{{" end="}}" contains=jinjaFilter,jinjaOperator,jinjaString,jinjaNumber,jinjaKeyword

" Statement blocks
syntax region jinjaStatement start="{%" end="%}" contains=jinjaTagBlock,jinjaFilter,jinjaOperator,jinjaString,jinjaNumber,jinjaKeyword

" Jinja tags
syntax keyword jinjaTagBlock contained if elif else endif for endfor block endblock extends include
syntax keyword jinjaTagBlock contained macro endmacro call endcall filter endfilter set endset
syntax keyword jinjaTagBlock contained raw endraw autoescape endautoescape with endwith
syntax keyword jinjaTagBlock contained do break continue import from as scoped ignore missing
syntax keyword jinjaTagBlock contained pluralize trans endtrans blocktrans endblocktrans

" Operators
syntax match jinjaOperator contained /[+\-*/%]/
syntax match jinjaOperator contained /[<>=!]=\?/
syntax match jinjaOperator contained /|/
syntax keyword jinjaOperator contained and or not in is

" Filters (after pipe)
syntax match jinjaFilter contained /|\s*\w\+/

" Strings
syntax region jinjaString contained start=/"/ skip=/\\"/ end=/"/
syntax region jinjaString contained start=/'/ skip=/\\'/ end=/'/

" Numbers
syntax match jinjaNumber contained /\d\+\(\.\d\+\)\?/

" Keywords and built-in functions
syntax keyword jinjaKeyword contained true false none True False None
syntax keyword jinjaKeyword contained range lipsum dict cycler joiner namespace

" Special variables
syntax keyword jinjaSpecial contained loop super self varargs kwargs

" Define highlighting
highlight def link jinjaComment Comment
highlight def link jinjaTodo Todo
highlight def link jinjaVariable Identifier
highlight def link jinjaStatement PreProc
highlight def link jinjaTagBlock Statement
highlight def link jinjaOperator Operator
highlight def link jinjaFilter Function
highlight def link jinjaString String
highlight def link jinjaNumber Number
highlight def link jinjaKeyword Keyword
highlight def link jinjaSpecial Special

let b:current_syntax = "jinja"
