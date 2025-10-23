" ftplugin/jinja.vim
" Filetype plugin for Jinja templates

" Only load this plugin once for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" Save current compatibility options
let s:cpo_save = &cpo
set cpo&vim

" Comment string for commenting lines
setlocal commentstring={#\ %s\ #}

" Set up matching words for vim-matchup plugin and matchit.vim
" Format: start:middle:end
" Supports whitespace control with {%- and -%}
let b:match_words =
  \ '{%-\?\s*\<if\>.*-\?%}:{%-\?\s*\<elif\>.*-\?%}:{%-\?\s*\<else\>\s*-\?%}:{%-\?\s*\<endif\>\s*-\?%},' .
  \ '{%-\?\s*\<for\>.*-\?%}:{%-\?\s*\<else\>\s*-\?%}:{%-\?\s*\<endfor\>\s*-\?%},' .
  \ '{%-\?\s*\<block\>.*-\?%}:{%-\?\s*\<endblock\>.*-\?%},' .
  \ '{%-\?\s*\<macro\>.*-\?%}:{%-\?\s*\<endmacro\>.*-\?%},' .
  \ '{%-\?\s*\<call\>.*-\?%}:{%-\?\s*\<endcall\>.*-\?%},' .
  \ '{%-\?\s*\<filter\>.*-\?%}:{%-\?\s*\<endfilter\>.*-\?%},' .
  \ '{%-\?\s*\<set\>.*-\?%}:{%-\?\s*\<endset\>.*-\?%},' .
  \ '{%-\?\s*\<raw\>.*-\?%}:{%-\?\s*\<endraw\>.*-\?%},' .
  \ '{%-\?\s*\<autoescape\>.*-\?%}:{%-\?\s*\<endautoescape\>.*-\?%},' .
  \ '{%-\?\s*\<with\>.*-\?%}:{%-\?\s*\<endwith\>.*-\?%},' .
  \ '{%-\?\s*\<trans\>.*-\?%}:{%-\?\s*\<endtrans\>.*-\?%},' .
  \ '{%-\?\s*\<blocktrans\>.*-\?%}:{%-\?\s*\<endblocktrans\>.*-\?%}'

" Set up matchit.vim patterns (fallback for vim-matchup)
let b:match_ignorecase = 0

" Note: vim-matchup configuration is in plugin/jinja.vim (loads before buffers)

" Indentation settings
setlocal expandtab
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal tabstop=2

" Enable automatic indentation
setlocal autoindent
setlocal nosmartindent  " smartindent can interfere with template syntax

" Folding settings (optional, can be customized by users)
" setlocal foldmethod=indent
" setlocal foldlevel=99

" Undo ftplugin settings when changing filetype
let b:undo_ftplugin = "setlocal commentstring< expandtab< shiftwidth< softtabstop< tabstop< autoindent< smartindent<"
  \ . " | unlet! b:match_words b:match_ignorecase"

" Restore compatibility options
let &cpo = s:cpo_save
unlet s:cpo_save
