Plug 'mattn/emmet-vim'

let g:user_emmet_settings       = { 
    \ 'indentation' : '    ',
    \ 'vue': {
    \ 'extends' : 'html'
    \}}
let g:user_emmet_leader_key     = '<c-f>'
let g:user_emmet_expandabbr_key = '<c-f>f'    "e
let g:user_emmet_expandword_key = '<c-f>F'    "e
let g:user_emmet_next_key       = '<c-f>j'    "n
let g:user_emmet_prev_key       = '<c-f>k'    "p
let g:user_emmet_removetag_key  = '<c-f>d'    "k

aug au_emmet_vue
    au!
    " au BufRead,BufNewFile *.vue setf vue
    " autocmd BufRead,BufNewFile *.vue setlocal filetype=vue.html.javascript.css.scss
    autocmd BufRead,BufNewFile *.vue setlocal filetype=vue
    
    " au FileType vue imap <tab> <plug>(emmet-expand-abbr)
    au FileType vue setl sw=2
aug END

Plug 'cakebaker/scss-syntax.vim'
au BufRead,BufNewFile *.scss set filetype=scss.css
au FileType scss set iskeyword+=-


Plug 'maksimr/vim-jsbeautify'

Plug 'mxw/vim-jsx'
let g:jsx_ext_required = 1
Plug 'pangloss/vim-javascript'

Plug 'mustache/vim-mustache-handlebars'

" Plug 'scrooloose/syntastic'
" let g:syntastic_javascript_checkers = ['jsxhint']
" let g:jsx_ext_required = 0
"
" let g:syntastic_css_checkers = ['csslint']
" " ignore the compressed file.
" let g:syntastic_ignore_files = ['\.min\.js\|\.min\.css']
