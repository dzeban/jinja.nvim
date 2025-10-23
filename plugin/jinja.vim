" plugin/jinja.vim
" Global plugin settings for Jinja support
" Sets vim-matchup defaults for Jinja templates before any buffers load

" Only load once
if exists('g:loaded_jinja_plugin')
  finish
endif
let g:loaded_jinja_plugin = 1

" Configure vim-matchup for Jinja templates with long control structures
" Default matchparen_stopline is 400 lines, which is too small for templates
" where if/else blocks can be hundreds of lines apart
if !exists('g:matchup_matchparen_stopline')
  let g:matchup_matchparen_stopline = 1000
endif
