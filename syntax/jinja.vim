" Vim syntax file
" Language:     Jinja2 template
" Maintainer:   Claude
" Last Change:  2025-10-21

" Determine base syntax if specified
" Users can set g:jinja_base_syntax to specify the underlying format
" For example: let g:jinja_base_syntax = 'html'
" If not set, tries to auto-detect from filename patterns

if !exists("g:jinja_base_syntax")
  let g:jinja_base_syntax = ""

  " Auto-detect base syntax from filename patterns
  let s:filename = expand('%:t')
  if s:filename =~? '\.html\?\.\(jinja\|jinja2\|j2\)$'
    let g:jinja_base_syntax = 'html'
  elseif s:filename =~? '\.xml\.\(jinja\|jinja2\|j2\)$'
    let g:jinja_base_syntax = 'xml'
  elseif s:filename =~? '\.ya\?ml\.\(jinja\|jinja2\|j2\)$'
    let g:jinja_base_syntax = 'yaml'
  elseif s:filename =~? '\.s\?css\.\(jinja\|jinja2\|j2\)$'
    let g:jinja_base_syntax = 'css'
  elseif s:filename =~? '\.js\.\(jinja\|jinja2\|j2\)$'
    let g:jinja_base_syntax = 'javascript'
  elseif s:filename =~? '\.\(yaml\|yml\|sls\)$'
    " Salt/Ansible YAML files often use Jinja
    let g:jinja_base_syntax = 'yaml'
  endif
endif

" Load the base syntax if one is set
if g:jinja_base_syntax != ""
  unlet! b:current_syntax
  execute 'runtime! syntax/' . g:jinja_base_syntax . '.vim'
  unlet! b:current_syntax
endif

" Jinja template syntax
syntax case match

" Comments (supports whitespace control with {#- and -#})
syntax region jinjaComment start="{#-\?" end="-\?#}" contains=jinjaTodo containedin=ALL keepend
syntax keyword jinjaTodo contained TODO FIXME XXX NOTE

" Variable blocks (supports whitespace control with {{- and -}})
syntax region jinjaVariable start="{{-\?" end="-\?}}" contains=jinjaFilter,jinjaOperator,jinjaString,jinjaNumber,jinjaKeyword,jinjaSpecial,jinjaFunction,jinjaAttribute,jinjaBuiltin containedin=ALL keepend

" Statement blocks (supports whitespace control with {%- and -%})
syntax region jinjaStatement start="{%-\?" end="-\?%}" contains=jinjaTagBlock,jinjaFilter,jinjaOperator,jinjaString,jinjaNumber,jinjaKeyword,jinjaSpecial,jinjaFunction,jinjaAttribute,jinjaBuiltin containedin=ALL keepend

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

" Common builtin variables and context objects
" SaltStack: pillar, grains, salt, opts
" Flask/Django: request, session, config, g, app
" Ansible: inventory_hostname, group_names, hostvars
syntax keyword jinjaBuiltin contained pillar grains salt opts
syntax keyword jinjaBuiltin contained request session config g app
syntax keyword jinjaBuiltin contained inventory_hostname group_names hostvars

" Function calls (identifier followed by opening parenthesis)
syntax match jinjaFunction contained /\<\w\+\>\ze\s*(/

" Attribute/property access (dot followed by identifier)
syntax match jinjaAttribute contained /\.\@<=\w\+/

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
highlight def link jinjaBuiltin Type
highlight def link jinjaFunction Function
highlight def link jinjaAttribute Identifier

" Sync settings for better performance and accuracy
" Sync by searching for Jinja blocks (including chomped/whitespace-control variants)
syn sync match jinjaSync grouphere NONE "{%"
syn sync match jinjaSync grouphere NONE "{%-"
syn sync match jinjaSync grouphere NONE "{{"
syn sync match jinjaSync grouphere NONE "{{-"
syn sync match jinjaSync grouphere NONE "{#"
syn sync match jinjaSync grouphere NONE "{#-"
syn sync minlines=50
syn sync maxlines=1000

let b:current_syntax = "jinja"
