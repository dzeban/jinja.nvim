" ftdetect/jinja.vim
" Detect Jinja template files

au BufNewFile,BufRead *.jinja,*.jinja2,*.j2 setfiletype jinja

" Salt Stack state files often use Jinja templating
au BufNewFile,BufRead *.sls setfiletype jinja
